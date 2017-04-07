---
title: My `emacs` Setup
author: ~
date: '2017-04-07'
slug: ''
categories: []
tags: []
description: ''
featured: ''
featuredalt: ''
featuredpath: ''
linktitle: ''
type: 'post'
---

As I've gone further and further down the rabbit hole of computational biology, one thing that has remained with me is my emacs habit. When I first started graduate school and joined the Kleinstein lab, I was learning R and programming as most do in RStudio. However, my life changed when soon after, Stefan, my best mate, convinced me to give emacs a whirl for R programming.

Since then, I've come to appreciate all the more my decision to program the emacs way. The reasons I've stuck with it are numerous, but the most important are:

* *Flexibility* - emacs has its own shell environment that allows me to simultaneously program in R interactively (via ESS), and switch between the two with ease. This is great for bioinformatics where all too often you need both commandline tools for processing to work in concert with custom analysis scripts
* *Fast* - the fastest way to get around a coding document is via emacs' advanced motion controls; while some IDEs like RStudio allow for emacs keybindings, all too often its incomplete or neutered. Plus, I find running/sending code in emacs to ESS is much faster to do (muscle memory helps too)
* *Customizable* - you can make emacs truly yours in a way no other IDE allows. While I don't go too crazy with this, some customizations are indispensible

On this last point, I wanted to post my current `.emacs` file to show off some of my customizations (a lot of which is thanks to Stefan). The full `.emacs` is posted below, and I'll highlight some of my favorites:

* *Package repo MELPA* - indispensible for extra useful package
* *Auto-complete in ESS* - makes the terminal feel more like a traditional, GUI IDE
* *Poly-mode* - essential for literate programming, here for Rmarkdown `.Rmd` files
* *Disable smart underscore/insert underscore with _* - I hate the default smart underscore because I use a lot of underscore in my variable names, so I turn this off by default and instead insert arrows `<-` with `M--` (meta + dash)

My `.emacs` is fairly vanilla, but I can't imagine programming without these small customizations. 

And while vim certainly has its pluses (its everywhere by default!), emacs will always be my number one.

```
;; Package Repositories --------------------------------------------------------
(package-initialize)
(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")))

;; Auto-complete in ESS -------------------------------------------------------

(defun my-auto-hook ()
  (auto-complete-mode 1)
  ;; Colors
  (set-face-attribute 'popup-tip-face nil :background "#bfbaac" :foreground "black")
  (define-key ac-completing-map [return] nil)
  (define-key ac-completing-map "\r" nil)
  )
(add-hook 'ess-mode-hook 'my-auto-hook)
(add-hook 'inferior-ess-mode-hook 'my-auto-hook)

(ac-config-default)
(setq ess-use-auto-complete t)

;; Poly-mode in Emacs --------------------------------------------------------

(defun rmd-mode ()
  "ESS Markdown mode for rmd files"
  (interactive)
  ;; (setq load-path
  ;; 	(append (list "path/to/polymode/" "path/to/polymode/modes/")
  ;; 		load-path))
  (require 'poly-R)
  (require 'poly-markdown)
    (poly-markdown+r-mode))

;; MISC ------------------------------------------------------------------

;; Stefan Avey (stefan.avey@yale.edu) - "smart" underscore
(global-set-key (kbd "M--")  (lambda () (interactive) (insert " <- ")))

;; Turn off "smart underscore" ess feature
;; (with-eval-after-load 'ess (setq ess-toggle-underscore nil))
;;;; Map C-= to the assignment operator, and leaves _ alone:
(add-hook 'ess-mode-hook
	  (lambda ()
	    ;;        (setq ess-S-assign-key (kbd "C-="))
	    ;;        (ess-toggle-S-assign-key t)     ; enable above key definition
	    (ess-toggle-underscore nil)
	    (ess-toggle-underscore nil)))   ; leave my underscore key alone!

(add-hook 'inferior-ess-mode-hook
	  (lambda ()
	    (ess-toggle-underscore nil)
	    ;;        (setq ess-S-assign-key (kbd "C-="))
	    ;;        (ess-toggle-S-assign-key t)     ; enable above key definition
	    (ess-toggle-underscore nil)
	    (ess-toggle-underscore nil)))   ; leave my underscore key alone!

;; Skip splash screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; ess r package mode disable
;; C-c C-t C-s
(setq ess-r-package-auto-activate nil)

;; Emacs backup files
(setq make-backup-files nil)

;; Backup file management
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Default yes and no settings
(defalias 'yes-or-no-p 'y-or-n-p)

;; Turn off menu and tool bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


;; set custom theme that doesn't override background transparency
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
(load-theme 'wombat-mod' t)  ;; the t is a "no confirm" flag
;; load wombat theme
;; (load-theme 'wombat t)

```

