# astro-ts-mode

Major mode for [astro](https://astro.build) using `treesit`.

![screenshot](screenshot.png)

## Features

- [X] Font Locking
- [ ] Indentation

---

### Code Formatting

To setup Prettier with Astro you can follow the [astro's official docs](https://docs.astro.build/en/editor-setup/#prettier).
Using emacs, I personally use [apheleia](https://github.com/radian-software/apheleia) to format my code on save, config sample:

```elisp
(use-package apheleia
  :init
  (apheleia-global-mode +1)
  :config
  (add-to-list 'apheleia-mode-alist '(astro-ts-mode . prettier)))
```