From: al.stone@linaro.org
Subject: [PATCH 09/12] ACPI: add clarifying comment about processor throttling in HW reduced mode
Date: Sat,  9 Nov 2013 18:36:19 -0700
Message-ID: <1384047382-20623-10-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36513 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab3KJBgl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:41 -0500
Received: by mail-ie0-f180.google.com with SMTP id e14so5596565iej.39
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:41 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_throttling.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index e7dd2c1..200738e 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -942,6 +942,10 @@ static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
 		return -EINVAL;
 	}
 
+	/*
+	 * NB: in HW reduced mode, duty_width is always zero
+	 * so this count may not be what is wanted.
+	 */
 	pr->throttling.state_count = 1 << acpi_gbl_FADT.duty_width;
 
 	/*
@@ -991,6 +995,10 @@ static int acpi_processor_set_throttling_fadt(struct acpi_processor *pr,
 		/* Used to clear all duty_value bits */
 		duty_mask = pr->throttling.state_count - 1;
 
+		/*
+		 * NB: in HW reduced mode, duty_offset is always zero
+		 * so this mask may not be what is wanted.
+		 */
 		duty_mask <<= acpi_gbl_FADT.duty_offset;
 		duty_mask = ~duty_mask;
 	}
-- 
1.8.3.1

