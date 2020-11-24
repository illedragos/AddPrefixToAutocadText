;(En) run APPLOAD command in Autocad;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;this program adds a prefix (default value "Nr.Cad ") for all selected items;;;;;;;;;;;;;;;

;(RO) ruleaza APPLOAD in Autocad;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;programul adauga un prefix (valoarea default "Nr.Cad ") pentru toate elementele selectate;

;;;;;;;;;;;;;;;;;;;;;;;;
;;;Made by DragoShell;;;
;;;;;;;;;;;;;;;;;;;;;;;;

(defun C:DRAGOS (/ tset len tent tdat tstr pre x)
  (prompt "\nSelect text to prefix: ")
  (setq tset (ssget '((-4 .  "<OR") (0 . "TEXT") (0 . "ATTDEF") (0 . "MTEXT") (-4 . "OR>")))
        len (sslength tset)
  )
  (setq pre "Nr.Cad ")
  (prompt (strcat "\n Enter new prefix (default value : " pre ") "))
  (if (/= (setq x (getstring T)) "")(setq pre x))
  (repeat len
    (setq tent (ssname tset 0)
          tdat (entget tent)
          tstr (cdr (assoc 1 tdat))
    )
    (ssdel (ssname tset 0) tset)
    (redraw tent 3)
    (setq tdat (subst (cons 1 (strcat pre tstr)) (assoc 1 tdat) tdat))
    (entmod tdat)
    (redraw tent 4)
  )
  (princ)
)