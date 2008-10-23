From: Len Brown <lenb@kernel.org>
Subject: [PATCH 019/122] ACPI: don't enable control method power button as
 wakeup device when Fixed Power button is used
Date: Thu, 23 Oct 2008 02:37:53 -0400
Message-ID: <faee816b1502385dc9bc5abf2960d1cc645844d1.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:62846 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbYJWGju (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:50 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KW0II9XNY2@vms172071.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:46 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

don't enable control method power button as wakeup device
when Fixed Power button is used.

http://bugzilla.kernel.org/show_bug.cgi?id=10503

Tested-by: walken@zoy.org <walken@zoy.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f6f52c1..5ce14ae 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -744,6 +744,16 @@ static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 	if (!acpi_match_device_ids(device, button_device_ids))
 		device->wakeup.flags.run_wake = 1;
 
+	/*
+	 * Don't set Power button GPE as run_wake
+	 * if Fixed Power button is used
+	 */
+	if (!strcmp(device->pnp.hardware_id, "PNP0C0C") &&
+		!(acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON)) {
+		device->wakeup.flags.run_wake = 0;
+		device->wakeup.flags.valid = 0;
+	}
+
       end:
 	if (ACPI_FAILURE(status))
 		device->flags.wake_capable = 0;
-- 
1.5.5.1

