From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3]remove PCI link device resume code
Date: Fri, 21 Jan 2005 15:49:06 +0800
Message-ID: <1106293743.19407.64.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The patch remove PCI link device resume code. The new .suspend method
will set a flag for suspend/resume, so acpi_pci_link_allocate will
reconfigure IRQ.

Signed-off-by: Li Shaohua<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---

 2.5-root/drivers/acpi/pci_link.c |   34 ++++++++++++----------------------
 1 files changed, 12 insertions(+), 22 deletions(-)

diff -puN drivers/acpi/pci_link.c~remove_pci_link_resume drivers/acpi/pci_link.c
--- 2.5/drivers/acpi/pci_link.c~remove_pci_link_resume	2005-01-20 13:11:46.034910136 +0800
+++ 2.5-root/drivers/acpi/pci_link.c	2005-01-20 13:26:55.954581320 +0800
@@ -72,10 +72,12 @@ struct acpi_pci_link_irq {
 	u8			active;			/* Current IRQ */
 	u8			edge_level;		/* All IRQs */
 	u8			active_high_low;	/* All IRQs */
-	u8			initialized;
 	u8			resource_type;
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
+	u8			initialized:1;
+	u8			suspend_resume:1;
+	u8			reserved:6;
 };
 
 struct acpi_pci_link {
@@ -528,6 +530,8 @@ static int acpi_pci_link_allocate(struct
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
+	if (link->irq.suspend_resume)
+		acpi_pci_link_set(link, link->irq.active);
 	if (link->irq.initialized)
 		return_VALUE(0);
 
@@ -709,38 +713,24 @@ end:
 	return_VALUE(result);
 }
 
-
 static int
-acpi_pci_link_resume (
-	struct acpi_pci_link	*link)
-{
-	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
-	
-	if (link->irq.active && link->irq.initialized)
-		return_VALUE(acpi_pci_link_set(link, link->irq.active));
-	else
-		return_VALUE(0);
-}
-
-
-static int
-irqrouter_resume(
-	struct sys_device *dev)
+irqrouter_suspend(
+	struct sys_device *dev,
+	u32	state)
 {
 	struct list_head        *node = NULL;
 	struct acpi_pci_link    *link = NULL;
 
-	ACPI_FUNCTION_TRACE("irqrouter_resume");
+	ACPI_FUNCTION_TRACE("irqrouter_suspend");
 
 	list_for_each(node, &acpi_link.entries) {
-
 		link = list_entry(node, struct acpi_pci_link, node);
 		if (!link) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
 			continue;
 		}
-
-		acpi_pci_link_resume(link);
+		if (link->irq.active && link->irq.initialized)
+			link->irq.suspend_resume = 1;
 	}
 	return_VALUE(0);
 }
@@ -852,7 +842,7 @@ __setup("acpi_irq_balance", acpi_irq_bal
 
 static struct sysdev_class irqrouter_sysdev_class = {
         set_kset_name("irqrouter"),
-        .resume = irqrouter_resume,
+        .suspend = irqrouter_suspend,
 };
 
 
_




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
