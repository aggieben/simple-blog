;;;; mode: common-lisp; mode: paredit; mode: slime
(in-package :simple-blog)

(defclass user ()
  ((id)
   (name :accessor user-name
	 :initarg :name
	 :initform ""
	 :type string)
   (email :accessor user-email
	  :initarg :email
	  :initform "")
   (pw-hash :accessor user-pw-hash
	    :initarg :pw-hash
	    :initform nil)))

(defun all-users (&rest args)
  (declare (ignore args))
  (find-persistent-objects (class-store 'user) 'user))
