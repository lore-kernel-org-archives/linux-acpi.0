From: akpm-3NddpPZAyC0@public.gmane.org
Subject: acpi_register_gsi-change-acpi-pci-code.patch added to -mm tree
Date: Thu, 28 Jul 2005 11:42:12 -0700
Message-ID: <200507281843.j6SIh9Mp012094@shell0.pdx.osdl.net>
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

     acpi_register_gsi(): change acpi pci code

has been added to the -mm tree.  Its filename is

     acpi_register_gsi-change-acpi-pci-code.patch

Patches currently in -mm which might be from kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org are

acpi_register_gsi-change-acpi_register_gsi-interface.patch
acpi_register_gsi-change-acpi-pci-code.patch
acpi_register_gsi-change-hpet-driver.patch
acpi_register_gsi-change-phpacpi-driver.patch
acpi_register_gsi-change-acpi-based-8250-driver.patch
acpi_register_gsi-change-ia64-iosapic-code.patch



From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

This patch adds the error check of acpi_register_gsi() into
acpi_pci_enable_irq().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/pci_irq.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/pci_irq.c~acpi_register_gsi-change-acpi-pci-code drivers/acpi/pci_irq.c
--- devel/drivers/acpi/pci_irq.c~acpi_register_gsi-change-acpi-pci-code	2005-07-28 11:42:11.000000000 -0700
+++ devel-akpm/drivers/acpi/pci_irq.c	2005-07-28 11:42:11.000000000 -0700
@@ -392,6 +392,7 @@ acpi_pci_irq_enable (
 	int			edge_level = ACPI_LEVEL_SENSITIVE;
 	int			active_high_low = ACPI_ACTIVE_LOW;
 	char			*link = NULL;
+	int			rc;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
 
@@ -444,7 +445,13 @@ acpi_pci_irq_enable (
 		}
  	}
 
-	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
+	rc = acpi_register_gsi(irq, edge_level, active_high_low);
+	if (rc < 0) {
+		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: failed "
+		       "to register GSI\n", pci_name(dev), ('A' + pin));
+		return_VALUE(rc);
+	}
+	dev->irq = rc;
 
 	printk(KERN_INFO PREFIX "PCI Interrupt %s[%c] -> ",
 		pci_name(dev), 'A' + pin);
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
