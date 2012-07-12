From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/5] acpi : remove time from acpi_processor_cx structure
Date: Thu, 12 Jul 2012 23:03:46 +0200
Message-ID: <1342127026-1526-5-git-send-email-daniel.lezcano@linaro.org>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40466 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab2GLVD5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2012 17:03:57 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so2012396wey.19
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2012 14:03:57 -0700 (PDT)
In-Reply-To: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Remove the time field as it is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 99ba58f..bc1ce58 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -861,7 +861,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 		current_thread_info()->status |= TS_POLLING;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
 	return index;
 }
 
@@ -979,7 +978,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		current_thread_info()->status |= TS_POLLING;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
 	return index;
 }
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 87bb9d7..3998334 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -58,7 +58,6 @@ struct acpi_processor_cx {
 	u32 address;
 	u8 entry_method;
 	u32 latency;
-	u64 time;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
 };
-- 
1.7.5.4

