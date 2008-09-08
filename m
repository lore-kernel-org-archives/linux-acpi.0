From: shaohua.li@intel.com
Subject: [RFC 2/5] devcore adds generic wakeup event handler
Date: Mon, 08 Sep 2008 17:19:28 +0800
Message-ID: <20080908092305.333496279@sli10-desk.sh.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43302 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbYIHJXL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Sep 2008 05:23:11 -0400
Content-Disposition: inline; filename=devcore-introduce-default-pme-action.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: stern@rowland.harvard.edu, dbrownell@users.sourceforge.net

The default action to handle wakeup event. Currently just prints something,
maybe we should call .resume(). The routine will be called in task context.

---
 drivers/base/power/main.c |    6 ++++++
 include/linux/pm.h        |    2 ++
 2 files changed, 8 insertions(+)

Index: linux/drivers/base/power/main.c
===================================================================
--- linux.orig/drivers/base/power/main.c	2008-09-08 13:55:56.000000000 +0800
+++ linux/drivers/base/power/main.c	2008-09-08 14:22:12.000000000 +0800
@@ -785,3 +785,9 @@ void __suspend_report_result(const char 
 	}
 }
 EXPORT_SYMBOL_GPL(__suspend_report_result);
+
+void device_receive_wakeup_event(struct device *dev)
+{
+	printk("Device %s invokes wakeup event\n", dev->bus_id);
+}
+EXPORT_SYMBOL(device_receive_wakeup_event);
Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h	2008-09-08 13:56:51.000000000 +0800
+++ linux/include/linux/pm.h	2008-09-08 14:22:12.000000000 +0800
@@ -436,6 +436,8 @@ static inline int device_suspend(pm_mess
 
 #endif /* !CONFIG_PM_SLEEP */
 
+void device_receive_wakeup_event(struct device *dev);
+
 /*
  * Global Power Management flags
  * Used to keep APM and ACPI from both being active

-- 
