From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Tue, 03 Aug 2004 21:42:58 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41103F22.4090303@optonline.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_lZQ1a8cqFqtQrqUbwYY0CA)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_lZQ1a8cqFqtQrqUbwYY0CA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


This patch should fix multiple user-visible problems with the ACPI IRQ 
routing after S3 resume:

"irq x: nobody cared"
"my interrupts are gone"

It probably applies to multiple bugzilla entries and mailing list posts.

Tested on my machine, which is experiencing similar problems. Seems to 
work - although I get some non-fatal "nobody cared" messages that might 
be caused by the i8042 driver.

Comments?
Stefan, can you test this?

--Boundary_(ID_lZQ1a8cqFqtQrqUbwYY0CA)
Content-type: text/x-patch; name=acpi-fixes.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=acpi-fixes.patch

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/03 19:37:56-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org 
#   drivers/acpi/pci_link.c: use device_initcall(irqrouter_init_sysfs);
# 
# drivers/acpi/pci_link.c
#   2004/08/03 19:37:47-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +13 -3
#   use device_initcall(irqrouter_init_sysfs);
# 
# ChangeSet
#   2004/08/03 18:09:20-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org 
#   fix ACPI_FUNCTION_TRACE("irqrouter_resume");
# 
# drivers/acpi/pci_link.c
#   2004/08/03 18:09:12-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +1 -1
#   fix ACPI_FUNCTION_TRACE("irqrouter_resume");
# 
# ChangeSet
#   2004/08/03 18:03:39-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org 
#   drivers/acpi/pci_link.c: register us as a sys_device so that we can get
#   resume callbacks and restore interrupt state. Fixes interrupt problems
#   reported on the mailing lists:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# drivers/acpi/pci_link.c
#   2004/08/03 18:03:31-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +51 -14
#   drivers/acpi/pci_link.c: register us as a sys_device so that we can get
#   resume callbacks and restore interrupt state. Fixes interrupt problems
#   reported on the mailing lists:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# ChangeSet
#   2004/08/02 20:41:54-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org 
#   [ACPI] drivers/acpi/pci_link.c: add acpi_pci_link_resume(), which will be
#   called when resuming from a suspend state that needs IRQ routing to be
#   restored. This fixes issues reported on the mailing lists, e.g.:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# drivers/acpi/pci_link.c
#   2004/08/02 20:41:45-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +23 -0
#   [ACPI] drivers/acpi/pci_link.c: add acpi_pci_link_resume(), which will be
#   called when resuming from a suspend state that needs IRQ routing to be
#   restored. This fixes issues reported on the mailing lists, e.g.:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# BitKeeper/etc/ignore
#   2004/08/02 20:41:45-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +2 -0
#   Added Module.symvers drivers/acpi/pci_link.c~ to the ignore list
# 
diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	2004-08-03 19:41:29 -04:00
+++ b/drivers/acpi/pci_link.c	2004-08-03 19:41:29 -04:00
@@ -29,6 +29,7 @@
  *	   for IRQ management (e.g. start()->_SRS).
  */
 
+#include <linux/sysdev.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -84,6 +85,8 @@
 	struct acpi_pci_link_irq irq;
 };
 
+static int acpi_pci_link_resume (struct acpi_pci_link *link);
+
 static struct {
 	int			count;
 	struct list_head	entries;
@@ -695,6 +698,42 @@
 
 
 static int
+acpi_pci_link_resume (
+	struct acpi_pci_link	*link)
+{
+	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
+	
+	if (link->irq.active && link->irq.setonboot)
+		return_VALUE(acpi_pci_link_set(link, link->irq.active));
+	else
+		return_VALUE(0);
+}
+
+
+static int
+irqrouter_resume(
+	struct sys_device *dev)
+{
+	struct list_head        *node = NULL;
+	struct acpi_pci_link    *link = NULL;
+
+	ACPI_FUNCTION_TRACE("irqrouter_resume");
+
+	list_for_each(node, &acpi_link.entries) {
+
+		link = list_entry(node, struct acpi_pci_link, node);
+		if (!link) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+			continue;
+		}
+
+		acpi_pci_link_resume(link);
+	}
+	return_VALUE(0);
+}
+
+
+static int
 acpi_pci_link_remove (
 	struct acpi_device	*device,
 	int			type)
@@ -786,11 +825,42 @@
 __setup("acpi_irq_balance", acpi_irq_balance_set);
 
 
+static struct sysdev_class irqrouter_sysdev_class = {
+        set_kset_name("irqrouter"),
+        .resume = irqrouter_resume,
+};
+
+
+static struct sys_device device_irqrouter = {
+	.id     = 0,
+	.cls    = &irqrouter_sysdev_class,
+};
+
+
+static int __init irqrouter_init_sysfs(void)
+{
+	int error;
+
+	ACPI_FUNCTION_TRACE("irqrouter_init_sysfs");
+
+	if (acpi_disabled || acpi_noirq)
+		return_VALUE(0);
+
+        error = sysdev_class_register(&irqrouter_sysdev_class);
+        if (!error)
+        	error = sysdev_register(&device_irqrouter);
+
+        return_VALUE(error);
+}                                        
+
+device_initcall(irqrouter_init_sysfs);
+
+
 static int __init acpi_pci_link_init (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_pci_link_init");
 
-	if (acpi_pci_disabled)
+	if (acpi_disabled || acpi_noirq)
 		return_VALUE(0);
 
 	acpi_link.count = 0;
@@ -798,7 +868,7 @@
 
 	if (acpi_bus_register_driver(&acpi_pci_link_driver) < 0)
 		return_VALUE(-ENODEV);
-
+		
 	return_VALUE(0);
 }
 

--Boundary_(ID_lZQ1a8cqFqtQrqUbwYY0CA)--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
