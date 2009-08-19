From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 1/5] introduce .wakeup_event ops
Date: Wed, 19 Aug 2009 15:24:11 +0800
Message-ID: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18231 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbZHSHYK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Aug 2009 03:24:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, mjg59 <mjg59@srcf.ucam.org>


Introduce .wakeup_event(). When a device gets a wakeup event,
the callback is called. The callback usually should check if the device
really invokes wakeup event and disable wakeup event if yes.

Usually driver should does nothing in the op as bus can handle it. But in some
cases, like pci bus, UHCI controller doesn't use standard PME registers for
wakeup, instead of using special approach. In this case, UHCI controller driver
should implement this op.

---
 include/linux/pm.h |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h	2009-08-19 11:44:41.000000000 +0800
+++ linux/include/linux/pm.h	2009-08-19 13:44:03.000000000 +0800
@@ -191,6 +191,13 @@ typedef struct pm_message {
  *	power state if all of the necessary conditions are satisfied.  Check
  *	these conditions and handle the device as appropriate, possibly queueing
  *	a suspend request for it.
+ *
+ * @wakeup_event: Checks if a wakeup event occurs. In bus level, the op might
+ *	check all devices under the bus and call device_receive_wakeup_event()
+ *	for devices which invoke wakeup event. In device level, the op just
+ *	returns if a wakeup event occurs. Note, if device follows standard
+ *	mechanism for wakeup which bus level can handle, device level op can be
+ *	empty.
  */
 
 struct dev_pm_ops {
@@ -211,6 +218,7 @@ struct dev_pm_ops {
 	int (*runtime_suspend)(struct device *dev);
 	int (*runtime_resume)(struct device *dev);
 	void (*runtime_idle)(struct device *dev);
+	bool (*wakeup_event)(struct device *dev);
 };
 
 /**


