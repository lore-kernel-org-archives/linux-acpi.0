From: akpm-3NddpPZAyC0@public.gmane.org
Subject: acpi_register_gsi-change-phpacpi-driver.patch added to -mm tree
Date: Thu, 28 Jul 2005 11:42:16 -0700
Message-ID: <200507281843.j6SIhDGK012112@shell0.pdx.osdl.net>
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
To: kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The patch titled

     acpi_register_gsi(): change phpacpi driver

has been added to the -mm tree.  Its filename is

     acpi_register_gsi-change-phpacpi-driver.patch

Patches currently in -mm which might be from kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org are

acpi_register_gsi-change-acpi_register_gsi-interface.patch
acpi_register_gsi-change-acpi-pci-code.patch
acpi_register_gsi-change-hpet-driver.patch
acpi_register_gsi-change-phpacpi-driver.patch
acpi_register_gsi-change-acpi-based-8250-driver.patch
acpi_register_gsi-change-ia64-iosapic-code.patch



From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

This patch adds the error check of acpi_register_gsi() into pnpacpi driver.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/pnp/pnpacpi/rsparser.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~acpi_register_gsi-change-phpacpi-driver drivers/pnp/pnpacpi/rsparser.c
--- devel/drivers/pnp/pnpacpi/rsparser.c~acpi_register_gsi-change-phpacpi-driver	2005-07-28 11:42:15.000000000 -0700
+++ devel-akpm/drivers/pnp/pnpacpi/rsparser.c	2005-07-28 11:42:15.000000000 -0700
@@ -81,7 +81,7 @@ pnpacpi_parse_allocated_irqresource(stru
 		i++;
 	if (i < PNP_MAX_IRQ) {
 		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET flag
-		if (irq == -1) {
+		if (irq < 0) {
 			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
