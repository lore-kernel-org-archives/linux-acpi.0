From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 1/2] ACPI / processor: Replace hard-coded "ACPI0007" with ACPI_PROCESSOR_DEVICE_HID
Date: Sat,  8 Feb 2014 20:46:25 +0800
Message-ID: <1391863586-3157-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36535 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaBHMrC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Feb 2014 07:47:02 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so4274729pab.5
        for <linux-acpi@vger.kernel.org>; Sat, 08 Feb 2014 04:47:01 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

Replace "ACPI0007" with ACPI_PROCESSOR_DEVICE_HID to improve code
readability.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/processor_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a4eea9a..849cfd6 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -390,5 +390,6 @@ void __init acpi_early_processor_set_pdc(void)
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    early_init_pdc, NULL, NULL, NULL);
-	acpi_get_devices("ACPI0007", early_init_pdc, NULL, NULL);
+	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID,
+				early_init_pdc, NULL, NULL);
 }
-- 
1.7.9.5

