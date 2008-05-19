From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/7] ACPI PM: Remove obsolete Toshiba workaround
Date: Tue, 20 May 2008 01:38:10 +0200
Message-ID: <200805200138.11333.rjw@sisk.pl>
References: <200805200129.19904.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40112 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848AbYESXm1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 May 2008 19:42:27 -0400
In-Reply-To: <200805200129.19904.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove the obsolete workaround for a Toshiba Satellite 4030cdt
S1 problem from drivers/acpi/sleep/main.c .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/acpi/sleep/main.c |   31 -------------------------------
 1 file changed, 31 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
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
@@ -232,26 +223,6 @@ static struct platform_suspend_ops acpi_
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
@@ -490,8 +461,6 @@ int __init acpi_sleep_init(void)
 	u8 type_a, type_b;
 #ifdef CONFIG_SUSPEND
 	int i = 0;
-
-	dmi_check_system(acpisleep_dmi_table);
 #endif
 
 	if (acpi_disabled)

