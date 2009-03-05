
(defpackage #:simple-blog
  (:use :cl :weblocks :cl-who
	:metabang.utilities)
  (:documentation
   "A web application based on Weblocks."))

(in-package :simple-blog)

(export '(start-simple-blog stop-simple-blog))

(defwebapp simple-blog
    :prefix "/"
    :description "simple-blog: An example application"
    :init-user-session 'simple-blog::init-user-session
    :autostart nil                   ;; have to start the app manually
    :dependencies '((:stylesheet "navigation"))
    :ignore-default-dependencies nil
    :debug t) ;; accept the defaults

(defvar *msg-log-path* 
  #p"/tmp/simple-blog-msg.log")
(defvar *access-log-path*
  #p"/tmp/simple-blog-access.log")

(defun start-simple-blog (&rest args)
  "Starts the application by calling 'start-weblocks' with appropriate
arguments."
  (setf hunchentoot:*message-log-pathname* *msg-log-path*)
  (setf hunchentoot:*access-log-pathname* *access-log-path*)
  (apply #'start-weblocks args)
  (start-webapp 'simple-blog))

(defun stop-simple-blog ()
  "Stops the application by calling 'stop-weblocks'."
  (stop-webapp 'simple-blog)
  (stop-weblocks))

