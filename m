From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/42] Thermal_Framework-Fix_crash_during_hwmon_unregister
Date: Wed, 23 Mar 2011 02:42:39 -0400
Message-ID: <4fdfbe8506fa236f3c4cc915b24e70f84a6f768a.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37006 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab1CWHHf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:35 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:35 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Len Brown <len.brown@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch fixes the following bug:
The thermal framework creates a temp*_crit interface, only when
the get_crit_temp pointer is defined. But during the _unregister_
path, without checking for the function definition, it is trying to
remove the temp*_crit interface.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 713b7ea..fc6f2a5 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -560,7 +560,8 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	tz->hwmon = NULL;
 	device_remove_file(hwmon->device, &tz->temp_input.attr);
-	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+	if (tz->ops->get_crit_temp)
+		device_remove_file(hwmon->device, &tz->temp_crit.attr);
 
 	mutex_lock(&thermal_list_lock);
 	list_del(&tz->hwmon_node);
-- 
1.7.4.1.343.ga91df

