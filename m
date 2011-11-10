From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/6] acpi : remove 'time' field in acpi_processor_cx
Date: Fri, 11 Nov 2011 00:57:29 +0100
Message-ID: <1320969451-27218-5-git-send-email-daniel.lezcano@linaro.org>
References: <1320969451-27218-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:40117 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab1KKAFR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2011 19:05:17 -0500
In-Reply-To: <1320969451-27218-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, rob.lee@linaro.org

The 'time' field is used to sum the idle time but it is never
used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index dd87355..142af72 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -861,7 +861,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	cx->usage++;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
 	return index;
 }
 
@@ -987,7 +986,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	cx->usage++;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
 	return index;
 }
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 1b6e65c..46bcf79 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -61,7 +61,6 @@ struct acpi_processor_cx {
 	u32 latency;
 	u32 power;
 	u32 usage;
-	u64 time;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
 };
-- 
1.7.4.1

