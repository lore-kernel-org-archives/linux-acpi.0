From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/32] ACPI: Thermal: Drop concurrent thermal checks
Date: Fri, 21 Sep 2007 23:46:22 -0400
Message-ID: <11904328111749-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
 <11904328061489-git-send-email-lenb@kernel.org>
 <119043280633-git-send-email-lenb@kernel.org>
 <1190432807843-git-send-email-lenb@kernel.org>
 <1190432808586-git-send-email-lenb@kernel.org>
 <11904328092328-git-send-email-lenb@kernel.org>
 <11904328102889-git-send-email-lenb@kernel.org>
 <1190432811241-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:60100 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756990AbXIVDqx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:53 -0400
In-Reply-To: <1190432811241-git-send-email-lenb@kernel.org>
Message-Id: <6e2157858ac94530fddbf19dc59ab6b392baf1f3.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Fix for #3686, where get_temperature() may cause thermal notify, which
causes one more get_temperature().

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 15d5fdc..69ec73b 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -195,6 +195,7 @@ struct acpi_thermal {
 	struct acpi_thermal_trips trips;
 	struct acpi_handle_list devices;
 	struct timer_list timer;
+	struct mutex lock;
 };
 
 static const struct file_operations acpi_thermal_state_fops = {
@@ -721,11 +722,15 @@ static void acpi_thermal_check(void *data)
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
 
@@ -816,8 +821,8 @@ static void acpi_thermal_check(void *data)
 			add_timer(&(tz->timer));
 		}
 	}
-
-	return;
+      unlock:
+	mutex_unlock(&tz->lock);
 }
 
 /* --------------------------------------------------------------------------
@@ -1254,7 +1259,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	acpi_driver_data(device) = tz;
-
+	mutex_init(&tz->lock);
 	result = acpi_thermal_get_info(tz);
 	if (result)
 		goto end;
@@ -1324,7 +1329,7 @@ static int acpi_thermal_remove(struct acpi_device *device, int type)
 	}
 
 	acpi_thermal_remove_fs(device);
-
+	mutex_destroy(&tz->lock);
 	kfree(tz);
 	return 0;
 }
-- 
1.5.3.1.27.g57543
