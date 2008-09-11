From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC 1/5] devcore introduce wakeup_event callback
Date: Thu, 11 Sep 2008 14:30:38 +0800
Message-ID: <20080911063822.973881418@sli10-desk.sh.intel.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62977 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbYIKGiZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 02:38:25 -0400
Content-Disposition: inline; filename=devcore-introduce-wakeup_event.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: stern@rowland.harvard.edu, david-b@pacbell.net, dbrownell@users.sourceforge.net

Introduce .wakeup_event(). When a device gets a wakeup event,
the callback is called. The callback usually should disable wakeup event.

---
 include/linux/pm.h |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h	2008-09-11 10:56:27.000000000 +0800
+++ linux/include/linux/pm.h	2008-09-11 10:56:29.000000000 +0800
@@ -125,6 +125,12 @@ typedef struct pm_message {
  *	make ANY assumptions about the hardware state right prior to @restore().
  *	On most platforms, there are no restrictions on availability of
  *	resources like clocks during @restore().
+ * @wakeup_event: Checks if a wakeup event occurs. In bus level, the op might
+ *	check all devices under the bus and call device_receive_wakeup_event()
+ *	for devices which invoke wakeup event. In device level, the op just
+ *	returns if a wakeup event occurs. Note, if device follows standard
+ *	mechanism for wakeup which bus level can handle, device level op can be
+ *	empty.
  *
  * All of the above callbacks, except for @complete(), return error codes.
  * However, the error codes returned by the resume operations, @resume(),
@@ -151,6 +157,7 @@ struct pm_ops {
 	int (*thaw)(struct device *dev);
 	int (*poweroff)(struct device *dev);
 	int (*restore)(struct device *dev);
+	bool (*wakeup_event)(struct device *dev);
 };
 
 /**

-- 
