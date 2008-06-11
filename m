From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/23] bay: exit if notify handler cannot be installed
Date: Wed, 11 Jun 2008 03:59:18 -0400
Message-ID: <9f4574df153b85e42dbe4bb835d2be61c336a7d6.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:65151 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbYFKH7k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:40 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A00AM6GVAMO3C@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:35 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Holger Macht <hmacht@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Holger Macht <hmacht@suse.de>

If acpi_install_notify_handler() for a bay device fails, the bay driver is
superfluous.  Most likely, another driver (like libata) is already caring
about this device anyway.  Furthermore,
register_hotplug_dock_device(acpi_handle) from the dock driver must not be
called twice with the same handler.  This would result in an endless loop
consuming 100% of CPU.  So clean up and exit.

Signed-off-by: Holger Macht <hmacht@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index d2fc941..26038c2 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -301,16 +301,20 @@ static int bay_add(acpi_handle handle, int id)
 	 */
 	pdev->dev.uevent_suppress = 0;
 
-	if (acpi_bay_add_fs(new_bay)) {
-		platform_device_unregister(new_bay->pdev);
-		goto bay_add_err;
-	}
-
 	/* register for events on this device */
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 			bay_notify, new_bay);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Error installing bay notify handler\n");
+		printk(KERN_INFO PREFIX "Error installing bay notify handler\n");
+		platform_device_unregister(new_bay->pdev);
+		goto bay_add_err;
+	}
+
+	if (acpi_bay_add_fs(new_bay)) {
+		acpi_remove_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+					   bay_notify);
+		platform_device_unregister(new_bay->pdev);
+		goto bay_add_err;
 	}
 
 	/* if we are on a dock station, we should register for dock
-- 
1.5.6.rc2.23.gea81e

