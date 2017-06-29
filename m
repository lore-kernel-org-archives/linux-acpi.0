From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 2/2] thermal: core: Allow to disable polling when disabling thermal zone.
Date: Thu, 29 Jun 2017 18:50:35 +0200
Message-ID: <20170629165035.23101-2-enric.balletbo@collabora.com>
References: <20170629165035.23101-1-enric.balletbo@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35227 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdF2Qux (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jun 2017 12:50:53 -0400
In-Reply-To: <20170629165035.23101-1-enric.balletbo@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>, Sameer Nanda <snanda@chromium.org>

Under each thermal zone there is a optional file called "mode". Writing
enabled or disabled to this file allows a given thermal zone to be enabled
or disabled, but in current code, the monitoring queue doesn't stops. Add
the code to disable polling when disabling thermal zone and enable polling
when enabling the thermal zone.

This patch is based on the original Sameer Nanda <snanda@chromium.org>
patch that implemented this idea for the ACPI thermal driver.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
 - Implement in thermal subsystem instead of ACPI thermal driver (Zhang Rui)

v1: https://patchwork.kernel.org/patch/9804229/

 drivers/thermal/thermal_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5a51c74..869c8f3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -292,6 +292,17 @@ static void thermal_unregister_governors(void)
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
+	enum thermal_device_mode mode;
+
+	if (tz->ops->get_mode) {
+		/* When the thermal zone is disabled stop the polling */
+		tz->ops->get_mode(tz, &mode);
+		if (mode == THERMAL_DEVICE_DISABLED) {
+			cancel_delayed_work(&tz->poll_queue);
+			return;
+		}
+	}
+
 	if (delay > 1000)
 		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
 				 round_jiffies(msecs_to_jiffies(delay)));
-- 
2.9.3

