From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: building iasl gives yytext_ptr undeclared (acpiaca-unix-20050309)
Date: Thu, 17 Mar 2005 13:49:01 -0500
Message-ID: <E1DC03J-0001Bj-Dg@approximate.corpus.cam.ac.uk>
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

In building compiler/iasl from ACPI CA (acpica-unix-20050309.tar.gz), I
get the yytext_ptr undeclared error:

cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER -I../include    -c -o aslcompilerlex.o aslcompilerlex.c
aslcompiler.l: In function `comment':
aslcompiler.l:847: error: `yytext_ptr' undeclared (first use in this function)

Commenting out the '#undef yytext_ptr' in the generated aslcompilerlex.c
allowed me to compile iasl (and it worked fine).  Here's the diff:

--- aslcompilerlex.c	2005-03-16 15:14:43.000000000 -0500
+++ aslcompilerlex.c	2005-03-17 13:43:01.000000000 -0500
@@ -4028,7 +4028,7 @@
 #undef yy_set_bol
 #undef yy_new_buffer
 #undef yy_set_interactive
-#undef yytext_ptr
+// #undef yytext_ptr
 #undef YY_DO_BEFORE_ACTION
 
 #ifdef YY_DECL_IS_OURS

I'm using a i386 Debian testing system with:

flex 2.5.31
bison (GNU Bison) 1.875d

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
