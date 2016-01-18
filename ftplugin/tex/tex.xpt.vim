XPTemplate priority=lang mark=`~

let s:f = g:XPTfuncs()

XPTvar $TRUE          1
XPTvar $FALSE         0
XPTvar $NULL          NULL
XPTvar $UNDEFINED     NULL
XPTvar $VOID_LINE     /* void */;
XPTvar $BRif \n

XPTinclude
      \ _common/common
      \ _common/personal

" ========================= Function and Variables =============================

" Don't add spaces inside of braces
XPTvar $SParg      ''



" ================================= Snippets ===================================


