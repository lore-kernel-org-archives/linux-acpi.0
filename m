From: elbg <elbg-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: Acpica problem?
Date: Mon, 30 Jun 2003 17:16:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F005439.4030705@laposte.net>
References: <Pine.LNX.4.33.0306301311190.1064-100000@frog.athome> <200306301400.12493.hrvoje.habjanic@zg.htnet.hr>
Reply-To: elbg-QFKgK+z4sOrR7s880joybQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200306301400.12493.hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Cc: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Salut,
Me I do not have the files following : "aslcompilerparse.c &=20
aslcompilerlex.c " in the sources of  intel :=20
"acpica-unix-20030619.tar.gz" !

I looked in the directory  "../acpica-unix-20030619/compiler/" and it do =

not have the file there ! I have to check=20
"../acpica-unix-20030619/compiler/Makefile" and they must be there !
It is possible that.??
I does not understand!!

Hrvoje Habjanic a =E9crit :

>On Monday 30 June 2003 13:11, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> =20
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Salut Hrvoje,
>>
>>On Mon, 30 Jun 2003, Hrvoje Habjanic wrote:
>>   =20
>>
>>>[root@xxx acpi]# ./acpica-unix-20030619/compiler/iasl -g
>>>
>>>Intel ACPI Component Architecture
>>>ASL Optimizing Compiler / AML Disassembler version 20030619 [Jun 30 20=
03]
>>>Copyright (C) 2000 - 2003 Intel Corporation
>>>Supports ACPI Specification Revision 2.0b
>>>
>>>Core dump
>>>
>>>I'm dooing something wrong?
>>>     =20
>>>
>>Did you build it from source?
>>   =20
>>
>
>Yep!
>
>
>[root@habi xxx]# cd acpica-unix-20030619/compiler/
>[root@xxx compiler]# make=20
>bison -v -d -y -pAslCompiler aslcompiler.y
>conflicts:  33 shift/reduce, 47 reduce/reduce
>cp y.tab.c aslcompilerparse.c
>cp y.tab.h aslcompiler.y.h
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslcompilerparse.o aslcompilerparse.c
>flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslcompilerlex.o aslcompilerlex.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslanalyze.o aslanalyze.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslcodegen.o aslcodegen.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslcompile.o aslcompile.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslerror.o aslerror.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslfiles.o aslfiles.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o asllength.o asllength.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o asllisting.o asllisting.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslload.o aslload.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o asllookup.o asllookup.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslmain.o aslmain.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslmap.o aslmap.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslopcodes.o aslopcodes.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o asloperands.o asloperands.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslresource.o aslresource.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslrestype1.o aslrestype1.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslrestype2.o aslrestype2.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o asltree.o asltree.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslutils.o aslutils.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o asltransform.o asltransform.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslfold.o aslfold.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslstubs.o aslstubs.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o aslopt.o aslopt.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../common/getopt.o ../common/getopt.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../utilities/utalloc.o ../utilities/utalloc.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../utilities/utcopy.o ../utilities/utcopy.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../utilities/utdebug.o ../utilities/utdebug.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../utilities/utdelete.o ../utilities/utdelete.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../utilities/utglobal.o ../utilities/utglobal.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../utilities/utobject.o ../utilities/utobject.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../utilities/utmisc.o ../utilities/utmisc.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../utilities/utmath.o ../utilities/utmath.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nsaccess.o ../namespace/nsaccess.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nsalloc.o ../namespace/nsalloc.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nsdump.o ../namespace/nsdump.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nsnames.o ../namespace/nsnames.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nsobject.o ../namespace/nsobject.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nsparse.o ../namespace/nsparse.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nssearch.o ../namespace/nssearch.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nsutils.o ../namespace/nsutils.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nswalk.o ../namespace/nswalk.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../namespace/nsxfobj.o ../namespace/nsxfobj.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/parser/psargs.o ../interpreter/parser/psar=
gs.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/parser/psopcode.o ../interpreter/parser/ps=
opcode.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/parser/psparse.o ../interpreter/parser/psp=
arse.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/parser/psscope.o ../interpreter/parser/pss=
cope.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/parser/pstree.o ../interpreter/parser/pstr=
ee.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/parser/psutils.o ../interpreter/parser/psu=
tils.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/parser/pswalk.o ../interpreter/parser/pswa=
lk.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/dispatcher/dswscope.o ../interpreter/dispa=
tcher/dswscope.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/dispatcher/dswstate.o ../interpreter/dispa=
tcher/dswstate.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/dispatcher/dsfield.o ../interpreter/dispat=
cher/dsfield.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/dispatcher/dsobject.o ../interpreter/dispa=
tcher/dsobject.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/dispatcher/dsopcode.o ../interpreter/dispa=
tcher/dsopcode.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/dispatcher/dsutils.o ../interpreter/dispat=
cher/dsutils.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/dispatcher/dswexec.o ../interpreter/dispat=
cher/dswexec.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/dispatcher/dswload.o ../interpreter/dispat=
cher/dswload.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exconvrt.o ../interpreter/execute=
r/exconvrt.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/excreate.o ../interpreter/execute=
r/excreate.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exdump.o ../interpreter/executer/=
exdump.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exmisc.o ../interpreter/executer/=
exmisc.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exmutex.o ../interpreter/executer=
/exmutex.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exnames.o ../interpreter/executer=
/exnames.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exoparg1.o ../interpreter/execute=
r/exoparg1.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exoparg2.o ../interpreter/execute=
r/exoparg2.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exoparg3.o ../interpreter/execute=
r/exoparg3.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exoparg6.o ../interpreter/execute=
r/exoparg6.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exprep.o ../interpreter/executer/=
exprep.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exregion.o ../interpreter/execute=
r/exregion.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exresnte.o ../interpreter/execute=
r/exresnte.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exresolv.o ../interpreter/execute=
r/exresolv.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exresop.o ../interpreter/executer=
/exresop.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exstore.o ../interpreter/executer=
/exstore.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exstoren.o ../interpreter/execute=
r/exstoren.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exstorob.o ../interpreter/execute=
r/exstorob.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exsystem.o ../interpreter/execute=
r/exsystem.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../interpreter/executer/exutils.o ../interpreter/executer=
/exutils.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../common/adisasm.o ../common/adisasm.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../debugger/dbfileio.o ../debugger/dbfileio.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../disassembler/dmbuffer.o ../disassembler/dmbuffer.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../disassembler/dmnames.o ../disassembler/dmnames.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../disassembler/dmopcode.o ../disassembler/dmopcode.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../disassembler/dmobject.o ../disassembler/dmobject.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../disassembler/dmresrc.o ../disassembler/dmresrc.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../disassembler/dmresrcl.o ../disassembler/dmresrcl.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../disassembler/dmresrcs.o ../disassembler/dmresrcs.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../disassembler/dmutils.o ../disassembler/dmutils.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../disassembler/dmwalk.o ../disassembler/dmwalk.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../tables/tbinstal.o ../tables/tbinstal.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../tables/tbutils.o ../tables/tbutils.c
>cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../i=
nclude    -c -o ../osunixxf.o ../osunixxf.c
>cc  aslcompilerparse.o aslcompilerlex.o aslanalyze.o aslcodegen.o aslcom=
pile.o aslerror.o aslfiles.o asllength.o asllisting.o aslload.o asllookup=
=2Eo aslmain.o aslmap.o aslopcodes.o asloperands.o aslresource.o aslresty=
pe1.o aslrestype2.o asltree.o aslutils.o asltransform.o aslfold.o aslstub=
s.o aslopt.o ../common/getopt.o ../utilities/utalloc.o ../utilities/utcop=
y.o ../utilities/utdebug.o ../utilities/utdelete.o ../utilities/utglobal.=
o ../utilities/utobject.o ../utilities/utmisc.o ../utilities/utmath.o ../=
namespace/nsaccess.o ../namespace/nsalloc.o ../namespace/nsdump.o ../name=
space/nsnames.o ../namespace/nsobject.o ../namespace/nsparse.o ../namespa=
ce/nssearch.o ../namespace/nsutils.o ../namespace/nswalk.o ../namespace/n=
sxfobj.o ../interpreter/parser/psargs.o ../interpreter/parser/psopcode.o =
=2E./interpreter/parser/psparse.o ../interpreter/parser/psscope.o ../inte=
rpreter/parser/pstree.o ../interpreter/parser/psutils.o ../interpreter/pa=
rser/pswalk.o ../interpreter/dispatcher/dswscope.o ../interpreter/dispatc=
her/dswstate.o ../interpreter/dispatcher/dsfield.o ../interpreter/dispatc=
her/dsobject.o ../interpreter/dispatcher/dsopcode.o ../interpreter/dispat=
cher/dsutils.o ../interpreter/dispatcher/dswexec.o ../interpreter/dispatc=
her/dswload.o ../interpreter/executer/exconvrt.o ../interpreter/executer/=
excreate.o ../interpreter/executer/exdump.o ../interpreter/executer/exmis=
c.o ../interpreter/executer/exmutex.o ../interpreter/executer/exnames.o .=
=2E/interpreter/executer/exoparg1.o ../interpreter/executer/exoparg2.o ..=
/interpreter/executer/exoparg3.o ../interpreter/executer/exoparg6.o ../in=
terpreter/executer/exprep.o ../interpreter/executer/exregion.o ../interpr=
eter/executer/exresnte.o ../interpreter/executer/exresolv.o ../interprete=
r/executer/exresop.o ../interpreter/executer/exstore.o ../interpreter/exe=
cuter/exstoren.o ../interpreter/executer/exstorob.o ../interpreter/execut=
er/exsystem.o ../interpreter/executer/exutils.o ../common/adisasm.o ../de=
bugger/dbfileio.o ../disassembler/dmbuffer.o ../disassembler/dmnames.o ..=
/disassembler/dmopcode.o ../disassembler/dmobject.o ../disassembler/dmres=
rc.o ../disassembler/dmresrcl.o ../disassembler/dmresrcs.o ../disassemble=
r/dmutils.o ../disassembler/dmwalk.o ../tables/tbinstal.o ../tables/tbuti=
ls.o ../osunixxf.o \
>          -o iasl
>[root@xxx compiler]# ./iasl -g
>
>Intel ACPI Component Architecture
>ASL Optimizing Compiler / AML Disassembler version 20030619 [Jun 30 2003=
]
>Copyright (C) 2000 - 2003 Intel Corporation
>Supports ACPI Specification Revision 2.0b
>
>Segmentation fault
>
>
> =20
>
>>cheers
>>  hartwig felger
>>
>>Hartwig Felger informatics
>>
>>- --
>>1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
>>Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
>>For the pulic keys, please visit my page.
>>-----BEGIN PGP SIGNATURE-----
>>Version: GnuPG v1.2.2 (GNU/Linux)
>>
>>iD8DBQE/ABsD9bBoTzOf1pMRAsgWAJ40y8pmLoTgrpn+H+wrN0Szr4M2qQCgzTVL
>>t3yWu5IzYV+sixQuDzWMM6g=3D
>>=3DxK2h
>>-----END PGP SIGNATURE-----
>>   =20
>>
>
>
>
>-------------------------------------------------------
>This SF.Net email sponsored by: Free pre-built ASP.NET sites including
>Data Reports, E-commerce, Portals, and Forums are available now.
>Download today and enter to win an XBOX or Visual Studio .NET.
>http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01=

>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
> =20
>




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
