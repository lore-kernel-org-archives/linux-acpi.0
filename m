From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Compiling vbetool
Date: Mon, 07 Feb 2005 15:53:13 +0100
Message-ID: <420780D9.8030800@gmx.net>
References: <42077F0D.5020206@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050703070003020003070105"
In-Reply-To: <42077F0D.5020206-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050703070003020003070105
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Rich Townsend schrieb:
> I'm sure this isn't the correct place to post such a question, but I
> could find no other appropriate forum. Has anyone run into a problem
> trying to compile Matthew Garret's vbetool? Specifically:
> 
> In file included from /usr/include/stdlib.h:416,
>                  from vbetool.c:14:
> /usr/include/sys/types.h:62: error: conflicting types for 'dev_t'
> /usr/include/linux/types.h:24: error: previous declaration of 'dev_t'
> was here

Yes, I posted a patch for that four days ago. Attached again.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

--------------050703070003020003070105
Content-Type: text/x-patch;
 name="vbetool-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vbetool-fix.diff"

diff -urN vbetool-0.2/Makefile.am vbetool-0.2-modified/Makefile.am
--- vbetool-0.2/Makefile.am	2004-12-30 16:27:07.000000000 +0100
+++ vbetool-0.2-modified/Makefile.am	2005-02-03 21:58:16.000000000 +0100
@@ -12,4 +12,4 @@
 	$(RM) Makefile.in aclocal.m4 config.h.in stamp-h.in configure
 
 AM_CFLAGS = -g -Wall -Werror -pedantic
-AM_LDFLAGS = -lpci
+LIBS = -lpci
diff -urN vbetool-0.2/vbetool.c vbetool-0.2-modified/vbetool.c
--- vbetool-0.2/vbetool.c	2004-12-31 16:11:19.000000000 +0100
+++ vbetool-0.2-modified/vbetool.c	2005-02-03 22:02:53.000000000 +0100
@@ -8,7 +8,6 @@
 version 2
 */
 
-#include <pci/pci.h>
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -17,6 +16,7 @@
 #include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/io.h>
+#include <pci/pci.h>
 #include <sys/kd.h>
 #include <sys/stat.h>
 #include <errno.h>

--------------050703070003020003070105--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
