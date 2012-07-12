From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/5] acpi : remove usage from acpi_processor_cx structure
Date: Thu, 12 Jul 2012 23:03:44 +0200
Message-ID: <1342127026-1526-3-git-send-email-daniel.lezcano@linaro.org>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36883 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948Ab2GLVDy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2012 17:03:54 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so2012381wey.19
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2012 14:03:53 -0700 (PDT)
In-Reply-To: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Remove the usage field as it is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    5 -----
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9808e60..d044588 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -761,7 +761,6 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 	dev->last_residency = (int)idle_time;
 
 	local_irq_enable();
-	cx->usage++;
 	lapic_timer_state_broadcast(pr, cx, 0);
 
 	return index;
@@ -863,8 +862,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	if (cx->entry_method != ACPI_CSTATE_FFH)
 		current_thread_info()->status |= TS_POLLING;
 
-	cx->usage++;
-
 	lapic_timer_state_broadcast(pr, cx, 0);
 	cx->time += idle_time;
 	return index;
@@ -983,8 +980,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	if (cx->entry_method != ACPI_CSTATE_FFH)
 		current_thread_info()->status |= TS_POLLING;
 
-	cx->usage++;
-
 	lapic_timer_state_broadcast(pr, cx, 0);
 	cx->time += idle_time;
 	return index;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index d09c94f..0957457 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -59,7 +59,6 @@ struct acpi_processor_cx {
 	u8 entry_method;
 	u32 latency;
 	u32 power;
-	u32 usage;
 	u64 time;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
-- 
1.7.5.4

