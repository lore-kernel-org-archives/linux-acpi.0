From: Mark Eaton <meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>
Subject: I can't get iasl to compile
Date: Wed, 16 Feb 2005 09:35:11 +1000
Message-ID: <200502160935.11842.meaton@vasco.com>
References: <20050214211105.GA12808@elf.ucw.cz> <4212460A.4000100@gmx.net> <1108498875.12026.18.camel@elrond.flymine.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108498875.12026.18.camel-Xmbc1Sz64/5pghhO6/9/sx2eb7JE58TQ@public.gmane.org>
Content-Disposition: inline
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

I have been trying to get suspend/resume to work on my laptop but it hangs as 
soon as resume, so I was going to look at the dsdt (being an acer it is 
probably broken) but I cant get iasl to compile. 

I have downloaded the latest iasl from intel's (acpica-unix-20041203) site but 
get the following errors when trying to compile it.

bison -v -d -y -pAslCompiler aslcompiler.y
conflicts: 57 shift/reduce, 50 reduce/reduce
aslcompiler.y:913.7-81: warning: rule never reduced because of conflicts: 
TermArg: Type2IntegerOpcode
aslcompiler.y:914.7-81: warning: rule never reduced because of conflicts: 
TermArg: Type2StringOpcode
aslcompiler.y:915.7-81: warning: rule never reduced because of conflicts: 
TermArg: Type2BufferOpcode
aslcompiler.y:916.7-81: warning: rule never reduced because of conflicts: 
TermArg: Type2BufferOrStringOpcode
aslcompiler.y:958.7-82: warning: rule never reduced because of conflicts: 
OptionalParameterTypePackage: ','
aslcompiler.y:981.7-82: warning: rule never reduced because of conflicts: 
OptionalParameterTypesPackage: ','
aslcompiler.y:1572.7-38: warning: rule never reduced because of conflicts: 
CaseTermList: CaseTerm
aslcompiler.y:1581.7-38: warning: rule never reduced because of conflicts: 
DefaultTermList: CaseTerm
aslcompiler.y:3062.37-48: warning: rule never reduced because of conflicts: 
OptionalResourceType: /* empty */
cp y.tab.c aslcompilerparse.c
cp y.tab.h aslcompiler.y.h
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../include    
-c -o aslcompilerparse.o aslcompilerparse.c
flex -i -PAslCompiler -oaslcompilerlex.c aslcompiler.l
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../include    
-c -o aslcompilerlex.o aslcompilerlex.c
aslcompiler.l: In function `comment':
aslcompiler.l:846: error: `yytext_ptr' undeclared (first use in this function)
aslcompiler.l:846: error: (Each undeclared identifier is reported only once
aslcompiler.l:846: error: for each function it appears in.)
make: *** [aslcompilerlex.o] Error 1

This is on a debian sid linux system
gcc 3.3.5 
bison 1.875d
flex 2.5.31


-- 
Mark Eaton
meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
