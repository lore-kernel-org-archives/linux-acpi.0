From: al.stone@linaro.org
Subject: [PATCH v3 2/5] ACPI: bus master reload not supported in reduced HW mode
Date: Wed,  4 Dec 2013 14:22:04 -0700
Message-ID: <1386192127-28564-3-git-send-email-al.stone@linaro.org>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:48619 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab3LDVWU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 16:22:20 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so28374336iej.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 13:22:20 -0800 (PST)
In-Reply-To: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

Remove the saving and restoring of bus master reload registers in
suspend/resume when in reduced HW mode; according to the spec, no
such registers should exist

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 597cdab..8b48c08 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -202,7 +202,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
 
 #endif
 
-#ifdef CONFIG_PM_SLEEP
+#if (IS_ENABLED(CONFIG_PM_SLEEP) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE))
 static u32 saved_bm_rld;
 
 static int acpi_processor_suspend(void)
@@ -236,7 +236,10 @@ void acpi_processor_syscore_exit(void)
 {
 	unregister_syscore_ops(&acpi_processor_syscore_ops);
 }
-#endif /* CONFIG_PM_SLEEP */
+#else
+void acpi_processor_syscore_init(void) { return; }
+void acpi_processor_syscore_exit(void) { return; }
+#endif
 
 #if defined(CONFIG_X86)
 static void tsc_check_state(int state)
-- 
1.8.3.1

