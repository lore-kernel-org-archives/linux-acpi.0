From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 02/12] acpi_register_gsi(): change acpi pci code
Date: Sat, 30 Jul 2005 01:17:29 -0700
Message-ID: <200507300818.j6U8ITGL017297@shell0.pdx.osdl.net>
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
Cc: akpm-3NddpPZAyC0@public.gmane.org, kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


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
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
