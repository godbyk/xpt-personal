" Kevin's own XPT snippets for C++.

XPTemplate priority=personal


let s:f = g:XPTfuncs()

" use snippet 'varConst' to generate contant variables
" use snippet 'varFormat' to generate formatting variables
" use snippet 'varSpaces' to generate spacing variables

XPTvar $TRUE          1
XPTvar $FALSE         0
XPTvar $NULL          NULL
XPTvar $UNDEFINED     NULL

" if () ** {
" else ** {
XPTvar $BRif     ' '

" } ** else {
XPTvar $BRel     ' '

" for () ** {
" while () ** {
" do ** {
XPTvar $BRloop   ' '

" struct name ** {
XPTvar $BRstc    ' '

" int fun() ** {
" class name ** {
XPTvar $BRfun    ' '

" int fun ** (
" class name ** (
XPTvar $SPfun      ''

" int fun( ** arg ** )
" if ( ** condition ** )
" for ( ** statement ** )
" [ ** a, b ** ]
" { ** 'k' : 'v' ** }
XPTvar $SParg      ''

" if ** (
" while ** (
" for ** (
XPTvar $SPcmd      ' '

" a ** = ** a ** + ** 1
" (a, ** b, ** )
XPTvar $SPop       ' '

XPTinclude
      \ _common/common
      \ cpp/cpp

function! s:f.year(...) "{{{
  return strftime("%Y")
endfunction "}}}

function! InsertNameSpace(beginOrEnd)
    let dir = expand('%:p:h')
    let ext = expand('%:e')
    if ext == 'cpp'
        let dir = FSReturnCompanionFilenameString('%')
        let dir = fnamemodify(dir, ':h')
    endif
    let idx = stridx(dir, 'include/')
    let nsstring = ''
    if idx != -1
        let dir = strpart(dir, idx + strlen('include') + 1)
        let nsnames = split(dir, '/')
        let nsdecl = join(nsnames, ' { namespace ')
        let nsdecl = 'namespace '.nsdecl.' {'
        if a:beginOrEnd == 0
            let nsstring = nsdecl . "\n\n"
        else
            for i in nsnames
                let nsstring = nsstring.'} '
            endfor
            let nsstring = "\n".nsstring.'// end namespace '.join(nsnames, '::')
        endif
        let nsstring = "\n" . nsstring
    endif

    return nsstring
endfunction

function! InsertNameSpaceBegin()
    return InsertNameSpace(0)
endfunction

function! InsertNameSpaceEnd()
    return InsertNameSpace(1)
endfunction

function! GetNSFName(snipend)
    let dirAndFile = expand('%:p')
    let idx = stridx(dirAndFile, 'include')
    if idx != -1
        let fname = strpart(dirAndFile, idx + strlen('include') + 1)
    else
        let fname = expand('%:t')
    endif
    if a:snipend == 1
        let fname = expand(fname.':r')
    endif

    return fname
endfunction

function! GetNSFNameDefine()
    let dir = expand('%:p:h')
    let idx = stridx(dir, 'include')
    if idx != -1
        let subdir = strpart(dir, idx + strlen('include') + 1)
        let define = substitute(subdir, '/', '_', 'g')
        let define = define ."_".expand('%:t:r')."_h"
        let define = toupper(define)
        let define = substitute(define, '^_\+', '', '')
        return define
    else
        return toupper(expand('%:t:r'))."_H"
    endif
endfunction

function! GetHeaderForCurrentSourceFile()
    let header=FSReturnCompanionFilenameString('%')
    if stridx(header, '/include/') == -1
        let header = substitute(header, '^.*/include/', '', '')
    else
        let header = substitute(header, '^.*/include/', '', '')
    endif

    return header
endfunction

function! s:f.getNamespaceFilename(...)
    return GetNSFName(0)
endfunction

function! s:f.getNamespaceFilenameDefine(...)
    return GetNSFNameDefine()
endfunction

function! s:f.getHeaderForCurrentSourceFile(...)
    return GetHeaderForCurrentSourceFile()
endfunction

function! s:f.insertNamespaceEnd(...)
    return InsertNameSpaceEnd()
endfunction

function! s:f.insertNamespaceBegin(...)
    return InsertNameSpaceBegin()
endfunction

function! s:f.returnSkeletonsFromPrototypes(...)
    return protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({ 'includeNS' : 0})
endfunction

" Begin the XPT snippets
XPTemplateDef

XPT testfile hint=Test\ cpp\ file\ definition
//
// `$project^
//
// `getNamespaceFilename()^
//
// Authors:
//   Nir Keren <nir@iastate.edu>
//   Kevin M. Godby <kevin@godby.org>
//
// Unpublished Work Copyright (c) `year()^
//

#include <gtest/gtest.h>

`cursor^

int main(int argc, char* argv[])
{
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

..XPT

XPT test hint=Test\ function\ definition
TEST(`TestCaseName^, `TestName^) {
    `cursor^
}

..XPT

XPT testf hint=Test\ fixture\ function\ definition
TEST_F(`TestFixtureClassName^, `TestName^) {
    `cursor^
}

..XPT

XPT at hint=ASSERT_TRUE
ASSERT_TRUE(`condition^);
..XPT

XPT af hint=ASSERT_FALSE
ASSERT_FALSE(`condition^);
..XPT

XPT aeq hint=ASSERT_EQ
ASSERT_EQ(`expected^, `actual^);
..XPT

XPT ane hint=ASSERT_NE
ASSERT_NE(`expected^, `actual^);
..XPT

XPT alt hint=ASSERT_LT
ASSERT_LT(`expected^, `actual^);
..XPT

XPT ale hint=ASSERT_LE
ASSERT_LE(`expected^, `actual^);
..XPT

XPT agt hint=ASSERT_GT
ASSERT_GT(`expected^, `actual^);
..XPT

XPT age hint=ASSERT_GE
ASSERT_GE(`expected^, `actual^);
..XPT

XPT afe hint=ASSERT_FLOAT_EQ
ASSERT_FLOAT_EQ(`expected^, `actual^);
..XPT

XPT ade hint=ASSERT_DOUBLE_EQ
ASSERT_DOUBLE_EQ(`expected^, `actual^);
..XPT

XPT anear hint=ASSERT_NEAR
ASSERT_NEAR(`expected^, `actual^, `tolerance^);
..XPT

XPT astreq hint=ASSERT_STREQ
ASSERT_STREQ(`expected^, `actual^);
..XPT

XPT astrne hint=ASSERT_STRNE
ASSERT_STRNE(`expected^, `actual^);
..XPT

XPT astrcaseeq hint=ASSERT_STRCASEEQ
ASSERT_STRCASEEQ(`expected^, `actual^);
..XPT

XPT astrcasene hint=ASSERT_STRCASENE
ASSERT_STRCASENE(`expected^, `actual^);
..XPT

XPT athrow hint=ASSERT_THROW
ASSERT_THROW(`statement^, `exception_type^);
..XPT

XPT athrowany hint=ASSERT_ANY_THROW
ASSERT_ANY_THROW(`statement^, `exception_type^);
..XPT

XPT anothrow hint=ASSERT_NO_THROW
ASSERT_NO_THROW(`statement^, `exception_type^);
..XPT

XPT et hint=EXPECT_TRUE
EXPECT_TRUE(`condition^);
..XPT

XPT ef hint=EXPECT_FALSE
EXPECT_FALSE(`condition^);
..XPT

XPT eeq hint=EXPECT_EQ
EXPECT_EQ(`expected^, `actual^);
..XPT

XPT ene hint=EXPECT_NE
EXPECT_NE(`expected^, `actual^);
..XPT

XPT elt hint=EXPECT_LT
EXPECT_LT(`expected^, `actual^);
..XPT

XPT ele hint=EXPECT_LE
EXPECT_LE(`expected^, `actual^);
..XPT

XPT egt hint=EXPECT_GT
EXPECT_GT(`expected^, `actual^);
..XPT

XPT ege hint=EXPECT_GE
EXPECT_GE(`expected^, `actual^);
..XPT

XPT estreq hint=EXPECT_STREQ
EXPECT_STREQ(`expected^, `actual^);
..XPT

XPT estrne hint=EXPECT_STRNE
EXPECT_STRNE(`expected^, `actual^);
..XPT

XPT estrcaseeq hint=EXPECT_STRCASEEQ
EXPECT_STRCASEEQ(`expected^, `actual^);
..XPT

XPT estrcasene hint=EXPECT_STRCASENE
EXPECT_STRCASENE(`expected^, `actual^);
..XPT

XPT ethrow hint=EXPECT_THROW
EXPECT_THROW(`statement^, `exception_type^);
..XPT

XPT ethrowany hint=EXPECT_ANY_THROW
EXPECT_ANY_THROW(`statement^, `exception_type^);
..XPT

XPT enothrow hint=EXPECT_NO_THROW
EXPECT_NO_THROW(`statement^, `exception_type^);
..XPT

XPT afe hint=EXPECT_FLOAT_EQ
EXPECT_FLOAT_EQ(`expected^, `actual^);
..XPT

XPT ade hint=EXPECT_DOUBLE_EQ
EXPECT_DOUBLE_EQ(`expected^, `actual^);
..XPT

XPT anear hint=EXPECT_NEAR
EXPECT_NEAR(`expected^, `actual^, `tolerance^);
..XPT

XPT namespace hint=Namespace
namespace `name^ {

`cursor^

} // end namespace `name^

..XPT

XPT try hint=Try/catch\ block
try {
    `what^
} catch (`Exception^& e...^) {
    `handler^
} `...^catch (`Exception^& e...^) {
    `handler^
}`...^
..XPT

XPT tsp hint=Typedef\ of\ a\ smart\ pointer
typedef boost::shared_ptr<`type^> `type^Ptr;
..XPT

XPT sp hint=Smart\ pointer\ usage
`const ^boost::shared_ptr<`type^>& `cursor^
..XPT

XPT fullmain hint=C++\ main\ including\ #includes
#include <map>
#include <vector>
#include <string>
#include <iostream>

using namespace std;

int main(int argv, char* argv[])
{
    `cursor^

    return 0;
}
..XPT

XPT src hint=C++\ implementation\ file
//
// `getNamespaceFilename()^
//
// Copyright (c) `year()^ `$author^
//

#include <`getHeaderForCurrentSourceFile()^>
`insertNamespaceBegin()^`returnSkeletonsFromPrototypes()^`cursor^`insertNamespaceEnd()^
..XPT

XPT header hint=C++\ header\ file
//
// `getNamespaceFilename()^
//
// Copyright (c) `year()^ `$author^ <`$email^>
//

#ifndef `getNamespaceFilenameDefine()^_
#define `getNamespaceFilenameDefine()^_

`insertNamespaceBegin()^/**
 * @brief `classDescription^
 */
class `fileRoot()^
{
public:
    /**
     * Constructor
     */
    `fileRoot()^();

    /**
     * Destructor
     */
    virtual ~`fileRoot()^();

    `cursor^
private:
};`insertNamespaceEnd()^

#endif // `getNamespaceFilenameDefine()^_

..XPT

XPT functor hint=Functor\ definition
struct `FunctorName^
{
    `void^ operator()(`argument^`...^, `arg^`...^)` const^
}
..XPT

XPT class hint=Class\ declaration
//
// Class: `fileRoot()^
// Author: `$author^ <`$email^>
//
// Copyright (c) `year()^ `$author^
//

/**
 * @brief `briefDescription^
 */
class `fileRoot()^
{
public:
    `fileRoot()^(`argument^`...^, `arg^`...^);
    virtual ~`fileRoot()^();
    `cursor^
};
..XPT

XPT hfun hint=Member\ function\ declaration
/**
 * `functionName^
 *
 * `cursor^
 */
`int^ `functionName^(`argument^`...^, `arg^`...^)` const^;
..XPT

XPT css hint=const\ std::string&
const std::string& `cursor^
..XPT

XPT cse hint=const\ std::exception& e
const std::exception& e`cursor^
..XPT

XPT cerr hint=Basic\ std::cerr\ statement
std::cerr << "`cursor^" << std::endl;
..XPT

XPT outcopy hint=Using\ an\ iterator\ to\ output\ to\ stdout
std::copy(`list^.begin(), `list^.end(), std::ostream_iterator<`std::string^>(std::cout, \"\\n\"));
..XPT

XPT boosth hint=Boost\ header\ file\ inclusion
// The boost libraries don't compile well at warning level 4.
// No big surprise here... boost pushes the limits of compilers
// in the extreme.  Warning level 3 is clean.
#pragma warning(push, 3)
#include <boost/`tr1/memory.hpp^>
#pragma warning(pop)
..XPT

XPT copyright hint=Copyright\ notice
//
// `ProjectName^
//
// `getNamespaceFilename()^
//
// Authors:
//   Kevin M. Godby <kevin@godby.org>
//
// Copyright (c) `year()^
//

..XPT


XPT gscopy hint=Greenspace\ copyright\ notice
//
// Greenspace Combine Simulator
//
// `getNamespaceFilename()^
//
// Authors:
//   Greg R. Luecke <grluecke@iastate.edu>
//   Kevin M. Godby <kevin@godby.org>
//   Jesse A. Lane <jesse.a.lane@gmail.com>
//
// Unpublished Work Copyright (c) `year()^
//
// Iowa State University Research Foundation, Inc.
//

..XPT

XPT vtcopy hint=VirtuTrace\ copyright\ notice
//
// VirtuTrace
//
// `getNamespaceFilename()^
//
// Authors:
//   Nir Keren <nir@iastate.edu>
//   Kevin M. Godby <kevin@godby.org>
//
// Unpublished Work Copyright (c) `year()^
//

..XPT

XPT vtguicopy hint=VirtuTrace\ GUI\ copyright\ notice
//
// VirtuTrace
//
// `getNamespaceFilename()^
//
// Authors:
//   Nir Keren <nir@iastate.edu>
//   Kevin M. Godby <kevin@godby.org>
//
// Unpublished Work Copyright (c) `year()^
//
// Based heavily on guichan.  guichan is
// copyright (c) 2004-2008 Olof Naessen and Per Larsson
// and licensed under the BSD license.
//
// For more information about guichan, see:
//   http://code.google.com/p/guichan
//   http://gitorious.org/guichan
//   http://guichan.sf.net/
//

..XPT

XPT lbcopy hint=libBiopac\ copyright\ notice
//
// libBiopac
//
// `getNamespaceFilename()^
//
// Authors:
//   Nir Keren <nir@iastate.edu>
//   Kevin M. Godby <kevin@godby.org>
//   Andrew Montag <ajmontag@gmail.com>
//
// Unpublished Work Copyright (c) `year()^
//

..XPT


XPT defsp hint=Define\ a\ smart\ pointer\ typedef
#include <boost/shared_ptr.hpp>
#include <boost/weak_ptr.hpp>

namespace `namespace^ {

/**
 * A forward declaration of the `BaseClass^ class.
 */
class `BaseClass^;

/**
 * A `Baseclass^Ptr is just a shared pointer for the `Baseclass^ class.
 */
typedef boost::shared_ptr<`Baseclass^> `Baseclass^Ptr;

/**
 * A `Baseclass^WeakPtr is just a weak pointer for the `Baseclass^ class.
 */
typedef boost::shared_ptr<`Baseclass^> `Baseclass^WeakPtr;

} // end namespace `namespace^

..XPT

XPT noop hint=Comment\ 'do\ nothing'
// do nothing

..XPT

XPT once wrap=cursor	" #ifndef .. #define ..
XSET symbol=headerSymbol()
XSET symbol|post=UpperCase(V())
#ifndef `symbol^
#define `symbol^

`cursor^
#endif // `symbol^

..XPT

XPT kgcopy hint=Kevin' copyright\ notice
//
// `getNamespaceFilename()^
//
// Authors:
//   Kevin M. Godby <kevin@godby.org>
//

..XPT

XPT property hint=Property\ accessors\ and\ mutators
`type^ get`PropertyName^() const;
void set`PropertyName^(const `type^& `PropertyName^);
`type^ `PropertyName^LowerCase(V())^^_;
..XPT

XPT main hint=main\ (argc,\ argv)
`c_fun_type_indent()^int`c_fun_body_indent()^main(`$SParg^int argc,`$SPop^char* argv[]`$SParg^)
{
    `cursor^
    return 0;
}
..XPT


