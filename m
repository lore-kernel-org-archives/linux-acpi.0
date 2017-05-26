From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v3 3/5] ACPI: button: Add lid event type debugging messages
Date: Sat, 27 May 2017 07:42:39 +0800
Message-ID: <f3272e813bb47a724cabe13c1d2ff68ea4483143.1495804411.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-acpi@vger.kernel.org

This patch adds very useful debugging information to lid events.
These messages and with ec_log_drv() can be used to demonstrate the order
between acpi_ec_resume() and acpi_button_resume().

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index a72f5bf..d3f90c6 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -201,12 +201,17 @@ static int acpi_lid_notify_state(struct acpi_device *device,
 		if (!state) {
 			input_report_switch(button->input, SW_LID, state);
 			input_sync(button->input);
+			pr_debug("faked open complement event.\n");
 		}
 	}
 
 	/* Send the platform triggered reliable event */
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
+	if (bios_notify)
+		pr_debug("notified %s event.\n", state ? "open" : "close");
+	else
+		pr_debug("faked %s event.\n", state ? "open" : "close");
 	button->last_state = !!state;
 	button->last_time = ktime_get();
 	button->last_is_bios = bios_notify;
-- 
2.7.4
