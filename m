From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/11] Revert
 "ACPI: don't enable control method power button as wakeup device when Fixed
 Power button is used"
Date: Thu, 27 Nov 2008 02:25:10 -0500
Message-ID: <3bdca1b863c1ebcb2244fc0cb683876d7330e62b.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:43800 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbYK0HZ1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:27 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KAZ00LCHDYAQCT8@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:23 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This reverts commit faee816b1502385dc9bc5abf2960d1cc645844d1.

http://bugzilla.kernel.org/show_bug.cgi?id=12091

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bd5253e..39b7233 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -751,16 +751,6 @@ static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 	if (!acpi_match_device_ids(device, button_device_ids))
 		device->wakeup.flags.run_wake = 1;
 
-	/*
-	 * Don't set Power button GPE as run_wake
-	 * if Fixed Power button is used
-	 */
-	if (!strcmp(device->pnp.hardware_id, "PNP0C0C") &&
-		!(acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON)) {
-		device->wakeup.flags.run_wake = 0;
-		device->wakeup.flags.valid = 0;
-	}
-
       end:
 	if (ACPI_FAILURE(status))
 		device->flags.wake_capable = 0;
-- 
1.5.6.5

