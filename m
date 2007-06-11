From: Holger Macht <hmacht@suse.de>
Subject: [PATCH] ACPI: dock: Send key=value pair instead of plain value
Date: Tue, 12 Jun 2007 00:12:00 +0200
Message-ID: <20070611221200.GA5675@homac.gate.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:41863 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbXFKWMC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jun 2007 18:12:02 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org

Send key=value pair along with the uevent instead of a plain value so that
userspace (udev) can handle it like common environment variables.

Signed-off-by: Holger Macht <hmacht@suse.de>
---

Patch applies to recent acpi-test tree

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index dc3df93..877ca1c 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -336,13 +336,13 @@ static void hotplug_dock_devices(struct
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
 	struct device *dev = &dock_device->dev;
-	char event_string[7];
+	char event_string[13];
 	char *envp[] = { event_string, NULL };
 
 	if (num == UNDOCK_EVENT)
-		sprintf(event_string, "UNDOCK");
+		sprintf(event_string, "EVENT=undock");
 	else
-		sprintf(event_string, "DOCK");
+		sprintf(event_string, "EVENT=dock");
 
 	/*
 	 * Indicate that the status of the dock station has
