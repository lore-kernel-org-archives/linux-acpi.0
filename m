From: Simon Bridge <corwin-OA6R/WnsTSZ02iOg2JU2CQ@public.gmane.org>
Subject: iasl refuses to compile
Date: Sun, 20 Nov 2005 00:00:05 +1300
Message-ID: <1132398006.7629.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yes - yet another instance.
The output of the makefile is as follows:

simon@infrared:~/custom/acpica-unix-20050930/compiler$ make
conflicts: 61 shift/reduce, 18 reduce/reduce
aslcompiler.y:915.7-81: warning: rule never reduced because of
conflicts: TermArg: Type2IntegerOpcode
aslcompiler.y:916.7-81: warning: rule never reduced because of
conflicts: TermArg: Type2StringOpcode
aslcompiler.y:917.7-81: warning: rule never reduced because of
conflicts: TermArg: Type2BufferOpcode
aslcompiler.y:918.7-81: warning: rule never reduced because of
conflicts: TermArg: Type2BufferOrStringOpcode
aslcompiler.y:964.7-82: warning: rule never reduced because of
conflicts: OptionalParameterTypePackage: ','
aslcompiler.y:983.37-48: warning: rule never reduced because of
conflicts: ParameterTypesPackageList: /* empty */
aslcompiler.y:984.7-46: warning: rule never reduced because of
conflicts: ParameterTypesPackageList: ObjectTypeKeyword
aslcompiler.y:988.7-989.69: warning: rule never reduced because of
conflicts: ParameterTypesPackageList: ParameterTypesPackage ','
ParameterTypesPackage
aslcompiler.y:994.7-82: warning: rule never reduced because of
conflicts: OptionalParameterTypesPackage: ','
aslcompiler.y:1585.7-38: warning: rule never reduced because of
conflicts: CaseTermList: CaseTerm
aslcompiler.y:1594.7-38: warning: rule never reduced because of
conflicts: DefaultTermList: CaseTerm
aslcompiler.y:3077.37-48: warning: rule never reduced because of
conflicts: OptionalResourceType: /* empty */
aslcompilerlex.c: In function =E2=80=98AslCompiler_init_buffer=E2=80=99:
aslcompilerlex.c:3641: warning: implicit declaration of function
=E2=80=98fileno=E2=80=99
aslcompiler.l: In function =E2=80=98comment=E2=80=99:
aslcompiler.l:847: error: =E2=80=98yytext_ptr=E2=80=99 undeclared (first us=
e in this
function)
aslcompiler.l:847: error: (Each undeclared identifier is reported only
once
aslcompiler.l:847: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Error 1
simon@infrared:~/custom/acpica-unix-20050930/compiler$ less iaslmake.txt
simon@infrared:~/custom/acpica-unix-20050930/compiler$ rm iaslmake.txt
simon@infrared:~/custom/acpica-unix-20050930/compiler$


Normally I'd suspect missing kernel headers or source but both are
installed on this system. Library missing? I've been puzzling through
the archive and many similar topics there only to be frustrated when the
poor user finally discloses the nature of the problem, or dosn't do so
and post "hey I solved this now thanks" later, also with no
explaination.

Downloaded the intel ASL compiler/decompiler from
http://developer.intel.com/technolo...i/downloads.htm

... selected the unix tarball (acpica-unix-20050930.tar.gz) and followed
the instructions in the readme and the intel site. I had to install
bison, flex, kernel headers and sources - which I did via apt-get for
bison and flex, and synaptic for the headers and sources.


You can see I've enabled the -ansi flag (readme specified an ansi c
compiler), but I get much the same output without it (warning instead of
conflicts and the same errors.) I have been wondering about the
likelyhood of errors in the code - I doubted it only to find in the
archive to this list that it has happened ... perhaps running a debug
tool? Man I havn't used C since djgpp in dos 6.

The system is:
Ubuntu 5.10, fully updated - std repos enabled, inlcl. multiverse.
kernel 2.6.12-9-686
gcc (GCC) 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)
g++ (GCC) 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)
bison (GNU Bison) 2.0
flex 2.5.31

I've also posted this question to:
http://www.linuxquestions.org/questions/showthread.php?s=3D&threadid=3D3845=
70

Thanks in advance.



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
