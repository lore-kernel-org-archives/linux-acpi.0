From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: Patch[1/1]:ThermalFramework:Fix_crash_during_hwmon_unregister
Date: Thu, 20 Jan 2011 14:56:03 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF046541094482EE4F@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37821 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110Ab1ATJ1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jan 2011 04:27:37 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Len/Rui,

This patch fixes the following bug:
The thermal framework creates a temp*_crit interface, only when
the get_crit_temp pointer is defined. But during the _unregister_
path, without checking for the function definition, it is trying to
remove the temp*_crit interface.

There can be a situation, where a driver registers with the framework
and does not have a temp*_crit interface. When this driver attempts to
unregister, this will cause a kernel crash.

------------------------------------------------
From: Durgadoss R <durgadoss.r@intel.com>

Date: Thu, 20 Jan 2011 02:40:56 +0530
Subject: [PATCH] Thermal_Framework-Fix_crash_during_hwmon_unregister

This patch fixes the following bug:
The thermal framework creates a temp*_crit interface, only when
the get_crit_temp pointer is defined. But during the _unregister_
path, without checking for the function definition, it is trying to
remove the temp*_crit interface.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

---
 drivers/thermal/thermal_sys.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 13c72c6..eef2e14 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -556,7 +556,8 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	tz->hwmon = NULL;
 	device_remove_file(hwmon->device, &tz->temp_input.attr);
-	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+	if (tz->ops->get_crit_temp)
+		device_remove_file(hwmon->device, &tz->temp_crit.attr);
 
 	mutex_lock(&thermal_list_lock);
 	list_del(&tz->hwmon_node);
-- 
1.6.5.2

