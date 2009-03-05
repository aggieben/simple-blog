;; mode: common-lisp; mode: paredit; mode: slime;
(in-package :simple-blog)

(defwidget login-maybe (login)
  ((child-widget :accessor login-maybe-child-widget
		 :initarg :child-widget
		 :documentation "The widget to render if we are already logged in.")
   (dom-id :initform "login"))
  (:documentation "Render login form only if not logged in."))

(defmethod initialize-instance ((self login-maybe) &key &allow-other-keys)
  (call-next-method)
  (setf (widget-continuation self)
	(lambda (&optional auth)
	  (declare (ignore auth))
	  (mark-dirty self))))

(defmethod render-widget-body((self login-maybe) &key &allow-other-keys)
  (cond
    ((authenticatedp)
     (hunchentoot:log-message :debug "=== authenticated! ===")
     (render-widget (login-maybe-child-widget self) :inlinep t))
    (t 
     (hunchentoot:log-message :debug "=== not authenticated! ==")
     (call-next-method))))

(defun check-login (login-widget credentials-obj)
  "Check the user's login credentials"
  (declare (ignore login-widget))
  credentials-obj)

(defun login-success (lw cred-obj)
  (declare (ignore cred-obj))
  (render-widget (login-maybe-child-widget lw)))