From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [PATCH] fix possible null pointer reference in acpi_pci_irq_enable
Date: Wed, 30 Mar 2005 13:49:50 +0900
Message-ID: <424A2FEE.6060009@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

The following patch fixes possible null pointer reference in
acpi_pci_irq_enable().

Thanks,
Kenji Kaneshige


acpi_pci_irq_enable() should check if dev->bus is NULL before calling
pci_read_config_byte that refers it.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>


---

 linux-2.6.11-kanesige/drivers/acpi/pci_irq.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/acpi/pci_irq.c~fix_acpi_pci_irq_enable drivers/acpi/pci_irq.c
--- linux-2.6.11/drivers/acpi/pci_irq.c~fix_acpi_pci_irq_enable	2005-03-30 10:11:55.000000000 +0900
+++ linux-2.6.11-kanesige/drivers/acpi/pci_irq.c	2005-03-30 10:12:37.000000000 +0900
@@ -395,6 +395,11 @@ acpi_pci_irq_enable (
 	if (!dev)
 		return_VALUE(-EINVAL);
 	
+	if (!dev->bus) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) 'bus' field\n"));
+		return_VALUE(-ENODEV);
+	}
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No interrupt pin configured for device %s\n", pci_name(dev)));
@@ -402,11 +407,6 @@ acpi_pci_irq_enable (
 	}
 	pin--;
 
-	if (!dev->bus) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) 'bus' field\n"));
-		return_VALUE(-ENODEV);
-	}
-
 	/* 
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.

_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
