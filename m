From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: acpi/pci_link.c: clean up whitespace
Date: Sun, 17 Jul 2005 21:14:20 +0200
Message-ID: <20050717191420.GA12666@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This cleans up some whitespace in acpi/pci_link.c. No code changes.

Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -524,8 +524,7 @@ acpi_irq_penalty_init(void)
 
 static int acpi_irq_balance;	/* 0: static, 1: balance */
 
-static int acpi_pci_link_allocate(
-	struct acpi_pci_link	*link)
+static int acpi_pci_link_allocate(struct acpi_pci_link	*link)
 {
 	int			irq;
 	int			i;
@@ -653,8 +652,7 @@ acpi_pci_link_get_irq (
    -------------------------------------------------------------------------- */
 
 static int
-acpi_pci_link_add (
-	struct acpi_device *device)
+acpi_pci_link_add(struct acpi_device *device)
 {
 	int			result = 0;
 	struct acpi_pci_link	*link = NULL;
@@ -720,9 +718,7 @@ end:
 }
 
 static int
-irqrouter_suspend(
-	struct sys_device *dev,
-	u32	state)
+irqrouter_suspend(struct sys_device *dev, u32 state)
 {
 	struct list_head        *node = NULL;
 	struct acpi_pci_link    *link = NULL;
@@ -743,9 +739,7 @@ irqrouter_suspend(
 
 
 static int
-acpi_pci_link_remove (
-	struct acpi_device	*device,
-	int			type)
+acpi_pci_link_remove(struct acpi_device *device, int type)
 {
 	struct acpi_pci_link *link = NULL;
 

-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
