From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] ACPI: dock: send envp with uevent
Date: Wed, 9 May 2007 15:10:22 -0700
Message-ID: <20070509151022.c9753632.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37190 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759884AbXEIWNT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 18:13:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

ACPI: dock: send env with uevent

Send an env along with our KOBJ_CHANGE uevent so that user space has 
the option of checking for that to see if a dock or undock has occurred.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/drivers/acpi/dock.c
===================================================================
--- 2.6-git.orig/drivers/acpi/dock.c
+++ 2.6-git/drivers/acpi/dock.c
@@ -336,11 +336,19 @@ static void hotplug_dock_devices(struct 
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
 	struct device *dev = &dock_device->dev;
+	char event_string[7];
+	char *envp[] = { event_string, NULL };
+
+	if (num == UNDOCK_EVENT)
+		sprintf(event_string, "UNDOCK");
+	else
+		sprintf(event_string, "DOCK");
+
 	/*
 	 * Indicate that the status of the dock station has
 	 * changed.
 	 */
-	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
 }
 
 /**
