From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [PATCH] fix possible null pointer reference in acpi_pci_irq_disable
Date: Wed, 30 Mar 2005 13:49:57 +0900
Message-ID: <424A2FF5.5070603@jp.fujitsu.com>
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
acpi_pci_irq_disable().

Thanks,
Kenji Kaneshige


acpi_pci_irq_disable() should check if dev->bus is NULL before calling
pci_read_config_byte that refers it.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>


---

 linux-2.6.11-kanesige/drivers/acpi/pci_irq.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/pci_irq.c~fix_acpi_pci_irq_disable2 drivers/acpi/pci_irq.c
--- linux-2.6.11/drivers/acpi/pci_irq.c~fix_acpi_pci_irq_disable2	2005-03-30 10:36:51.000000000 +0900
+++ linux-2.6.11-kanesige/drivers/acpi/pci_irq.c	2005-03-30 10:37:23.000000000 +0900
@@ -470,14 +470,14 @@ acpi_pci_irq_disable (
 	if (!dev)
 		return_VOID;
 
+	if (!dev->bus)
+		return_VOID;
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin)
 		return_VOID;
 	pin--;
 
-	if (!dev->bus)
-		return_VOID;
-
 	/*
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
 	 */

_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
