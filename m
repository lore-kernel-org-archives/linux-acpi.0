From: Len Brown <len.brown@intel.com>
Subject: [PATCH 14/16] ACPI: Remove references to ACPI_STATE_S2 from acpi_pm_enter
Date: Wed, 25 Jul 2007 01:51:23 -0400
Message-ID: <11853427003606-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5266 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbXGYFvm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:42 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <50ad147aa09c829cd452fae6ca99396c0b5b0695.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove references to ACPI_STATE_S2, introduced by
acpi-implement-the-set_target-callback-from-pm_ops.patch, from acpi_pm_enter().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 55eca6e..29bdb01 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -81,8 +81,8 @@ static int acpi_pm_prepare(suspend_state_t pm_state)
  *	acpi_pm_enter - Actually enter a sleep state.
  *	@pm_state: ignored
  *
- *	Flush caches and go to sleep. For STR or S2, we have to call
- *	arch-specific assembly, which in turn call acpi_enter_sleep_state().
+ *	Flush caches and go to sleep. For STR we have to call arch-specific
+ *	assembly, which in turn call acpi_enter_sleep_state().
  *	It's unfortunate, but it works. Please fix if you're feeling frisky.
  */
 
@@ -95,7 +95,7 @@ static int acpi_pm_enter(suspend_state_t pm_state)
 	ACPI_FLUSH_CPU_CACHE();
 
 	/* Do arch specific saving of state. */
-	if (acpi_state == ACPI_STATE_S2 || acpi_state == ACPI_STATE_S3) {
+	if (acpi_state == ACPI_STATE_S3) {
 		int error = acpi_save_state_mem();
 
 		if (error) {
@@ -112,7 +112,6 @@ static int acpi_pm_enter(suspend_state_t pm_state)
 		status = acpi_enter_sleep_state(acpi_state);
 		break;
 
-	case ACPI_STATE_S2:
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel();
 		break;
@@ -129,7 +128,7 @@ static int acpi_pm_enter(suspend_state_t pm_state)
 	printk(KERN_DEBUG "Back to C!\n");
 
 	/* restore processor state */
-	if (acpi_state == ACPI_STATE_S2 || acpi_state == ACPI_STATE_S3)
+	if (acpi_state == ACPI_STATE_S3)
 		acpi_restore_state_mem();
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
-- 
1.5.3.rc2.22.g69a9b
