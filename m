From: shaohua.li@intel.com
Subject: [RFC 1/5] devcore introduce wakeup_event callback
Date: Mon, 08 Sep 2008 17:19:27 +0800
Message-ID: <20080908092305.221009807@sli10-desk.sh.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63194 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbYIHJXI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Sep 2008 05:23:08 -0400
Content-Disposition: inline; filename=devcore-introduce-wakeup_event.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: stern@rowland.harvard.edu, dbrownell@users.sourceforge.net

Introduce .wakeup_event(). When a device gets a wakeup event,
the callback is called. The callback usually should disable wakeup event.

---
 include/linux/pm.h |    3 +++
 1 file changed, 3 insertions(+)

Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h	2008-09-08 13:55:57.000000000 +0800
+++ linux/include/linux/pm.h	2008-09-08 13:56:51.000000000 +0800
@@ -125,6 +125,8 @@ typedef struct pm_message {
  *	make ANY assumptions about the hardware state right prior to @restore().
  *	On most platforms, there are no restrictions on availability of
  *	resources like clocks during @restore().
+ * @wakeup_event: Checks if a wakeup event occurs. If yes, wakeup event should
+ *      be disabled.
  *
  * All of the above callbacks, except for @complete(), return error codes.
  * However, the error codes returned by the resume operations, @resume(),
@@ -151,6 +153,7 @@ struct pm_ops {
 	int (*thaw)(struct device *dev);
 	int (*poweroff)(struct device *dev);
 	int (*restore)(struct device *dev);
+	int (*wakeup_event)(struct device *dev);
 };
 
 /**

-- 
