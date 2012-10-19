From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/5] cpuidle / ACPI : remove pointless headers
Date: Fri, 19 Oct 2012 11:51:29 +0200
Message-ID: <1350640292-22468-2-git-send-email-daniel.lezcano@linaro.org>
References: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:43683 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab2JSJvh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Oct 2012 05:51:37 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so33109wgb.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Oct 2012 02:51:36 -0700 (PDT)
In-Reply-To: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org

These different headers are not needed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 1f536a3..9aac69b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -28,19 +28,10 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/cpufreq.h>
-#include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/dmi.h>
-#include <linux/moduleparam.h>
-#include <linux/sched.h>	/* need_resched() */
-#include <linux/pm_qos.h>
 #include <linux/clockchips.h>
 #include <linux/cpuidle.h>
-#include <linux/irqflags.h>
 
 /*
  * Include the apic definitions for x86 to have the APIC timer related defines
@@ -52,12 +43,8 @@
 #include <asm/apic.h>
 #endif
 
-#include <asm/io.h>
-#include <asm/uaccess.h>
-
 #include <acpi/acpi_bus.h>
 #include <acpi/processor.h>
-#include <asm/processor.h>
 
 #define PREFIX "ACPI: "
 ACPI_MODULE_NAME("processor_idle");
-- 
1.7.5.4

