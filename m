From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/37] ACPI: Separate disabling of GPEs from _PTS
Date: Thu, 31 Jan 2008 23:36:59 -0500
Message-ID: <aedf9a8ff25f5890eb416d95520afdc5d40e539b.1201840183.git.len.brown@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:46275 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760928AbYBAEmH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 23:42:07 -0500
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The preparation to enter an ACPI system sleep state is now tied to
the disabling of GPEs, but the GPEs should not be disabled before
suspending devices.  Since on ACPI 1.0x systems the _PTS global
control method should be executed before suspending devices, we
need to disable GPEs separately.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |    4 ----
 drivers/acpi/sleep/main.c       |   17 +++++++++++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 13c93a1..fd1c4ba 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -229,10 +229,6 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_state)
 				"While executing method _SST"));
 	}
 
-	/* Disable/Clear all GPEs */
-
-	status = acpi_hw_disable_all_gpes();
-
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index fdd8139..198ff8a 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -91,10 +91,13 @@ static int acpi_pm_begin(suspend_state_t pm_state)
 
 static int acpi_pm_prepare(void)
 {
-	int error = acpi_sleep_prepare(acpi_target_sleep_state);
+	int error;
 
+	error = acpi_sleep_prepare(acpi_target_sleep_state);
 	if (error)
 		acpi_target_sleep_state = ACPI_STATE_S0;
+	else if (!ACPI_SUCCESS(acpi_hw_disable_all_gpes()))
+		error = -EFAULT;
 
 	return error;
 }
@@ -261,7 +264,16 @@ static int acpi_hibernation_start(void)
 
 static int acpi_hibernation_prepare(void)
 {
-	return acpi_sleep_prepare(ACPI_STATE_S4);
+	int error;
+
+	error = acpi_sleep_prepare(ACPI_STATE_S4);
+	if (error)
+		return error;
+
+	if (!ACPI_SUCCESS(acpi_hw_disable_all_gpes()))
+		error = -EFAULT;
+
+	return error;
 }
 
 static int acpi_hibernation_enter(void)
@@ -426,6 +438,7 @@ static void acpi_power_off_prepare(void)
 {
 	/* Prepare to power off the system */
 	acpi_sleep_prepare(ACPI_STATE_S5);
+	acpi_hw_disable_all_gpes();
 }
 
 static void acpi_power_off(void)
-- 
1.5.4.rc5.16.gc0279

