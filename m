From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 6/6] thermal: disable polling if passive_delay and polling_delay are both unset
Date: Wed, 26 Aug 2009 18:17:25 +0200
Message-ID: <1251303445-25317-7-git-send-email-elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751851AbZHZQRa@vger.kernel.org>
In-Reply-To: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Matthew Garrett <mjg@redhat.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

Otherwise polling will continue for the thermal zone even when
it is no longer needed, for example because forced passive cooling
was disabled.

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index ceda0f1..a59685b 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1012,6 +1012,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
 	else if (tz->polling_delay)
 		thermal_zone_device_set_polling(tz, tz->polling_delay);
+	else
+		thermal_zone_device_set_polling(tz, 0);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL(thermal_zone_device_update);
