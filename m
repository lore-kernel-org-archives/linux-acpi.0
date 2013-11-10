From: al.stone@linaro.org
Subject: [PATCH 08/12] ACPI: in HW reduced mode, getting power latencies from FADT is not allowed
Date: Sat,  9 Nov 2013 18:36:18 -0700
Message-ID: <1384047382-20623-9-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35545 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758621Ab3KJBgk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:40 -0500
Received: by mail-ie0-f179.google.com with SMTP id u16so2500208iet.10
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:39 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Make sure we are not in HW reduced mode when we rely on the the
P_LVL2_LAT or P_LVL3_LAT (c2_latency, c3_latency) values from the
FADT.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 28079a6..e2bd0bf 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -644,7 +644,7 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
 	memset(pr->power.states, 0, sizeof(pr->power.states));
 
 	result = acpi_processor_get_power_info_cst(pr);
-	if (result == -ENODEV)
+	if (!acpi_gbl_reduced_hardware && (result == -ENODEV))
 		result = acpi_processor_get_power_info_fadt(pr);
 
 	if (result)
-- 
1.8.3.1

