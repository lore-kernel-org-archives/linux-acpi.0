From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 1/5] ACPI should depend on, not select PCI
Date: Mon, 12 Sep 2005 22:38:33 -0700
Message-ID: <200509130539.j8D5d1OS009957@shell0.pdx.osdl.net>
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
--- devel/drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci	2005-09-04 14:15:46.000000000 -0700
+++ devel-akpm/drivers/acpi/Kconfig	2005-09-04 14:15:46.000000000 -0700
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
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
