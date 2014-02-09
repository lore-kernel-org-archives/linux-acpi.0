From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [Update][PATCH 1/2] ACPI / processor: Replace hard-coded "ACPI0007" with ACPI_PROCESSOR_DEVICE_HID
Date: Sun,  9 Feb 2014 17:12:27 +0800
Message-ID: <1391937147-5250-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:41014 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbaBIJN1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Feb 2014 04:13:27 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so4514757pdb.38
        for <linux-acpi@vger.kernel.org>; Sun, 09 Feb 2014 01:13:27 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

Replace "ACPI0007" with ACPI_PROCESSOR_DEVICE_HID to improve code
readability.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/processor_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a4eea9a..f31d0fb 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -390,5 +390,5 @@ void __init acpi_early_processor_set_pdc(void)
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    early_init_pdc, NULL, NULL, NULL);
-	acpi_get_devices("ACPI0007", early_init_pdc, NULL, NULL);
+	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, early_init_pdc, NULL, NULL);
 }
-- 
1.7.9.5

