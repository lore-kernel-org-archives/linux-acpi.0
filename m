From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/42] ACPI: Use syscore_ops instead of sysdev class and sysdev
Date: Wed, 23 Mar 2011 02:42:43 -0400
Message-ID: <c3146df2b735912eddd1d7c080c9377d5df0ae94.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37017 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab1CWHHi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:38 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:38 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI uses a sysdev class and a sysdev for executing
irqrouter_resume() before turning on interrupts on the boot CPU.
However, since irqrouter_resume() ignores its argument, the entire
mechanism may be replaced with a struct syscore_ops object which
is considerably simpler.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_link.c |   30 ++++++++----------------------
 1 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 9ff80a7..4a29763 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -29,7 +29,7 @@
  *	   for IRQ management (e.g. start()->_SRS).
  */
 
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -757,14 +757,13 @@ static int acpi_pci_link_resume(struct acpi_pci_link *link)
 	return 0;
 }
 
-static int irqrouter_resume(struct sys_device *dev)
+static void irqrouter_resume(void)
 {
 	struct acpi_pci_link *link;
 
 	list_for_each_entry(link, &acpi_link_list, list) {
 		acpi_pci_link_resume(link);
 	}
-	return 0;
 }
 
 static int acpi_pci_link_remove(struct acpi_device *device, int type)
@@ -871,32 +870,19 @@ static int __init acpi_irq_balance_set(char *str)
 
 __setup("acpi_irq_balance", acpi_irq_balance_set);
 
-/* FIXME: we will remove this interface after all drivers call pci_disable_device */
-static struct sysdev_class irqrouter_sysdev_class = {
-	.name = "irqrouter",
+static struct syscore_ops irqrouter_syscore_ops = {
 	.resume = irqrouter_resume,
 };
 
-static struct sys_device device_irqrouter = {
-	.id = 0,
-	.cls = &irqrouter_sysdev_class,
-};
-
-static int __init irqrouter_init_sysfs(void)
+static int __init irqrouter_init_ops(void)
 {
-	int error;
+	if (!acpi_disabled && !acpi_noirq)
+		register_syscore_ops(&irqrouter_syscore_ops);
 
-	if (acpi_disabled || acpi_noirq)
-		return 0;
-
-	error = sysdev_class_register(&irqrouter_sysdev_class);
-	if (!error)
-		error = sysdev_register(&device_irqrouter);
-
-	return error;
+	return 0;
 }
 
-device_initcall(irqrouter_init_sysfs);
+device_initcall(irqrouter_init_ops);
 
 static int __init acpi_pci_link_init(void)
 {
-- 
1.7.4.1.343.ga91df

