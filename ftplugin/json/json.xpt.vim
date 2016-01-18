" Kevin's own XPT snippets for JSON.

XPTemplate priority=personal


let s:f = g:XPTfuncs()

" use snippet 'varConst' to generate contant variables
" use snippet 'varFormat' to generate formatting variables
" use snippet 'varSpaces' to generate spacing variables

XPTinclude
      \ _common/common
      \ json/json

function! s:f.rfc3339() "{{{
  return strftime('%FT%TZ')
endfunction "}}}

" Begin the XPT snippets
XPTemplateDef

XPT last_modified hint=Last-modified\ date
XSET timestamp=rfc3339()
"lastModified": "`timestamp^",
..XPT

XPT device_descriptor hint=OSVR\ device\ descriptor
XSET timestamp=rfc3339()
{
    "deviceVendor": "`vendor^",
    "deviceName": "`product^",
    "author": "`$author^ <`$email^>",
    "version": 1,
    "lastModified": "`timestamp^",
    "interfaces": {
        "analog": {
            "count": `analog_count^
        },
        "button": {
            "count": `button_count^
        },
        "tracker": {
            "count": `tracker_count^
        },
    }
}

..XPT

