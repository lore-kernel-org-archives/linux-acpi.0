From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 5/6] thermal: Only set passive_delay for forced passive cooling
Date: Wed, 26 Aug 2009 18:17:24 +0200
Message-ID: <1251303445-25317-6-git-send-email-elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml110.kpnxchange.com ([195.121.3.14]:49603 "EHLO
	CPSMTPM-EML110.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751601AbZHZQRZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Aug 2009 12:17:25 -0400
In-Reply-To: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Matthew Garrett <mjg@redhat.com>, Zhang Rui <rui.zhang@intel.com>

Setting polling_delay is useless as passive_delay has priority,
so the value shown in proc isn't the actual polling delay. It
also gives the impression to the user that he can change the
polling interval through proc, while in fact he can't.

Also, unset passive_delay when the forced passive trip point is
unbound to allow polling to be disabled.

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---

I'm not sure why polling_delay was getting set here. Possibly the
intention was to set polling_frequency instead, which is in deci-
seconds and would thus explain the factor 10 between the values.
But even for polling_frequency there is IMO no reason to set it.

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 2d13d0d..ceda0f1 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -241,6 +241,8 @@ passive_store(struct device *dev, struct device_attribute *attr,
 								 cdev);
 		}
 		mutex_unlock(&thermal_list_lock);
+		if (!tz->passive_delay)
+			tz->passive_delay = 1000;
 	} else if (!state && tz->forced_passive) {
 		mutex_lock(&thermal_list_lock);
 		list_for_each_entry(cdev, &thermal_cdev_list, node) {
@@ -251,17 +253,12 @@ passive_store(struct device *dev, struct device_attribute *attr,
 								   cdev);
 		}
 		mutex_unlock(&thermal_list_lock);
+		tz->passive_delay = 0;
 	}
 
 	tz->tc1 = 1;
 	tz->tc2 = 1;
 
-	if (!tz->passive_delay)
-		tz->passive_delay = 1000;
-
-	if (!tz->polling_delay)
-		tz->polling_delay = 10000;
-
 	tz->forced_passive = state;
 
 	thermal_zone_device_update(tz);
