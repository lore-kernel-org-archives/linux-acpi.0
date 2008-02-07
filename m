From: Len Brown <lenb@kernel.org>
Subject: [PATCH 021/112] ACPI: Fix acpi_pm_device_sleep_state()
Date: Thu,  7 Feb 2008 04:33:43 -0500
Message-ID: <ad3399c378993152f12c23304ee56d7f9108e758.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756326AbYBGJfp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:45 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Fix acpi_pm_device_sleep_state() to return the value returned
by _SxD if the device is supposed to wake up the system from
given sleep state and the evaluation of _SxW fails (e.g. _SxW
is not present).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 2c0b663..99181c8 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -386,11 +386,20 @@ int acpi_pm_device_sleep_state(struct device *dev, int wake, int *d_min_p)
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
 	    (wake && adev->wakeup.state.enabled &&
 	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
+		acpi_status status;
+
 		acpi_method[3] = 'W';
-		acpi_evaluate_integer(handle, acpi_method, NULL, &d_max);
-		/* Sanity check */
-		if (d_max < d_min)
+		status = acpi_evaluate_integer(handle, acpi_method, NULL,
+						&d_max);
+		if (ACPI_FAILURE(status)) {
+			d_max = d_min;
+		} else if (d_max < d_min) {
+			/* Warn the user of the broken DSDT */
+			printk(KERN_WARNING "ACPI: Wrong value from %s\n",
+				acpi_method);
+			/* Sanitize it */
 			d_min = d_max;
+		}
 	}
 
 	if (d_min_p)
-- 
1.5.4.23.gef5b9

