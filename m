From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [PATCH 2.6.13-rc4 2/2] fix possible null pointer access - acpi_pci_irq_disable
Date: Mon, 01 Aug 2005 12:35:50 +0900
Message-ID: <42ED9896.7080709@jp.fujitsu.com>
References: <42ED97C2.7060409@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42ED97C2.7060409-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch fixes possible null pointer access in acpi_pci_irq_disable.

The 'bus' field in pci_dev structure should be checked before calling
pci_read_config_byte() because pci_bus_read_config_byte() called by
pci_read_config_byte() refers to 'bus' field.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
---

 drivers/acpi/pci_irq.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

diff -puN drivers/acpi/pci_irq.c~fix-possible-null-pointer-access-acpi_pci_irq_disable drivers/acpi/pci_irq.c
--- linux-2.6.13-rc4/drivers/acpi/pci_irq.c~fix-possible-null-pointer-access-acpi_pci_irq_disable	2005-08-01 12:20:31.000000000 +0900
+++ linux-2.6.13-rc4-kanesige/drivers/acpi/pci_irq.c	2005-08-01 12:20:31.000000000 +0900
@@ -474,7 +474,7 @@ acpi_pci_irq_disable (
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_disable");
 
-	if (!dev)
+	if (!dev || !dev->bus)
 		return_VOID;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
@@ -482,9 +482,6 @@ acpi_pci_irq_disable (
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
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
