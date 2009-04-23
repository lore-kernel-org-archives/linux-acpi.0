From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/29] ACPI: add /sys/firmware/acpi/interrupts/sci_not counter
Date: Thu, 23 Apr 2009 02:23:49 -0400
Message-ID: <88bea188b85f9cefefbbd56b8a48d0f798409177.1240467665.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:23393 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbZDWGYK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:10 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00HNWJ495VV5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:10 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This counter may prove useful in debugging some
spurious interrupt issues seen in the field.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi |    8 ++++++--
 drivers/acpi/osl.c                            |    4 +++-
 drivers/acpi/system.c                         |   11 +++++++++--
 include/linux/acpi.h                          |    1 +
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index e8ffc70..4f9ba3c 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -69,9 +69,13 @@ Description:
 		gpe1F:	     0	invalid
 		gpe_all:    1192
 		sci:	1194
+		sci_not:     0	
 
-		sci - The total number of times the ACPI SCI
-		has claimed an interrupt.
+		sci - The number of times the ACPI SCI
+		has been called and claimed an interrupt.
+
+		sci_not - The number of times the ACPI SCI
+		has been called and NOT claimed an interrupt.
 
 		gpe_all - count of SCI caused by GPEs.
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index d59f08e..d916bea 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -353,8 +353,10 @@ static irqreturn_t acpi_irq(int irq, void *dev_id)
 	if (handled) {
 		acpi_irq_handled++;
 		return IRQ_HANDLED;
-	} else
+	} else {
+		acpi_irq_not_handled++;
 		return IRQ_NONE;
+	}
 }
 
 acpi_status
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index da51f05..0944dae 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -38,6 +38,7 @@ ACPI_MODULE_NAME("system");
 #define ACPI_SYSTEM_DEVICE_NAME		"System"
 
 u32 acpi_irq_handled;
+u32 acpi_irq_not_handled;
 
 /*
  * Make ACPICA version work as module param
@@ -214,8 +215,9 @@ err:
 
 #define COUNT_GPE 0
 #define COUNT_SCI 1	/* acpi_irq_handled */
-#define COUNT_ERROR 2	/* other */
-#define NUM_COUNTERS_EXTRA 3
+#define COUNT_SCI_NOT 2	/* acpi_irq_not_handled */
+#define COUNT_ERROR 3	/* other */
+#define NUM_COUNTERS_EXTRA 4
 
 struct event_counter {
 	u32 count;
@@ -317,6 +319,8 @@ static ssize_t counter_show(struct kobject *kobj,
 
 	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI].count =
 		acpi_irq_handled;
+	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT].count =
+		acpi_irq_not_handled;
 	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
 		acpi_gpe_count;
 
@@ -363,6 +367,7 @@ static ssize_t counter_set(struct kobject *kobj,
 			all_counters[i].count = 0;
 		acpi_gpe_count = 0;
 		acpi_irq_handled = 0;
+		acpi_irq_not_handled = 0;
 		goto end;
 	}
 
@@ -456,6 +461,8 @@ void acpi_irq_stats_init(void)
 			sprintf(buffer, "gpe_all");
 		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI)
 			sprintf(buffer, "sci");
+		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT)
+			sprintf(buffer, "sci_not");
 		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR)
 			sprintf(buffer, "error");
 		else
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6586cbd..88be890 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -111,6 +111,7 @@ int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base);
 int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base);
 void acpi_irq_stats_init(void);
 extern u32 acpi_irq_handled;
+extern u32 acpi_irq_not_handled;
 
 extern struct acpi_mcfg_allocation *pci_mmcfg_config;
 extern int pci_mmcfg_config_num;
-- 
1.6.0.6

