;;; org-autoprop.el --- org-capture properties autocomplete  -*- lexical-binding: t -*-

;; Copyright (C) 2018 Aaron R. Shifman
;;
;; Author: Aaron R. Shifman
;; URL: https://github.com/aaronshifman/org-autoprop
;; Package-Requires: ((emacs "25"))
;; Version: 1.0.0
;; Keywords: convenience

;; org-autoprop.el is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; org-autoprop.el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Where :PROP:%^{prop|A|B|C} would go in a capture template
;; %(org-autoprop-format-list \"PROP\") is used instead

;; See https://github.com/aaronshifman/org-autoprop/README.org for details

;;; Code:

(defun org-autoprop-get-props (prop-name) 
  "Get values for PROP-NAME.

Returns a list of all values for property prop-name in an org file

PROP-NAME is the property name to get"
  (org-map-entries (lambda () 
		     (org-entry-get nil  prop-name))))

(defun org-autoprop-format-list (prop-name) 
  "Format PROP-NAME properties as option list.

Properties are formatted as {p1|p2|...}

Some of this was hacked from stack-overflow
superuser.com/questions/984238/how-do-i-get-autocomplete-for-multiple-entries-in-an-org-mode-capture-template"
  (let* ((buffer (if (equal (buffer-name) "*Capture*") 
		     (org-capture-get :buffer) 
		   (current-buffer)))) 
    (with-current-buffer buffer (concat ":" prop-name ": %^{" prop-name "|" (string-join (delq nil
											       (delete-dups
												(org-autoprop-get-props
												 prop-name)))
											 "|") "}"))))

(provide 'org-autoprop)

;;; org-autoprop.el ends here
