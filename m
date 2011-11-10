From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/6] acpi : remove 'latency_ticks' in acpi_processor_cx
Date: Fri, 11 Nov 2011 00:57:28 +0100
Message-ID: <1320969451-27218-4-git-send-email-daniel.lezcano@linaro.org>
References: <1320969451-27218-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:51683 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab1KKAFe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2011 19:05:34 -0500
In-Reply-To: <1320969451-27218-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, rob.lee@linaro.org

The latency_ticks field is used to store a value but it is never
used. It is safe to remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 24fe3af..dd87355 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -595,7 +595,6 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	 */
 	cx->valid = 1;
 
-	cx->latency_ticks = cx->latency;
 	/*
 	 * On older chipsets, BM_RLD needs to be set
 	 * in order for Bus Master activity to wake the
@@ -628,7 +627,6 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 			if (!cx->address)
 				break;
 			cx->valid = 1; 
-			cx->latency_ticks = cx->latency; /* Normalize latency */
 			break;
 
 		case ACPI_STATE_C3:
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 610f6fb..1b6e65c 100644
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
1.7.4.1

