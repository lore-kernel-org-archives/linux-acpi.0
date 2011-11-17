From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6/6][resend] acpi : remove 'power' field from acpi_processor_cx
Date: Thu, 17 Nov 2011 11:26:40 +0100
Message-ID: <1321525600-2466-7-git-send-email-daniel.lezcano@linaro.org>
References: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:34691 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab1KQK07 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Nov 2011 05:26:59 -0500
In-Reply-To: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rob.lee@linaro.org, deepthi@linux.vnet.ibm.com

The power field is filled but never used in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4b9ebd5..e2b67e2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -495,8 +495,6 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
 
-		cx.power = obj->integer.value;
-
 		current_count++;
 		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index bc3449a..bed1093 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -59,7 +59,6 @@ struct acpi_processor_cx {
 	u8 entry_method;
 	u8 index;
 	u32 latency;
-	u32 power;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
 };
-- 
1.7.4.1

