(ns tidb.os
  "Customized OS Implemention."
  (:use clojure.tools.logging)
  (:require [jepsen.os :as os]
            [jepsen.control :as c]
            [jepsen.net :as net]
            [jepsen.util :refer [meh]]
            [clojure.string :as str]))

(defn setup-hostfile!
  "Makes sure the hostfile has a loopback entry for the local hostname"
  []
  (let [name    (c/exec :hostname)
        hosts   (c/exec :cat "/etc/hosts")
        hosts'  (->> hosts
                     str/split-lines
                     (map (fn [line]
                            (if (and (re-find #"^127\.0\.0\.1" line)
                                     (not (re-find (re-pattern name) line)))
                              (str line " " name)
                              line)))
                     (str/join "\n"))]
    (c/su (c/exec :echo hosts' :> "/etc/hosts"))))

(deftype CentOS []
  os/OS
  (setup! [_ test node]
    (info node "setting up centos (offline)")
    (setup-hostfile!)
    (meh (net/heal! (:net test) test)))

  (teardown! [_ test node]))

(def centos-offline (CentOS.))
