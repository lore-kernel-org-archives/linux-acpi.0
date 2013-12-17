From: al.stone@linaro.org
Subject: [PATCH v4 4/5] ACPI: in HW reduced mode, using FADT PM information is not allowed.
Date: Mon, 16 Dec 2013 17:16:40 -0700
Message-ID: <1387239401-13918-5-git-send-email-al.stone@linaro.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:52112 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab3LQAQz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2013 19:16:55 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so7497978ieb.22
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2013 16:16:55 -0800 (PST)
In-Reply-To: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

Per the ACPI 5.0 specification, section 5.2.9, none of the power
management fields in the FADT are to be used.  Short-circuit using
any of those fields in acpi_processor_get_power_info_fadt().

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index b91dcaa..4917a9e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -270,6 +270,14 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 	if (!pr->pblk)
 		return -ENODEV;
 
+	/*
+	 * Using power management information from the FADT is not
+	 * allowed when in HW reduced mode.  See ACPI 5.0, section
+	 * 5.2.9.
+	 */
+	if (acpi_gbl_reduced_hardware)
+		return -ENODEV;
+
 	/* if info is obtained from pblk/fadt, type equals state */
 	pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
 	pr->power.states[ACPI_STATE_C3].type = ACPI_STATE_C3;
-- 
1.8.3.1

