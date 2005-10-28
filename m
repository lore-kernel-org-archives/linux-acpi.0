From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 5/9] ACPI should depend on, not select PCI
Date: Fri, 28 Oct 2005 14:59:50 -0700
Message-ID: <200510282159.j9SLxWD9021616@shell0.pdx.osdl.net>
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>

ACPI should depend on, not select PCI.

The practical differences should be nearly zero except that it avoids 
the illegal configuration PCI=y, X86_VOYAGER=y.

Signed-off-by: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci drivers/acpi/Kconfig
--- 25/drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci	Fri Oct 28 14:59:08 2005
+++ 25-akpm/drivers/acpi/Kconfig	Fri Oct 28 14:59:21 2005
@@ -10,8 +10,8 @@ menu "ACPI (Advanced Configuration and P
 config ACPI
 	bool "ACPI Support"
 	depends on IA64 || X86
+	depends on PCI
 	select PM
-	select PCI
 
 	default y
 	---help---
_


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
