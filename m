From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 6/6] thermal: disable polling if passive_delay and polling_delay are both unset
Date: Mon, 26 Oct 2009 08:39:04 +0100
Message-ID: <1256542744-26569-7-git-send-email-elendil@planet.nl>
References: <1256542744-26569-1-git-send-email-elendil@planet.nl>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:60983 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754895AbZJZHjE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2009 03:39:04 -0400
In-Reply-To: <1256542744-26569-1-git-send-email-elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, Frans Pop <elendil@planet.nl>, Zhang Rui <rui.zhang@intel.com>

Otherwise polling will continue for the thermal zone even when
it is no longer needed, for example because forced passive cooling
was disabled.

Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Matthew Garrett <mjg@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index fc5e92e..d69e6fd 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1019,6 +1019,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
 	else if (tz->polling_delay)
 		thermal_zone_device_set_polling(tz, tz->polling_delay);
+	else
+		thermal_zone_device_set_polling(tz, 0);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL(thermal_zone_device_update);
-- 
1.5.6.5

