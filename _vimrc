" vim: set ts=4 sw=4 sts=0:
"-----------------------------------------------------------------------------
" Vim version : 7.3.154
" 
" ����_vimrc�t�@�C����Windows�p�ł��B
"
"-----------------------------------------------------------------------------
" �����R�[�h�֘A
"
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	" iconv��eucJP-ms�ɑΉ����Ă��邩���`�F�b�N
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	" iconv��JISX0213�ɑΉ����Ă��邩���`�F�b�N
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	" fileencodings���\�z
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	" �萔������
	unlet s:enc_euc
	unlet s:enc_jis
endif
" ���{����܂܂Ȃ��ꍇ�� fileencoding �� encoding ���g���悤�ɂ���
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" ���s�R�[�h�̎����F��
set fileformats=unix,dos,mac
" ���Ƃ����̕����������Ă��J�[�\���ʒu������Ȃ��悤�ɂ���
if exists('&ambiwidth')
	set ambiwidth=double
endif

"-----------------------------------------------------------------------------
" �ҏW�֘A
"
"�I�[�g�C���f���g����
set autoindent
"�o�C�i���ҏW(xxd)���[�h�ivim -b �ł̋N���A�������� *.bin �Ŕ������܂��j
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | silent %!xxd -g 1
	autocmd BufReadPost * set ft=xxd | endif
	autocmd BufWritePre * if &binary | %!xxd -r | endif
	autocmd BufWritePost * if &binary | silent %!xxd -g 1
	autocmd BufWritePost * set nomod | endif
augroup END

"-----------------------------------------------------------------------------
" �����֘A
"
"���������񂪏������̏ꍇ�͑啶������������ʂȂ���������
set ignorecase
"����������ɑ啶�����܂܂�Ă���ꍇ�͋�ʂ��Č�������
set smartcase
"�������ɍŌ�܂ōs������ŏ��ɖ߂�
set wrapscan
"������������͎��ɏ����Ώە�����Ƀq�b�g�����Ȃ�
set noincsearch

"-----------------------------------------------------------------------------
" �����֘A
"
"�V���^�b�N�X�n�C���C�g��L���ɂ���
if has("syntax")
	syntax on
endif
"�s�ԍ���\������
set number
"�^�u�̍����ɃJ�[�\���\��
set listchars=tab:\ \ 
set list
"�^�u����ݒ肷��
set tabstop=4
set shiftwidth=4
"���͒��̃R�}���h���X�e�[�^�X�ɕ\������
set showcmd
"���ʓ��͎��̑Ή����銇�ʂ�\��
set showmatch
"�������ʕ�����̃n�C���C�g��L���ɂ���
set hlsearch
"�X�e�[�^�X���C������ɕ\��
set laststatus=2
"�X�e�[�^�X���C���ɕ����R�[�h�Ɖ��s������\������
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"-----------------------------------------------------------------------------
" �}�b�v��`
"
"�o�b�t�@�ړ��p�L�[�}�b�v
" F2: �O�̃o�b�t�@
" F3: ���̃o�b�t�@
" F4: �o�b�t�@�폜
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
"�\���s�P�ʂōs�ړ�����
nnoremap j gj
nnoremap k gk
"�t���[���T�C�Y��ӑĂɕύX����
map <kPlus> <C-W>+
map <kMinus> <C-W>-

colorcheme darkblue

" �o�b�N�A�b�v�t�@�C��(filename~)���쐬����t�H���_�̎w��
set backupdir=E:\temp

" �X���b�v�t�@�C��(filename.swp)���쐬����t�H���_�̎w��
set directory=E:\temp

"_vimrc���J��
nnoremap <Space>. : <C-u>edit $MYVIMRC<Enter>

"_vimrc��ǂݍ���
nnoremap <Space>s. : <C-u>source $MYVIMRC<Enter>
