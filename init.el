(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)

(defconst demo-packages
  '(anzu
    company
    duplicate-thing
    ggtags
    helm
    helm-gtags
    helm-swoop
    function-args
    clean-aindent-mode
    comment-dwim-2
    dtrt-indent
    ws-butler
    iedit
    yasnippet
    smartparens
    sml-mode
    projectile
    volatile-highlights
    undo-tree
    zygospore))

(defun install-packages ()
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package demo-packages)
    (unless (package-installed-p package)
      (package-install package))))

(install-packages)

;; this variables must be set before load helm-gtags
;; you can change to any prefix key of your choice
(setq helm-gtags-prefix-key "\C-cg")

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-helm)
(require 'setup-helm-gtags)
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)

(windmove-default-keybindings)

;; function-args
(require 'function-args)
(fa-config-default)
(define-key c-mode-map  [(tab)] 'moo-complete)
(define-key c++-mode-map  [(tab)] 'moo-complete)

;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(delete 'company-semantic company-backends)
(define-key c-mode-map  [(control tab)] 'company-complete)
(define-key c++-mode-map  [(control tab)] 'company-complete)

;; company-c-headers
(add-to-list 'company-backends 'company-c-headers)

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq
 c-default-style "linux" ;; set style to "linux"
 )

(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; Package: clean-aindent-mode
(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;; Package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)

;; Package: ws-butler
(require 'ws-butler)
(add-hook 'prog-mode-hook 'ws-butler-mode)

;; Package: yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Package: smartparens
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

;; Package: projejctile
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

;; Package zygospore
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(ede-project-directories (quote ("c:/_LIU/WORK/20141212_INC-TP_QNX" "c:/_LIU/WORK/FPGA_Enhanced_Telemetry_20141218/temp_Enhanced_Telemetry_FPGA_ADC_DAC_Rev_D/upmodem_txrx_ch2/hdl" "c:/_LIU/WORK/FPGA_Enhanced_Telemetry_20141218/temp_Enhanced_Telemetry_FPGA_ADC_DAC_Rev_D/upmodem_txrx_ch1" "c:/_LIU/WORK/FPGA_Enhanced_Telemetry_20141218/temp_Enhanced_Telemetry_FPGA_ADC_DAC_Rev_D/upmodem_txrx_ch1/hdl")))
 '(global-hl-line-mode t)
 '(global-semantic-idle-summary-mode nil)
 '(projectile-global-mode t)
 '(send-mail-function (quote mailclient-send-it))
 '(user-full-name "Zhengjie (Jack) Liu")
 '(vhdl-basic-offset 3)
 '(vhdl-company-name "Halliburton Energy Services")
 '(vhdl-indent-tabs-mode t)
 '(vhdl-project "upmodem_txrx_ch1_vhdl_project")
 '(vhdl-project-alist (quote (("upmodem_txrx_ch1_vhdl_project" "Enhanced Telemetry FPGA" "C:\\_LIU\\WORK\\FPGA_Enhanced_Telemetry_20141218\\temp_Enhanced_Telemetry_FPGA_ADC_DAC_Rev_D\\upmodem_txrx_ch1/" ("./hdl/" "./constraint/") "" (("ModelSim" "-87 \\2" "-f \\1 top_level" nil) ("Synopsys" "-vhdl87 \\2" "-f \\1 top_level" ((".*/datapath/.*" . "-optimize \\3") (".*_tb\\.vhd")))) "lib/" "example3_lib" "lib/example3/" "Makefile_\\2" "") ("Example 2" "Individual source files, multiple compilers in different directories" "$EXAMPLE2/" ("vhdl/system.vhd" "vhdl/component_*.vhd") "" nil "\\1/" "work" "\\1/work/" "Makefile" "") ("Example 3" "Source files in a directory tree, multiple compilers in same directory" "/home/me/example3/" ("-r ./*/vhdl/") "/CVS/" nil "./" "work" "work-\\1/" "Makefile-\\1" "-------------------------------------------------------------------------------
-- This is a multi-line project description
-- that can be used as a project dependent part of the file header.
")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "outline" :slant normal :weight normal :height 128 :width normal)))))
 
;; default location
(setq default-directory "C:/_LIU/WORK/")
 
;; package sr-speedbar
(require 'sr-speedbar)

;; change c-z to UNDO
	;; Unbind Pesky Sleep Button
	(global-unset-key [(control z)])
	(global-unset-key [(control x)(control z)])
	;; Windows Style Undo
    (global-set-key [(control z)] 'undo)

;; enable line number mod
(global-linum-mode 1)
;; enable highlight current line mode
(hl-line-mode 1)

; nyan mode directory
(add-to-list 'load-path "~/.emacs.d/nyan-mode-master")

;; load the packaged named nyan-mode.
;; best not to include the ending “.el” or “.elc”
(load "nyan-mode") 
(nyan-mode 1)
