From: Len Brown <lenb@kernel.org>
Subject: [PATCH 005/103] thermal: Only set passive_delay for forced_passive
 cooling
Date: Wed, 16 Dec 2009 03:35:16 -0500
Message-ID: <e4143b0324a6a468cb00c4341cd20d60cc441252.1260952471.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:39440 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761820AbZLPIhF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 03:37:05 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00F1JL9Q5E2J@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 02:37:02 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Frans Pop <elendil@planet.nl>

Setting polling_delay is useless as passive_delay has priority,
so the value shown in proc isn't the actual polling delay. It
also gives the impression to the user that he can change the
polling interval through proc, while in fact he can't.

Also, unset passive_delay when the forced passive trip point is
unbound to allow polling to be disabled.

Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Matthew Garrett <mjg@redhat.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 310e40a..663c2fd 100644
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
-- 
1.6.0.6

