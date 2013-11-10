From: al.stone@linaro.org
Subject: [PATCH 02/12] ACPI: bus master reload not supported in reduced HW mode
Date: Sat,  9 Nov 2013 18:36:12 -0700
Message-ID: <1384047382-20623-3-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:62022 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576Ab3KJBge (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:34 -0500
Received: by mail-ie0-f170.google.com with SMTP id to1so464851ieb.15
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:33 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Remove the saving and restoring of bus master reload registers in
suspend/resume when in reduces HW mode; according to the spec, no
such registers should exist

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 8 +++++++-
 include/acpi/acpixf.h         | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 35c8f2b..28079a6 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -210,6 +210,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
 #endif
 
 #ifdef CONFIG_PM_SLEEP
+#if (!ACPI_REDUCED_HARDWARE)
 static u32 saved_bm_rld;
 
 static int acpi_processor_suspend(void)
@@ -228,6 +229,11 @@ static void acpi_processor_resume(void)
 
 	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, saved_bm_rld);
 }
+#else
+/* Bus master reload is not supported in reduced HW mode. */
+static int acpi_processor_suspend(void) { return 0; }
+static void acpi_processor_resume(void) { return; }
+#endif /* (!ACPI_REDUCED_HARDWARE) */
 
 static struct syscore_ops acpi_processor_syscore_ops = {
 	.suspend = acpi_processor_suspend,
@@ -605,7 +611,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 		case ACPI_STATE_C2:
 			if (!cx->address)
 				break;
-			cx->valid = 1; 
+			cx->valid = 1;
 			break;
 
 		case ACPI_STATE_C3:
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d8f9457..27ef69b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -99,6 +99,9 @@ extern u8 acpi_gbl_disable_ssdt_table_load;
 #define ACPI_HW_DEPENDENT_RETURN_VOID(prototype) \
 	prototype;
 
+#define ACPI_HW_DEPENDENT_RETURN_INT(prototype) \
+	prototype;
+
 #else
 #define ACPI_HW_DEPENDENT_RETURN_STATUS(prototype) \
 	static ACPI_INLINE prototype {return(AE_NOT_CONFIGURED);}
@@ -109,6 +112,9 @@ extern u8 acpi_gbl_disable_ssdt_table_load;
 #define ACPI_HW_DEPENDENT_RETURN_VOID(prototype) \
 	static ACPI_INLINE prototype {return;}
 
+#define ACPI_HW_DEPENDENT_RETURN_INT(prototype) \
+	static ACPI_INLINE prototype {return 0;}
+
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
 /*
-- 
1.8.3.1

