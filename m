From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC 2/5] devcore adds generic wakeup event handler
Date: Thu, 11 Sep 2008 14:30:39 +0800
Message-ID: <20080911063823.083409592@sli10-desk.sh.intel.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62977 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbYIKGi0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 02:38:26 -0400
Content-Disposition: inline; filename=devcore-introduce-default-pme-action.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: stern@rowland.harvard.edu, david-b@pacbell.net, dbrownell@users.sourceforge.net

The default action to handle wakeup event. Currently just prints something,
maybe we should call .resume(). The routine will be called in task context.

---
 drivers/base/power/main.c |    6 ++++++
 include/linux/pm.h        |    2 ++
 2 files changed, 8 insertions(+)

Index: linux/drivers/base/power/main.c
===================================================================
--- linux.orig/drivers/base/power/main.c	2008-09-11 10:56:26.000000000 +0800
+++ linux/drivers/base/power/main.c	2008-09-11 10:56:39.000000000 +0800
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
--- linux.orig/include/linux/pm.h	2008-09-11 10:56:29.000000000 +0800
+++ linux/include/linux/pm.h	2008-09-11 10:56:39.000000000 +0800
@@ -440,6 +440,8 @@ static inline int device_suspend(pm_mess
 
 #endif /* !CONFIG_PM_SLEEP */
 
+void device_receive_wakeup_event(struct device *dev);
+
 /*
  * Global Power Management flags
  * Used to keep APM and ACPI from both being active

-- 
