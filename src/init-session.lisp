
(in-package :simple-blog)

;; Define callback function to initialize new sessions
(defun init-user-session (comp)
  (setf (widget-children comp)
	(make-main-page)))
