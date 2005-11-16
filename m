From: akpm-3NddpPZAyC0@public.gmane.org
Subject: + drivers-acpi-asus_acpic-unsigned-comparison.patch added to -mm tree
Date: Wed, 16 Nov 2005 15:54:25 -0800
Message-ID: <200511162354.jAGNsh7V029154@shell0.pdx.osdl.net>
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
To: ace-CZbD5vIK5ytj4kVupMNl0w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The patch titled

     drivers/acpi/asus_acpi.c unsigned comparison

has been added to the -mm tree.  Its filename is

     drivers-acpi-asus_acpic-unsigned-comparison.patch


From: "Gabriel A. Devenyi" <ace-CZbD5vIK5ytj4kVupMNl0w@public.gmane.org>

proc_write_brn, and proc_write_disp both use a parameter "count" to store
the result from parse_arg.  The return of parse_arg is an int, but count is
declared as an unsigned int, and later checked versus zero, which is
meaningless.  This patch fixes the declaration of count in both functions.

Thanks to LinuxICC (http://linuxicc.sf.net)

Signed-off-by: Gabriel A. Devenyi <ace-CZbD5vIK5ytj4kVupMNl0w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/asus_acpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/asus_acpi.c~drivers-acpi-asus_acpic-unsigned-comparison drivers/acpi/asus_acpi.c
--- devel/drivers/acpi/asus_acpi.c~drivers-acpi-asus_acpic-unsigned-comparison	2005-11-16 15:53:26.000000000 -0800
+++ devel-akpm/drivers/acpi/asus_acpi.c	2005-11-16 15:53:26.000000000 -0800
@@ -748,7 +748,7 @@ proc_read_brn(char *page, char **start, 
 
 static int
 proc_write_brn(struct file *file, const char __user * buffer,
-	       unsigned long count, void *data)
+	       long count, void *data)
 {
 	int value;
 
@@ -798,7 +798,7 @@ proc_read_disp(char *page, char **start,
  */
 static int
 proc_write_disp(struct file *file, const char __user * buffer,
-		unsigned long count, void *data)
+		long count, void *data)
 {
 	int value;
 
_

Patches currently in -mm which might be from ace-CZbD5vIK5ytj4kVupMNl0w@public.gmane.org are

drivers-acpi-asus_acpic-unsigned-comparison.patch
cpufreq-nforce2c-fix-u320-test.patch



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
