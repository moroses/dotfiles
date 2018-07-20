" LaTeX related bindings
" ======================
"

" LaTeX compile
" =============
autocmd FileType tex imap <C-L> <ESC> :w:!pdflatex % i
autocmd FileType tex let @l=':w:!pdflatex %'

" LaTeX shortcuts
" ===============

autocmd FileType tex inoremap <leader><SPACE> <ESC>/<++><CR>"_c4l
autocmd FileType tex inoremap <leader>; <++>
" LaTeX common things
autocmd FileType tex inoremap ;a \begin{align}<CR><CR>\end{align}<CR><++><ESC>2ki
autocmd FileType tex inoremap ;A \begin{align*}<CR><CR>\end{align*}<CR><++><ESC>2ki
autocmd FileType tex inoremap ;s \begin{split}<CR><CR>\end{split}<CR><++><ESC>2ki
autocmd FileType tex inoremap ;sec \section{}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;ssec \subsection{}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;l \label{}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;ls \label{sec:}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;le \label{eq:}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;lf \label{fig:}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;lt \label{tab:}<CR><++><ESC>kf}i
autocmd FileType tex inoremap ;b \begin{block}{}<CR><++><CR>\end{block}<CR><++><ESC>3k^f}f}i
autocmd FileType tex inoremap ;ba \begin{alertblock}{}<CR><++><CR>\end{alertblock}<CR><++><ESC>3k^f}f}i
autocmd FileType tex inoremap ;be \begin{exampleblock}{}<CR><++><CR>\end{exampleblock}<CR><++><ESC>3k^f}f}i

autocmd FileType tex inoremap ;it \item<CR><++><ESC>k0fmA<SPACE>
autocmd FileType tex inoremap ;enum \begin{enumerate}<CR><CR>\end{enumerate}<CR><++><ESC>kki
autocmd FileType tex inoremap ;lst \begin{itemize}<CR><CR>\end{itemize}<CR><++><ESC>kki

autocmd FileType tex inoremap <C-C> \(\) <++><ESC>F(li
" LaTeX Greek letters and different characters
autocmd FileType tex inoremap `al \alpha
autocmd FileType tex inoremap `be \beta
autocmd FileType tex inoremap `ch \chi
autocmd FileType tex inoremap `de \delta
autocmd FileType tex inoremap `ep \epsilon
autocmd FileType tex inoremap `et \eta
autocmd FileType tex inoremap `ga \gamma
autocmd FileType tex inoremap `io \iota
autocmd FileType tex inoremap `ka \kappa
autocmd FileType tex inoremap `la \lambda
autocmd FileType tex inoremap `mu \mu
autocmd FileType tex inoremap `nu \nu
autocmd FileType tex inoremap `ome \omega
autocmd FileType tex inoremap `omi \omicron
autocmd FileType tex inoremap `ph \phi
autocmd FileType tex inoremap `pi \pi
autocmd FileType tex inoremap `ps \psi
autocmd FileType tex inoremap `rh \rho
autocmd FileType tex inoremap `si \sigma
autocmd FileType tex inoremap `ta \tau
autocmd FileType tex inoremap `th \theta
autocmd FileType tex inoremap `up \upsilon
autocmd FileType tex inoremap `xi \xi
autocmd FileType tex inoremap `ze \zeta
autocmd FileType tex inoremap `Al \Alpha
autocmd FileType tex inoremap `Be \Beta
autocmd FileType tex inoremap `Ch \Chi
autocmd FileType tex inoremap `De \Delta
autocmd FileType tex inoremap `Ep \Epsilon
autocmd FileType tex inoremap `Et \Eta
autocmd FileType tex inoremap `Ga \Gamma
autocmd FileType tex inoremap `Io \Iota
autocmd FileType tex inoremap `Ka \Kappa
autocmd FileType tex inoremap `La \Lambda
autocmd FileType tex inoremap `Mu \Mu
autocmd FileType tex inoremap `Nu \Nu
autocmd FileType tex inoremap `Ome \Omega
autocmd FileType tex inoremap `Omi \Omicron
autocmd FileType tex inoremap `Ph \Phi
autocmd FileType tex inoremap `Ps \Psi
autocmd FileType tex inoremap `Rh \Rho
autocmd FileType tex inoremap `Si \Sigma
autocmd FileType tex inoremap `Ta \Tau
autocmd FileType tex inoremap `Th \Theta
autocmd FileType tex inoremap `Up \Upsilon
autocmd FileType tex inoremap `Xi \Xi
autocmd FileType tex inoremap `Ze \Zeta
autocmd FileType tex inoremap `vep \varepsilon
autocmd FileType tex inoremap `vph \varphi
autocmd FileType tex inoremap `vpi \varpi
autocmd FileType tex inoremap `vsi \varsigma
autocmd FileType tex inoremap `vth \vartheta
