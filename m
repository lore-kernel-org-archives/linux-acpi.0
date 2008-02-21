From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/26] ACPI: TSC breaks atkbd suspend
Date: Thu, 21 Feb 2008 04:25:34 -0500
Message-ID: <6133116849219f4e657ead39c7ac3922583f5a6e.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36609 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757059AbYBUJ3U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:20 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, Pavel Machek <pavel@suse.cz>, Len Brown <len.brown@intel.com>

From: Pavel Machek <pavel@ucw.cz>

TSC is used even on machines when CONFIG_X86_TSC is not set (X86_TSC
means _require_ TSC), but it is not properly disabled when it is
unusable, because ACPI code understood the config switch as "may use
TSC".

This actually fixes suspend problems on my x60.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 980e1c3..6f3b217 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -364,7 +364,7 @@ int acpi_processor_resume(struct acpi_device * device)
 	return 0;
 }
 
-#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
 static int tsc_halts_in_c(int state)
 {
 	switch (boot_cpu_data.x86_vendor) {
@@ -544,7 +544,7 @@ static void acpi_processor_idle(void)
 		/* Get end time (ticks) */
 		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
-#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
 		/* TSC halts in C2, so notify users */
 		if (tsc_halts_in_c(ACPI_STATE_C2))
 			mark_tsc_unstable("possible TSC halt in C2");
@@ -609,7 +609,7 @@ static void acpi_processor_idle(void)
 			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
 		}
 
-#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
 		/* TSC halts in C3, so notify users */
 		if (tsc_halts_in_c(ACPI_STATE_C3))
 			mark_tsc_unstable("TSC halts in C3");
@@ -1500,7 +1500,7 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	acpi_idle_do_entry(cx);
 	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
-#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
 	/* TSC could halt in idle, so notify users */
 	if (tsc_halts_in_c(cx->type))
 		mark_tsc_unstable("TSC halts in idle");;
@@ -1614,7 +1614,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		spin_unlock(&c3_lock);
 	}
 
-#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
 	/* TSC could halt in idle, so notify users */
 	if (tsc_halts_in_c(ACPI_STATE_C3))
 		mark_tsc_unstable("TSC halts in idle");
-- 
1.5.4.2

