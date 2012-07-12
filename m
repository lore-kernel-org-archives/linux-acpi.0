From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/5] acpi : remove power from acpi_processor_cx structure
Date: Thu, 12 Jul 2012 23:03:45 +0200
Message-ID: <1342127026-1526-4-git-send-email-daniel.lezcano@linaro.org>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36120 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933975Ab2GLVD4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2012 17:03:56 -0400
Received: by weyx8 with SMTP id x8so2012429wey.19
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2012 14:03:55 -0700 (PDT)
In-Reply-To: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Remove the power field as it is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d044588..99ba58f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -485,8 +485,6 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
 
-		cx.power = obj->integer.value;
-
 		current_count++;
 		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 0957457..87bb9d7 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -58,7 +58,6 @@ struct acpi_processor_cx {
 	u32 address;
 	u8 entry_method;
 	u32 latency;
-	u32 power;
 	u64 time;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
-- 
1.7.5.4

