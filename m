From: al.stone@linaro.org
Subject: [PATCH v2 2/6] ACPI: bus master reload not supported in reduced HW mode
Date: Thu, 21 Nov 2013 17:41:51 -0700
Message-ID: <1385080915-23430-3-git-send-email-al.stone@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34621 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab3KVAmL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 19:42:11 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so523557pbc.41
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2013 16:42:11 -0800 (PST)
In-Reply-To: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

Remove the saving and restoring of bus master reload registers in
suspend/resume when in reduced HW mode; according to the spec, no
such registers should exist

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 597cdab..b18e7ab 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -202,7 +202,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
 
 #endif
 
-#ifdef CONFIG_PM_SLEEP
+#if (IS_ENABLED(CONFIG_PM_SLEEP) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE))
 static u32 saved_bm_rld;
 
 static int acpi_processor_suspend(void)
@@ -236,7 +236,11 @@ void acpi_processor_syscore_exit(void)
 {
 	unregister_syscore_ops(&acpi_processor_syscore_ops);
 }
-#endif /* CONFIG_PM_SLEEP */
+#else
+/* Bus master reload is not supported in reduced HW mode. */
+static int acpi_processor_suspend(void) { return 0; }
+static void acpi_processor_resume(void) { return; }
+#endif
 
 #if defined(CONFIG_X86)
 static void tsc_check_state(int state)
-- 
1.8.3.1

