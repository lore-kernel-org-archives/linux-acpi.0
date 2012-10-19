From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/5] cpuidle / ACPI : remove unused definition
Date: Fri, 19 Oct 2012 11:51:28 +0200
Message-ID: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57496 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab2JSJvg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Oct 2012 05:51:36 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so50261wib.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Oct 2012 02:51:34 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org

The different definitions are not used anywhere in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e8086c7..1f536a3 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -60,14 +60,7 @@
 #include <asm/processor.h>
 
 #define PREFIX "ACPI: "
-
-#define ACPI_PROCESSOR_CLASS            "processor"
-#define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
-#define PM_TIMER_TICK_NS		(1000000000ULL/PM_TIMER_FREQUENCY)
-#define C2_OVERHEAD			1	/* 1us */
-#define C3_OVERHEAD			1	/* 1us */
-#define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
 module_param(max_cstate, uint, 0000);
-- 
1.7.5.4

