From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI : do not use Lid and Sleep button for S5 wakeup
Date: Mon, 03 Dec 2012 16:15:06 +0800
Message-ID: <1354522506.3063.9.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43572 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab2LCIPj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Dec 2012 03:15:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, anisse@astier.eu, "Zhang, Rui" <rui.zhang@intel.com>

>From 3e7b4da3783d200f35568f72b3b25f16df546ffe Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Fri, 30 Nov 2012 14:35:43 +0800
Subject: [PATCH] ACPI : do not use Lid and Sleep button for S5 wakeup

When system enters power off, the _PSW of Lid device is enabled.  
But this may cause the system to reboot instead of power off.

https://bugzilla.kernel.org/show_bug.cgi?id=35262

A proper way to fix this is to always disable lid wakeup capability
for S5.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d1ecca2..f20020a 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -807,8 +807,8 @@ acpi_bus_extract_wakeup_device_power_package(acpi_handle handle,
 static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
 {
 	struct acpi_device_id button_device_ids[] = {
-		{"PNP0C0D", 0},
 		{"PNP0C0C", 0},
+		{"PNP0C0D", 0},
 		{"PNP0C0E", 0},
 		{"", 0},
 	};
@@ -820,6 +820,11 @@ static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
 	/* Power button, Lid switch always enable wakeup */
 	if (!acpi_match_device_ids(device, button_device_ids)) {
 		device->wakeup.flags.run_wake = 1;
+		if (!acpi_match_device_ids(device, &button_device_ids[1])) {
+			/* Do not use Lid/sleep button for S5 wakeup */
+			if (device->wakeup.gpe_number == 5)
+				device->wakeup.gpe_number = 4;
+		}
 		device_set_wakeup_capable(&device->dev, true);
 		return;
 	}
-- 
1.7.9.5



