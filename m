From: elbg <elbg-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: Acpica problem?
Date: Mon, 30 Jun 2003 18:05:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F005FD4.5000401@laposte.net>
References: <Pine.LNX.4.33.0306301311190.1064-100000@frog.athome> <200306301400.12493.hrvoje.habjanic@zg.htnet.hr> <3F005439.4030705@laposte.net>
Reply-To: elbg-QFKgK+z4sOrR7s880joybQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F005439.4030705-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: elbg-QFKgK+z4sOrR7s880joybQ@public.gmane.org
Cc: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
In fact it is normal.!! Once made construction with make, I find the=20
files well "aslcompilerparse.c & aslcompilerlex.c "
Afflicted !!!
Good, but there remain the errors of compilation ! :)

elbg a =E9crit :

> Salut,
> Me I do not have the files following : "aslcompilerparse.c &=20
> aslcompilerlex.c " in the sources of  intel :=20
> "acpica-unix-20030619.tar.gz" !
>
> I looked in the directory  "../acpica-unix-20030619/compiler/" and it=20
> do not have the file there ! I have to check=20
> "../acpica-unix-20030619/compiler/Makefile" and they must be there !
> It is possible that.??
> I does not understand!!
>
> Hrvoje Habjanic a =E9crit :
>
>> On Monday 30 June 2003 13:11, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
>> =20
>>
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Salut Hrvoje,
>>>
>>> On Mon, 30 Jun 2003, Hrvoje Habjanic wrote:
>>>  =20
>>>
>>>> [root@xxx acpi]# ./acpica-unix-20030619/compiler/iasl -g
>>>>
>>>> Intel ACPI Component Architecture
>>>> ASL Optimizing Compiler / AML Disassembler version 20030619 [Jun 30=20
>>>> 2003]
>>>> Copyright (C) 2000 - 2003 Intel Corporation
>>>> Supports ACPI Specification Revision 2.0b
>>>>
>>>> Core dump
>>>>
>>>> I'm dooing something wrong?
>>>>    =20
>>>
>>> Did you build it from source?
>>>  =20
>>
>>
>> Yep!
>>
>>
>> [root@habi xxx]# cd acpica-unix-20030619/compiler/
>> [root@xxx compiler]# make bison -v -d -y -pAslCompiler aslcompiler.y
>> conflicts:  33 shift/reduce, 47 reduce/reduce
>> cp y.tab.c aslcompilerparse.c
>> cp y.tab.h aslcompiler.y.h
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslcompilerparse.o aslcompilerparse.c
>> flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslcompilerlex.o aslcompilerlex.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslanalyze.o aslanalyze.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslcodegen.o aslcodegen.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslcompile.o aslcompile.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslerror.o aslerror.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslfiles.o aslfiles.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o asllength.o asllength.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o asllisting.o asllisting.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslload.o aslload.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o asllookup.o asllookup.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslmain.o aslmain.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslmap.o aslmap.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslopcodes.o aslopcodes.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o asloperands.o asloperands.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslresource.o aslresource.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslrestype1.o aslrestype1.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslrestype2.o aslrestype2.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o asltree.o asltree.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslutils.o aslutils.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o asltransform.o asltransform.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslfold.o aslfold.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslstubs.o aslstubs.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o aslopt.o aslopt.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../common/getopt.o ../common/getopt.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../utilities/utalloc.o ../utilities/utalloc.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../utilities/utcopy.o ../utilities/utcopy.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../utilities/utdebug.o ../utilities/utdebug.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../utilities/utdelete.o ../utilities/utdelete.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../utilities/utglobal.o ../utilities/utglobal.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../utilities/utobject.o ../utilities/utobject.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../utilities/utmisc.o ../utilities/utmisc.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../utilities/utmath.o ../utilities/utmath.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nsaccess.o ../namespace/nsaccess.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nsalloc.o ../namespace/nsalloc.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nsdump.o ../namespace/nsdump.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nsnames.o ../namespace/nsnames.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nsobject.o ../namespace/nsobject.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nsparse.o ../namespace/nsparse.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nssearch.o ../namespace/nssearch.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nsutils.o ../namespace/nsutils.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nswalk.o ../namespace/nswalk.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../namespace/nsxfobj.o ../namespace/nsxfobj.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/parser/psargs.o=20
>> ../interpreter/parser/psargs.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/parser/psopcode.o=20
>> ../interpreter/parser/psopcode.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/parser/psparse.o=20
>> ../interpreter/parser/psparse.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/parser/psscope.o=20
>> ../interpreter/parser/psscope.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/parser/pstree.o=20
>> ../interpreter/parser/pstree.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/parser/psutils.o=20
>> ../interpreter/parser/psutils.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/parser/pswalk.o=20
>> ../interpreter/parser/pswalk.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/dispatcher/dswscope.o=20
>> ../interpreter/dispatcher/dswscope.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/dispatcher/dswstate.o=20
>> ../interpreter/dispatcher/dswstate.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/dispatcher/dsfield.o=20
>> ../interpreter/dispatcher/dsfield.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/dispatcher/dsobject.o=20
>> ../interpreter/dispatcher/dsobject.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/dispatcher/dsopcode.o=20
>> ../interpreter/dispatcher/dsopcode.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/dispatcher/dsutils.o=20
>> ../interpreter/dispatcher/dsutils.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/dispatcher/dswexec.o=20
>> ../interpreter/dispatcher/dswexec.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/dispatcher/dswload.o=20
>> ../interpreter/dispatcher/dswload.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exconvrt.o=20
>> ../interpreter/executer/exconvrt.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/excreate.o=20
>> ../interpreter/executer/excreate.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exdump.o=20
>> ../interpreter/executer/exdump.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exmisc.o=20
>> ../interpreter/executer/exmisc.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exmutex.o=20
>> ../interpreter/executer/exmutex.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exnames.o=20
>> ../interpreter/executer/exnames.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exoparg1.o=20
>> ../interpreter/executer/exoparg1.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exoparg2.o=20
>> ../interpreter/executer/exoparg2.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exoparg3.o=20
>> ../interpreter/executer/exoparg3.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exoparg6.o=20
>> ../interpreter/executer/exoparg6.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exprep.o=20
>> ../interpreter/executer/exprep.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exregion.o=20
>> ../interpreter/executer/exregion.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exresnte.o=20
>> ../interpreter/executer/exresnte.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exresolv.o=20
>> ../interpreter/executer/exresolv.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exresop.o=20
>> ../interpreter/executer/exresop.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exstore.o=20
>> ../interpreter/executer/exstore.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exstoren.o=20
>> ../interpreter/executer/exstoren.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exstorob.o=20
>> ../interpreter/executer/exstorob.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exsystem.o=20
>> ../interpreter/executer/exsystem.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../interpreter/executer/exutils.o=20
>> ../interpreter/executer/exutils.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../common/adisasm.o ../common/adisasm.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../debugger/dbfileio.o ../debugger/dbfileio.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../disassembler/dmbuffer.o=20
>> ../disassembler/dmbuffer.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../disassembler/dmnames.o=20
>> ../disassembler/dmnames.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../disassembler/dmopcode.o=20
>> ../disassembler/dmopcode.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../disassembler/dmobject.o=20
>> ../disassembler/dmobject.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../disassembler/dmresrc.o=20
>> ../disassembler/dmresrc.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../disassembler/dmresrcl.o=20
>> ../disassembler/dmresrcl.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../disassembler/dmresrcs.o=20
>> ../disassembler/dmresrcs.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../disassembler/dmutils.o=20
>> ../disassembler/dmutils.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../disassembler/dmwalk.o ../disassembler/dmwalk.=
c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../tables/tbinstal.o ../tables/tbinstal.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../tables/tbutils.o ../tables/tbutils.c
>> cc -g -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER=20
>> -I../include    -c -o ../osunixxf.o ../osunixxf.c
>> cc  aslcompilerparse.o aslcompilerlex.o aslanalyze.o aslcodegen.o=20
>> aslcompile.o aslerror.o aslfiles.o asllength.o asllisting.o aslload.o=20
>> asllookup.o aslmain.o aslmap.o aslopcodes.o asloperands.o=20
>> aslresource.o aslrestype1.o aslrestype2.o asltree.o aslutils.o=20
>> asltransform.o aslfold.o aslstubs.o aslopt.o ../common/getopt.o=20
>> ../utilities/utalloc.o ../utilities/utcopy.o ../utilities/utdebug.o=20
>> ../utilities/utdelete.o ../utilities/utglobal.o=20
>> ../utilities/utobject.o ../utilities/utmisc.o ../utilities/utmath.o=20
>> ../namespace/nsaccess.o ../namespace/nsalloc.o ../namespace/nsdump.o=20
>> ../namespace/nsnames.o ../namespace/nsobject.o ../namespace/nsparse.o=20
>> ../namespace/nssearch.o ../namespace/nsutils.o ../namespace/nswalk.o=20
>> ../namespace/nsxfobj.o ../interpreter/parser/psargs.o=20
>> ../interpreter/parser/psopcode.o ../interpreter/parser/psparse.o=20
>> ../interpreter/parser/psscope.o ../interpreter/parser/pstree.o=20
>> ../interpreter/parser/psutils.o ../interpreter/parser/pswalk.o=20
>> ../interpreter/dispatcher/dswscope.o=20
>> ../interpreter/dispatcher/dswstate.o=20
>> ../interpreter/dispatcher/dsfield.o=20
>> ../interpreter/dispatcher/dsobject.o=20
>> ../interpreter/dispatcher/dsopcode.o=20
>> ../interpreter/dispatcher/dsutils.o=20
>> ../interpreter/dispatcher/dswexec.o=20
>> ../interpreter/dispatcher/dswload.o=20
>> ../interpreter/executer/exconvrt.o ../interpreter/executer/excreate.o=20
>> ../interpreter/executer/exdump.o ../interpreter/executer/exmisc.o=20
>> ../interpreter/executer/exmutex.o ../interpreter/executer/exnames.o=20
>> ../interpreter/executer/exoparg1.o ../interpreter/executer/exoparg2.o=20
>> ../interpreter/executer/exoparg3.o ../interpreter/executer/exoparg6.o=20
>> ../interpreter/executer/exprep.o ../interpreter/executer/exregion.o=20
>> ../interpreter/executer/exresnte.o ../interpreter/executer/exresolv.o=20
>> ../interpreter/executer/exresop.o ../interpreter/executer/exstore.o=20
>> ../interpreter/executer/exstoren.o ../interpreter/executer/exstorob.o=20
>> ../interpreter/executer/exsystem.o ../interpreter/executer/exutils.o=20
>> ../common/adisasm.o ../debugger/dbfileio.o ../disassembler/dmbuffer.o=20
>> ../disassembler/dmnames.o ../disassembler/dmopcode.o=20
>> ../disassembler/dmobject.o ../disassembler/dmresrc.o=20
>> ../disassembler/dmresrcl.o ../disassembler/dmresrcs.o=20
>> ../disassembler/dmutils.o ../disassembler/dmwalk.o=20
>> ../tables/tbinstal.o ../tables/tbutils.o ../osunixxf.o \
>>          -o iasl
>> [root@xxx compiler]# ./iasl -g
>>
>> Intel ACPI Component Architecture
>> ASL Optimizing Compiler / AML Disassembler version 20030619 [Jun 30=20
>> 2003]
>> Copyright (C) 2000 - 2003 Intel Corporation
>> Supports ACPI Specification Revision 2.0b
>>
>> Segmentation fault
>>
>>
>> =20
>>
>>> cheers
>>>  hartwig felger
>>>
>>> Hartwig Felger informatics
>>>
>>> - --
>>> 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
>>> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D69=
3
>>> For the pulic keys, please visit my page.
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: GnuPG v1.2.2 (GNU/Linux)
>>>
>>> iD8DBQE/ABsD9bBoTzOf1pMRAsgWAJ40y8pmLoTgrpn+H+wrN0Szr4M2qQCgzTVL
>>> t3yWu5IzYV+sixQuDzWMM6g=3D
>>> =3DxK2h
>>> -----END PGP SIGNATURE-----
>>>  =20
>>
>>
>>
>>
>> -------------------------------------------------------
>> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
>> Data Reports, E-commerce, Portals, and Forums are available now.
>> Download today and enter to win an XBOX or Visual Studio .NET.
>> http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/=
01
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>> =20
>>
>
>
>
>
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/0=
1
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
