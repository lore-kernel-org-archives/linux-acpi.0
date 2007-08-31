From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: Thermal: Drop concurrent thermal checks
Date: Sat, 01 Sep 2007 00:11:59 +0400
Message-ID: <20070831201159.27101.58547.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:48068 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761653AbXHaUMV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Aug 2007 16:12:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Fix for #3686, where get_temperature() may cause thermal notify, which
causes one more get_temperature().

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/thermal.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index bc6d586..cb5ebd8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -195,6 +195,7 @@ struct acpi_thermal {
 	struct acpi_thermal_trips trips;
 	struct acpi_handle_list devices;
 	struct timer_list timer;
+	struct mutex lock;
 };
 
 static const struct file_operations acpi_thermal_state_fops = {
@@ -720,11 +721,15 @@ static void acpi_thermal_check(void *data)
 		return;
 	}
 
+	/* Check if someone else is already running */
+	if (!mutex_trylock(&tz->lock))
+		return;
+
 	state = tz->state;
 
 	result = acpi_thermal_get_temperature(tz);
 	if (result)
-		return;
+		goto unlock;
 
 	memset(&tz->state, 0, sizeof(tz->state));
 
@@ -813,8 +818,8 @@ static void acpi_thermal_check(void *data)
 			add_timer(&(tz->timer));
 		}
 	}
-
-	return;
+      unlock:
+	mutex_unlock(&tz->lock);
 }
 
 /* --------------------------------------------------------------------------
@@ -1251,7 +1256,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	acpi_driver_data(device) = tz;
-
+	mutex_init(&tz->lock);
 	result = acpi_thermal_get_info(tz);
 	if (result)
 		goto end;
@@ -1321,7 +1326,7 @@ static int acpi_thermal_remove(struct acpi_device *device, int type)
 	}
 
 	acpi_thermal_remove_fs(device);
-
+	mutex_destroy(&tz->lock);
 	kfree(tz);
 	return 0;
 }

