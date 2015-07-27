;;js2 mode
(live-add-pack-lib "js2")
(require 'js2-mode)
;(add-to-list 'auto-mode-list '("\\.json$" . js-mode))

(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(setq js2-highlight-level 3)

(defun my-paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

(define-key js2-mode-map "{" 'paredit-open-curly)
(define-key js2-mode-map "}" 'paredit-close-curly-and-newline)




(eval-after-load "mfc-pack"
  '(progn
     (install-packages-pack/install-packs
      '(ac-js2
        expand-region
        js2-refactor
        discover-js2-refactor
        tern
        tern-auto-complete))
     ;; (add-hook 'js2-mode-hook 'my-paredit-nonlisp)
     (require 'js2-refactor)
     (add-hook 'js2-mode-hook #'js2-refactor-mode)
     (add-hook 'js2-mode-hook '(lambda ()  (js2r-add-keybindings-with-prefix "C-c C-j")))
     (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
     (eval-after-load 'tern
       '(progn
          (require 'tern-auto-complete)
          (tern-ac-setup)))))
