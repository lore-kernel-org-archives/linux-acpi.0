From: al.stone@linaro.org
Subject: [PATCH 05/12] ACPI: ARM: exclude calls on ARM platforms, not include them on x86
Date: Sat,  9 Nov 2013 18:36:15 -0700
Message-ID: <1384047382-20623-6-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58481 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576Ab3KJBgh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:37 -0500
Received: by mail-ie0-f178.google.com with SMTP id aq17so511231iec.9
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:36 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Corrected #ifdef so that DMI is not used on ARM platforms which are
currently implementing reduced HW mode.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 6a54dd5..f41949a 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -513,11 +513,15 @@ void __init acpi_early_init(void)
 
 	acpi_gbl_permanent_mmap = 1;
 
+#if !(CONFIG_ARM || CONFIG_ARM64)
 	/*
+	 * NB: ARM does not use DMI at present.
+	 *
 	 * If the machine falls into the DMI check table,
 	 * DSDT will be copied to memory
 	 */
 	dmi_check_system(dsdt_dmi_table);
+#endif
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
-- 
1.8.3.1

