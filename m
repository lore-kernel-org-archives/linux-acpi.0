From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v4 1/5] ACPI: button: Add indication of BIOS notification and faked events
Date: Wed, 31 May 2017 17:41:50 +0800
Message-ID: <236859123733c251757726cca329ca5b405d1ee8.1496221776.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56752 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbdEaJl5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 05:41:57 -0400
In-Reply-To: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, systemd-devel@lists.freedesktop.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>

This patch adds a parameter to acpi_lid_notify_state() so that it can act
differently against BIOS notification and kernel faked events.

Cc: <systemd-devel@lists.freedesktop.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9ad8cdb..725a15a 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -138,7 +138,8 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
 	return lid_state ? 1 : 0;
 }
 
-static int acpi_lid_notify_state(struct acpi_device *device, int state)
+static int acpi_lid_notify_state(struct acpi_device *device,
+				 int state, bool is_bios_event)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 	int ret;
@@ -360,7 +361,8 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
-static int acpi_lid_update_state(struct acpi_device *device)
+static int acpi_lid_update_state(struct acpi_device *device,
+				 bool is_bios_event)
 {
 	int state;
 
@@ -368,17 +370,17 @@ static int acpi_lid_update_state(struct acpi_device *device)
 	if (state < 0)
 		return state;
 
-	return acpi_lid_notify_state(device, state);
+	return acpi_lid_notify_state(device, state, is_bios_event);
 }
 
 static void acpi_lid_initialize_state(struct acpi_device *device)
 {
 	switch (lid_init_state) {
 	case ACPI_BUTTON_LID_INIT_OPEN:
-		(void)acpi_lid_notify_state(device, 1);
+		(void)acpi_lid_notify_state(device, 1, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device);
+		(void)acpi_lid_update_state(device, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
@@ -398,7 +400,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
-			acpi_lid_update_state(device);
+			acpi_lid_update_state(device, true);
 		} else {
 			int keycode;
 
-- 
2.7.4

