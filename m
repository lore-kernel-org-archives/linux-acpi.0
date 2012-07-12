From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/5] acpi : remove latency_ticks from acpi_processor_cx structure
Date: Thu, 12 Jul 2012 23:03:42 +0200
Message-ID: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36883 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933478Ab2GLVDv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2012 17:03:51 -0400
Received: by weyx8 with SMTP id x8so2012381wey.19
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jul 2012 14:03:50 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Remove the latency_ticks field as it is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f3decb3..da92c65 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -586,7 +586,6 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	 */
 	cx->valid = 1;
 
-	cx->latency_ticks = cx->latency;
 	/*
 	 * On older chipsets, BM_RLD needs to be set
 	 * in order for Bus Master activity to wake the
@@ -619,7 +618,6 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 			if (!cx->address)
 				break;
 			cx->valid = 1; 
-			cx->latency_ticks = cx->latency; /* Normalize latency */
 			break;
 
 		case ACPI_STATE_C3:
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 9d65047..a70cbcc 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -59,7 +59,6 @@ struct acpi_processor_cx {
 	u8 entry_method;
 	u8 index;
 	u32 latency;
-	u32 latency_ticks;
 	u32 power;
 	u32 usage;
 	u64 time;
-- 
1.7.5.4

