From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: Re: Acpica problem?
Date: Mon, 30 Jun 2003 14:00:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306301400.12493.hrvoje.habjanic@zg.htnet.hr>
References: <Pine.LNX.4.33.0306301311190.1064-100000@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0306301311190.1064-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 30 June 2003 13:11, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Salut Hrvoje,
>
> On Mon, 30 Jun 2003, Hrvoje Habjanic wrote:
> > [root@xxx acpi]# ./acpica-unix-20030619/compiler/iasl -g
> >
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler / AML Disassembler version 20030619 [Jun 30 200=
3]
> > Copyright (C) 2000 - 2003 Intel Corporation
> > Supports ACPI Specification Revision 2.0b
> >
> > Core dump
> >
> > I'm dooing something wrong?
>
> Did you build it from source?

Yep!


[root@habi xxx]# cd acpica-unix-20030619/compiler/
[root@xxx compiler]# make=20
bison -v -d -y -pAslCompiler aslcompiler.y
conflicts:  33 shift/reduce, 47 reduce/reduce
cp y.tab.c aslcompilerparse.c
cp y.tab.h aslcompiler.y.h
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslcompilerparse.o aslcompilerparse.c
flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslcompilerlex.o aslcompilerlex.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslanalyze.o aslanalyze.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslcodegen.o aslcodegen.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslcompile.o aslcompile.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslerror.o aslerror.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslfiles.o aslfiles.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o asllength.o asllength.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o asllisting.o asllisting.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslload.o aslload.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o asllookup.o asllookup.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslmain.o aslmain.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslmap.o aslmap.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslopcodes.o aslopcodes.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o asloperands.o asloperands.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslresource.o aslresource.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslrestype1.o aslrestype1.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslrestype2.o aslrestype2.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o asltree.o asltree.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslutils.o aslutils.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o asltransform.o asltransform.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslfold.o aslfold.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslstubs.o aslstubs.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o aslopt.o aslopt.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../common/getopt.o ../common/getopt.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../utilities/utalloc.o ../utilities/utalloc.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../utilities/utcopy.o ../utilities/utcopy.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../utilities/utdebug.o ../utilities/utdebug.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../utilities/utdelete.o ../utilities/utdelete.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../utilities/utglobal.o ../utilities/utglobal.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../utilities/utobject.o ../utilities/utobject.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../utilities/utmisc.o ../utilities/utmisc.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../utilities/utmath.o ../utilities/utmath.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nsaccess.o ../namespace/nsaccess.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nsalloc.o ../namespace/nsalloc.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nsdump.o ../namespace/nsdump.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nsnames.o ../namespace/nsnames.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nsobject.o ../namespace/nsobject.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nsparse.o ../namespace/nsparse.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nssearch.o ../namespace/nssearch.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nsutils.o ../namespace/nsutils.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nswalk.o ../namespace/nswalk.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../namespace/nsxfobj.o ../namespace/nsxfobj.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/parser/psargs.o ../interpreter/parser/psargs.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/parser/psopcode.o ../interpreter/parser/psopcod=
e.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/parser/psparse.o ../interpreter/parser/psparse.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/parser/psscope.o ../interpreter/parser/psscope.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/parser/pstree.o ../interpreter/parser/pstree.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/parser/psutils.o ../interpreter/parser/psutils.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/parser/pswalk.o ../interpreter/parser/pswalk.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/dispatcher/dswscope.o ../interpreter/dispatcher=
/dswscope.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/dispatcher/dswstate.o ../interpreter/dispatcher=
/dswstate.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/dispatcher/dsfield.o ../interpreter/dispatcher/=
dsfield.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/dispatcher/dsobject.o ../interpreter/dispatcher=
/dsobject.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/dispatcher/dsopcode.o ../interpreter/dispatcher=
/dsopcode.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/dispatcher/dsutils.o ../interpreter/dispatcher/=
dsutils.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/dispatcher/dswexec.o ../interpreter/dispatcher/=
dswexec.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/dispatcher/dswload.o ../interpreter/dispatcher/=
dswload.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exconvrt.o ../interpreter/executer/exc=
onvrt.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/excreate.o ../interpreter/executer/exc=
reate.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exdump.o ../interpreter/executer/exdum=
p.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exmisc.o ../interpreter/executer/exmis=
c.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exmutex.o ../interpreter/executer/exmu=
tex.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exnames.o ../interpreter/executer/exna=
mes.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exoparg1.o ../interpreter/executer/exo=
parg1.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exoparg2.o ../interpreter/executer/exo=
parg2.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exoparg3.o ../interpreter/executer/exo=
parg3.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exoparg6.o ../interpreter/executer/exo=
parg6.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exprep.o ../interpreter/executer/expre=
p.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exregion.o ../interpreter/executer/exr=
egion.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exresnte.o ../interpreter/executer/exr=
esnte.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exresolv.o ../interpreter/executer/exr=
esolv.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exresop.o ../interpreter/executer/exre=
sop.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exstore.o ../interpreter/executer/exst=
ore.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exstoren.o ../interpreter/executer/exs=
toren.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exstorob.o ../interpreter/executer/exs=
torob.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exsystem.o ../interpreter/executer/exs=
ystem.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../interpreter/executer/exutils.o ../interpreter/executer/exut=
ils.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../common/adisasm.o ../common/adisasm.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../debugger/dbfileio.o ../debugger/dbfileio.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../disassembler/dmbuffer.o ../disassembler/dmbuffer.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../disassembler/dmnames.o ../disassembler/dmnames.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../disassembler/dmopcode.o ../disassembler/dmopcode.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../disassembler/dmobject.o ../disassembler/dmobject.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../disassembler/dmresrc.o ../disassembler/dmresrc.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../disassembler/dmresrcl.o ../disassembler/dmresrcl.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../disassembler/dmresrcs.o ../disassembler/dmresrcs.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../disassembler/dmutils.o ../disassembler/dmutils.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../disassembler/dmwalk.o ../disassembler/dmwalk.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../tables/tbinstal.o ../tables/tbinstal.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../tables/tbutils.o ../tables/tbutils.c
cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../incl=
ude    -c -o ../osunixxf.o ../osunixxf.c
cc  aslcompilerparse.o aslcompilerlex.o aslanalyze.o aslcodegen.o aslcompil=
e.o aslerror.o aslfiles.o asllength.o asllisting.o aslload.o asllookup.o as=
lmain.o aslmap.o aslopcodes.o asloperands.o aslresource.o aslrestype1.o asl=
restype2.o asltree.o aslutils.o asltransform.o aslfold.o aslstubs.o aslopt.=
o ../common/getopt.o ../utilities/utalloc.o ../utilities/utcopy.o ../utilit=
ies/utdebug.o ../utilities/utdelete.o ../utilities/utglobal.o ../utilities/=
utobject.o ../utilities/utmisc.o ../utilities/utmath.o ../namespace/nsacces=
s.o ../namespace/nsalloc.o ../namespace/nsdump.o ../namespace/nsnames.o ../=
namespace/nsobject.o ../namespace/nsparse.o ../namespace/nssearch.o ../name=
space/nsutils.o ../namespace/nswalk.o ../namespace/nsxfobj.o ../interpreter=
/parser/psargs.o ../interpreter/parser/psopcode.o ../interpreter/parser/psp=
arse.o ../interpreter/parser/psscope.o ../interpreter/parser/pstree.o ../in=
terpreter/parser/psutils.o ../interpreter/parser/pswalk.o ../interpreter/di=
spatcher/dswscope.o ../interpreter/dispatcher/dswstate.o ../interpreter/dis=
patcher/dsfield.o ../interpreter/dispatcher/dsobject.o ../interpreter/dispa=
tcher/dsopcode.o ../interpreter/dispatcher/dsutils.o ../interpreter/dispatc=
her/dswexec.o ../interpreter/dispatcher/dswload.o ../interpreter/executer/e=
xconvrt.o ../interpreter/executer/excreate.o ../interpreter/executer/exdump=
=2Eo ../interpreter/executer/exmisc.o ../interpreter/executer/exmutex.o ../=
interpreter/executer/exnames.o ../interpreter/executer/exoparg1.o ../interp=
reter/executer/exoparg2.o ../interpreter/executer/exoparg3.o ../interpreter=
/executer/exoparg6.o ../interpreter/executer/exprep.o ../interpreter/execut=
er/exregion.o ../interpreter/executer/exresnte.o ../interpreter/executer/ex=
resolv.o ../interpreter/executer/exresop.o ../interpreter/executer/exstore.=
o ../interpreter/executer/exstoren.o ../interpreter/executer/exstorob.o ../=
interpreter/executer/exsystem.o ../interpreter/executer/exutils.o ../common=
/adisasm.o ../debugger/dbfileio.o ../disassembler/dmbuffer.o ../disassemble=
r/dmnames.o ../disassembler/dmopcode.o ../disassembler/dmobject.o ../disass=
embler/dmresrc.o ../disassembler/dmresrcl.o ../disassembler/dmresrcs.o ../d=
isassembler/dmutils.o ../disassembler/dmwalk.o ../tables/tbinstal.o ../tabl=
es/tbutils.o ../osunixxf.o \
          -o iasl
[root@xxx compiler]# ./iasl -g

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030619 [Jun 30 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

Segmentation fault


>
> cheers
>   hartwig felger
>
> Hartwig Felger informatics
>
> - --
> 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>
> iD8DBQE/ABsD9bBoTzOf1pMRAsgWAJ40y8pmLoTgrpn+H+wrN0Szr4M2qQCgzTVL
> t3yWu5IzYV+sixQuDzWMM6g=3D
> =3DxK2h
> -----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
