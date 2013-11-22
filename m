From: al.stone@linaro.org
Subject: [PATCH v2 6/6] ACPI: in HW reduced mode, using FADT PM information is not allowed.
Date: Thu, 21 Nov 2013 17:41:55 -0700
Message-ID: <1385080915-23430-7-git-send-email-al.stone@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46854 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab3KVAmP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 19:42:15 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so537031pad.31
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2013 16:42:15 -0800 (PST)
In-Reply-To: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>, Al Stone <al.stone@linaro.og>

From: Al Stone <al.stone@linaro.org>

Per the ACPI 5.0 specification, section 5.2.9, none of the power
management fields in the FADT are to be used.  Short-circuit using
any of those fields in acpi_processor_get_power_info_fadt().

Signed-off-by: Al Stone <al.stone@linaro.og>
---
 drivers/acpi/processor_idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index b18e7ab..52859da 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -272,6 +272,14 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
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

