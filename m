From: Berthold Cogel <cogel-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
Subject: Building the latest acpica on debian
Date: Sun, 23 Oct 2005 15:57:46 +0200
Message-ID: <435B96DA.8040602@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000006070400020504020609"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006070400020504020609
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello!

I'm trying to build the latest acpica package (acpica-unix-20050930) on
my debian system using flex-old (flex version 2.5.4). I'm getting some
warnings and I wonder if I have to be worried about them. I've attached
the output of make. I've compiled iasl with gcc-3.3, gcc-3.4 and gcc-4.
Especially the bison (bison (GNU Bison) 1.875d) warnings don't look
good. Do I have to be aware of any problems if I use the compiled iasl?


Thanks in advance

Berthold

--------------000006070400020504020609
Content-Type: text/x-log;
 name="iasl_make.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="iasl_make.log"

bison -v -d -y -pAslCompiler aslcompiler.y
conflicts: 61 shift/reduce, 18 reduce/reduce
aslcompiler.y:915.7-81: warning: rule never reduced because of conflicts:=
 TermArg: Type2IntegerOpcode
aslcompiler.y:916.7-81: warning: rule never reduced because of conflicts:=
 TermArg: Type2StringOpcode
aslcompiler.y:917.7-81: warning: rule never reduced because of conflicts:=
 TermArg: Type2BufferOpcode
aslcompiler.y:918.7-81: warning: rule never reduced because of conflicts:=
 TermArg: Type2BufferOrStringOpcode
aslcompiler.y:964.7-82: warning: rule never reduced because of conflicts:=
 OptionalParameterTypePackage: ','
aslcompiler.y:983.37-48: warning: rule never reduced because of conflicts=
: ParameterTypesPackageList: /* empty */
aslcompiler.y:984.7-46: warning: rule never reduced because of conflicts:=
 ParameterTypesPackageList: ObjectTypeKeyword
aslcompiler.y:988.7-989.69: warning: rule never reduced because of confli=
cts: ParameterTypesPackageList: ParameterTypesPackage ',' ParameterTypesP=
ackage
aslcompiler.y:994.7-82: warning: rule never reduced because of conflicts:=
 OptionalParameterTypesPackage: ','
aslcompiler.y:1585.7-38: warning: rule never reduced because of conflicts=
: CaseTermList: CaseTerm
aslcompiler.y:1594.7-38: warning: rule never reduced because of conflicts=
: DefaultTermList: CaseTerm
aslcompiler.y:3077.37-48: warning: rule never reduced because of conflict=
s: OptionalResourceType: /* empty */
cp y.tab.c aslcompilerparse.c
cp y.tab.h aslcompiler.y.h
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslcompilerparse.o aslcompilerparse.c
flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslcompilerlex.o aslcompilerlex.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslanalyze.o aslanalyze.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslcodegen.o aslcodegen.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslcompile.o aslcompile.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslerror.o aslerror.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslfiles.o aslfiles.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o asllength.o asllength.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o asllisting.o asllisting.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslload.o aslload.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o asllookup.o asllookup.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslmain.o aslmain.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslmap.o aslmap.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslopcodes.o aslopcodes.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o asloperands.o asloperands.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslresource.o aslresource.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslrestype1.o aslrestype1.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslrestype2.o aslrestype2.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o asltree.o asltree.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslutils.o aslutils.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o asltransform.o asltransform.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslfold.o aslfold.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslstubs.o aslstubs.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o aslopt.o aslopt.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../common/getopt.o ../common/getopt.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utalloc.o ../utilities/utalloc.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utcache.o ../utilities/utcache.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utcopy.o ../utilities/utcopy.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utdebug.o ../utilities/utdebug.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utdelete.o ../utilities/utdelete.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utglobal.o ../utilities/utglobal.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utobject.o ../utilities/utobject.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utmisc.o ../utilities/utmisc.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utmath.o ../utilities/utmath.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utmutex.o ../utilities/utmutex.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../utilities/utstate.o ../utilities/utstate.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nsaccess.o ../namespace/nsaccess.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nsalloc.o ../namespace/nsalloc.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nsdump.o ../namespace/nsdump.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nsnames.o ../namespace/nsnames.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nsobject.o ../namespace/nsobject.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nsparse.o ../namespace/nsparse.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nssearch.o ../namespace/nssearch.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nsutils.o ../namespace/nsutils.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nswalk.o ../namespace/nswalk.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../namespace/nsxfobj.o ../namespace/nsxfobj.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/parser/psargs.o ../interpreter/parser/psargs.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/parser/psloop.o ../interpreter/parser/psloop.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/parser/psopcode.o ../interpreter/parser/psopcod=
e.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/parser/psparse.o ../interpreter/parser/psparse.=
c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/parser/psscope.o ../interpreter/parser/psscope.=
c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/parser/pstree.o ../interpreter/parser/pstree.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/parser/psutils.o ../interpreter/parser/psutils.=
c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/parser/pswalk.o ../interpreter/parser/pswalk.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/dispatcher/dswscope.o ../interpreter/dispatcher=
/dswscope.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/dispatcher/dswstate.o ../interpreter/dispatcher=
/dswstate.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/dispatcher/dsfield.o ../interpreter/dispatcher/=
dsfield.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/dispatcher/dsobject.o ../interpreter/dispatcher=
/dsobject.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/dispatcher/dsopcode.o ../interpreter/dispatcher=
/dsopcode.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/dispatcher/dsutils.o ../interpreter/dispatcher/=
dsutils.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/dispatcher/dswexec.o ../interpreter/dispatcher/=
dswexec.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/dispatcher/dswload.o ../interpreter/dispatcher/=
dswload.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exconvrt.o ../interpreter/executer/exc=
onvrt.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/excreate.o ../interpreter/executer/exc=
reate.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exdump.o ../interpreter/executer/exdum=
p.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exmisc.o ../interpreter/executer/exmis=
c.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exmutex.o ../interpreter/executer/exmu=
tex.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exnames.o ../interpreter/executer/exna=
mes.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exoparg1.o ../interpreter/executer/exo=
parg1.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exoparg2.o ../interpreter/executer/exo=
parg2.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exoparg3.o ../interpreter/executer/exo=
parg3.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exoparg6.o ../interpreter/executer/exo=
parg6.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exprep.o ../interpreter/executer/expre=
p.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exregion.o ../interpreter/executer/exr=
egion.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exresnte.o ../interpreter/executer/exr=
esnte.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exresolv.o ../interpreter/executer/exr=
esolv.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exresop.o ../interpreter/executer/exre=
sop.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exstore.o ../interpreter/executer/exst=
ore.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exstoren.o ../interpreter/executer/exs=
toren.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exstorob.o ../interpreter/executer/exs=
torob.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exsystem.o ../interpreter/executer/exs=
ystem.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../interpreter/executer/exutils.o ../interpreter/executer/exut=
ils.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../common/adisasm.o ../common/adisasm.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../debugger/dbfileio.o ../debugger/dbfileio.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../disassembler/dmbuffer.o ../disassembler/dmbuffer.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../disassembler/dmnames.o ../disassembler/dmnames.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../disassembler/dmopcode.o ../disassembler/dmopcode.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../disassembler/dmobject.o ../disassembler/dmobject.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../disassembler/dmresrc.o ../disassembler/dmresrc.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../disassembler/dmresrcl.o ../disassembler/dmresrcl.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../disassembler/dmresrcs.o ../disassembler/dmresrcs.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../disassembler/dmutils.o ../disassembler/dmutils.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../disassembler/dmwalk.o ../disassembler/dmwalk.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../tables/tbinstal.o ../tables/tbinstal.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../tables/tbutils.o ../tables/tbutils.c
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I../includ=
e    -c -o ../osunixxf.o ../osunixxf.c
=2E./osunixxf.c: In function 'AcpiOsGetRootPointer':
=2E./osunixxf.c:188: warning: implicit declaration of function 'AeLocalGe=
tRootPointer'
cc  aslcompilerparse.o aslcompilerlex.o aslanalyze.o aslcodegen.o aslcomp=
ile.o aslerror.o aslfiles.o asllength.o asllisting.o aslload.o asllookup.=
o aslmain.o aslmap.o aslopcodes.o asloperands.o aslresource.o aslrestype1=
=2Eo aslrestype2.o asltree.o aslutils.o asltransform.o aslfold.o aslstubs=
=2Eo aslopt.o ../common/getopt.o ../utilities/utalloc.o ../utilities/utca=
che.o ../utilities/utcopy.o ../utilities/utdebug.o ../utilities/utdelete.=
o ../utilities/utglobal.o ../utilities/utobject.o ../utilities/utmisc.o .=
=2E/utilities/utmath.o ../utilities/utmutex.o ../utilities/utstate.o ../n=
amespace/nsaccess.o ../namespace/nsalloc.o ../namespace/nsdump.o ../names=
pace/nsnames.o ../namespace/nsobject.o ../namespace/nsparse.o ../namespac=
e/nssearch.o ../namespace/nsutils.o ../namespace/nswalk.o ../namespace/ns=
xfobj.o ../interpreter/parser/psargs.o ../interpreter/parser/psloop.o ../=
interpreter/parser/psopcode.o ../interpreter/parser/psparse.o ../interpre=
ter/parser/psscope.o ../interpreter/parser/pstree.o ../interpreter/parser=
/psutils.o ../interpreter/parser/pswalk.o ../interpreter/dispatcher/dswsc=
ope.o ../interpreter/dispatcher/dswstate.o ../interpreter/dispatcher/dsfi=
eld.o ../interpreter/dispatcher/dsobject.o ../interpreter/dispatcher/dsop=
code.o ../interpreter/dispatcher/dsutils.o ../interpreter/dispatcher/dswe=
xec.o ../interpreter/dispatcher/dswload.o ../interpreter/executer/exconvr=
t.o ../interpreter/executer/excreate.o ../interpreter/executer/exdump.o .=
=2E/interpreter/executer/exmisc.o ../interpreter/executer/exmutex.o ../in=
terpreter/executer/exnames.o ../interpreter/executer/exoparg1.o ../interp=
reter/executer/exoparg2.o ../interpreter/executer/exoparg3.o ../interpret=
er/executer/exoparg6.o ../interpreter/executer/exprep.o ../interpreter/ex=
ecuter/exregion.o ../interpreter/executer/exresnte.o ../interpreter/execu=
ter/exresolv.o ../interpreter/executer/exresop.o ../interpreter/executer/=
exstore.o ../interpreter/executer/exstoren.o ../interpreter/executer/exst=
orob.o ../interpreter/executer/exsystem.o ../interpreter/executer/exutils=
=2Eo ../common/adisasm.o ../debugger/dbfileio.o ../disassembler/dmbuffer.=
o ../disassembler/dmnames.o ../disassembler/dmopcode.o ../disassembler/dm=
object.o ../disassembler/dmresrc.o ../disassembler/dmresrcl.o ../disassem=
bler/dmresrcs.o ../disassembler/dmutils.o ../disassembler/dmwalk.o ../tab=
les/tbinstal.o ../tables/tbutils.o ../osunixxf.o \
	  -o iasl

--------------000006070400020504020609--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
