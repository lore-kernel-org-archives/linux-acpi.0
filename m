From: al.stone@linaro.org
Subject: [PATCH v3 4/5] ACPI: in HW reduced mode, using FADT PM information is not allowed.
Date: Wed,  4 Dec 2013 14:22:06 -0700
Message-ID: <1386192127-28564-5-git-send-email-al.stone@linaro.org>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33016 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456Ab3LDVWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 16:22:22 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so26718110iej.26
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 13:22:22 -0800 (PST)
In-Reply-To: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
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
index 8b48c08..a419fcb 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -271,6 +271,14 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
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

