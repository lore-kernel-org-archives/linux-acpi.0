From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/84] ACPI PM: Remove obsolete Toshiba workaround
Date: Sat, 28 Jun 2008 01:43:29 -0400
Message-ID: <4a754764f367b0661dfa3cdb764b93b1b4be43d6.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:62890 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbYF1FpA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:00 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BBKRYZMG71@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:00 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove the obsolete workaround for a Toshiba Satellite 4030cdt
S1 problem from drivers/acpi/sleep/main.c .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |   31 -------------------------------
 1 files changed, 0 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index fbd40e9..0f2caea 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -62,8 +62,6 @@ static u32 acpi_suspend_states[] = {
 	[PM_SUSPEND_MAX] = ACPI_STATE_S5
 };
 
-static int init_8259A_after_S1;
-
 /**
  *	acpi_suspend_begin - Set the target system sleep state to the state
  *		associated with given @pm_state, if supported.
@@ -186,13 +184,6 @@ static void acpi_suspend_finish(void)
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
 	acpi_target_sleep_state = ACPI_STATE_S0;
-
-#ifdef CONFIG_X86
-	if (init_8259A_after_S1) {
-		printk("Broken toshiba laptop -> kicking interrupts\n");
-		init_8259A(0);
-	}
-#endif
 }
 
 /**
@@ -232,26 +223,6 @@ static struct platform_suspend_ops acpi_suspend_ops = {
 	.finish = acpi_suspend_finish,
 	.end = acpi_suspend_end,
 };
-
-/*
- * Toshiba fails to preserve interrupts over S1, reinitialization
- * of 8259 is needed after S1 resume.
- */
-static int __init init_ints_after_s1(const struct dmi_system_id *d)
-{
-	printk(KERN_WARNING "%s with broken S1 detected.\n", d->ident);
-	init_8259A_after_S1 = 1;
-	return 0;
-}
-
-static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
-	{
-	 .callback = init_ints_after_s1,
-	 .ident = "Toshiba Satellite 4030cdt",
-	 .matches = {DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),},
-	 },
-	{},
-};
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
@@ -473,8 +444,6 @@ int __init acpi_sleep_init(void)
 	u8 type_a, type_b;
 #ifdef CONFIG_SUSPEND
 	int i = 0;
-
-	dmi_check_system(acpisleep_dmi_table);
 #endif
 
 	if (acpi_disabled)
-- 
1.5.6.1.89.gd544

