(require 'treesit)
(require 'typescript-ts-mode)
(require 'css-mode)

(defgroup astro-ts nil
  "Major mode for Astro."
  :prefix "astro-ts-"
  :group 'languages)

(defvar astro-ts-mode--font-lock-settings
  (treesit-font-lock-rules
   :language 'astro
   :feature 'astro-font-lock
   `((tag_name) @font-lock-function-name-face
     (erroneous_end_tag_name) @font-lock-warning-face
     (doctype) @font-lock-keyword-face
     (attribute_name) @font-lock-variable-name-face
     (attribute_value) @font-lock-string-face
     (comment) @font-lock-comment-face
     (["<" ">" "</"]) @font-lock-bracket-face)))

(defvar astro-ts--treesit-range-rules
  (treesit-range-rules
   :embed 'tsx
   :host 'astro
   '((frontmatter (raw_text) @injection.content)
     ((interpolation (raw_text) @injection.content))
     ((script_element (raw_text) @injection.content)))

   :embed 'css
   :host 'astro
   '((style_element (raw_text) @injection.content))))

;;;###autoload
(define-derived-mode astro-ts-mode prog-mode "Astro"
  "Major mode for Astro, powered by tree-sitter."
  :group 'astro

  (setq-local treesit-range-settings astro-ts--treesit-range-rules)

  (setq-local treesit-font-lock-settings astro-ts-mode--font-lock-settings)

  ;; import typescript font-lock
  (setq-local treesit-font-lock-settings
	      (append treesit-font-lock-settings
	      	      (typescript-ts-mode--font-lock-settings 'tsx)))

  ;; import css font-lock
  (setq-local treesit-font-lock-settings
	      (append treesit-font-lock-settings
	      	      treesit-font-lock-settings css--treesit-settings))

  (setq-local treesit-font-lock-feature-list
              '((astro-font-lock)

		;; features from tsx
		(comment declaration keyword string escape-sequence constant expression identifier number pattern property function bracket delimiter jsx)

		;; copied from css-mode
		(selector comment query keyword property constant string error variable function operator bracket)))

  (treesit-major-mode-setup))

(if (treesit-ready-p 'astro)
    (add-to-list 'auto-mode-alist '("\\.astro\\'" . astro-ts-mode)))

(provide 'astro-ts-mode)
