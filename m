From: "lan,Tianyu" <tianyu.lan@intel.com>
Subject: [PATCH] ACPI: Remove redundant code in the thermal_init()
Date: Fri, 10 Jun 2011 15:57:20 +0800
Message-ID: <1307692640.15256.79.camel@lantianyu-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55495 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071Ab1FJIGQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Jun 2011 04:06:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Thermal_tz_idr, thermal_cdev_idr, thermal_idr_lock and thermal_list_lock 
are only initialized in the thermal_zone_device_register(). The fucntion 
has not been invoked before here. So these variables have not been initialized. 
It doesn't need to destroy them after class_register failed.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/thermal/thermal_sys.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/thermal/thermal_sys.c
===================================================================
--- linux-2.6.orig/drivers/thermal/thermal_sys.c
+++ linux-2.6/drivers/thermal/thermal_sys.c
@@ -1314,12 +1314,9 @@
    int result = 0;
 
    result = class_register(&thermal_class);
-   if (result) {
-       idr_destroy(&thermal_tz_idr);
-       idr_destroy(&thermal_cdev_idr);
-       mutex_destroy(&thermal_idr_lock);
-       mutex_destroy(&thermal_list_lock);
-   }   
+   if (result)
+       return result;
+
    result = genetlink_init();
    return result;
 }


