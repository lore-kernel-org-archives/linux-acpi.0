From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/6] acpi : move the acpi_idle_driver variable declaration
Date: Fri,  7 Sep 2012 12:19:27 +0200
Message-ID: <1347013172-12465-2-git-send-email-daniel.lezcano@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46113 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760222Ab2IGKTk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 06:19:40 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1284302bkw.19
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 03:19:39 -0700 (PDT)
In-Reply-To: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

This variable is only used in the in processor_driver.c.
This patch reduces the scope of the variable by moving it
to this file.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/acpi/processor_driver.c |    2 +-
 include/acpi/processor.h        |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bfc31cb..e1f6330 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -113,7 +113,7 @@ static struct acpi_driver acpi_processor_driver = {
 
 DEFINE_PER_CPU(struct acpi_processor *, processors);
 EXPORT_PER_CPU_SYMBOL(processors);
-
+extern struct cpuidle_driver acpi_idle_driver;
 struct acpi_processor_errata errata __read_mostly;
 
 /* --------------------------------------------------------------------------
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index db427fa..8b2c39a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -332,7 +332,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr,
 			      struct acpi_device *device);
 int acpi_processor_suspend(struct device *dev);
 int acpi_processor_resume(struct device *dev);
-extern struct cpuidle_driver acpi_idle_driver;
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
-- 
1.7.5.4

