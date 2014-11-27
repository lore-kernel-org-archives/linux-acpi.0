From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 1/3] ACPI / processor: Update the comments in processor.h
Date: Thu, 27 Nov 2014 13:07:31 +0800
Message-ID: <1417064853-27905-2-git-send-email-hanjun.guo@linaro.com>
References: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:62856 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaK0FIH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2014 00:08:07 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so4257716pab.35
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2014 21:08:06 -0800 (PST)
In-Reply-To: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

In commit 46ba51e (ACPI / processor: Introduce ARCH_MIGHT_HAVE_ACPI_PDC),
acpi_processor_set_pdc() was moved to processor_pdc.c, so update
the comments accordingly.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/processor.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 9b9b6f2..cbb6cd3 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -313,11 +313,13 @@ static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 #endif				/* CONFIG_CPU_FREQ */
 
 /* in processor_core.c */
-void acpi_processor_set_pdc(acpi_handle handle);
 int acpi_get_apicid(acpi_handle, int type, u32 acpi_id);
 int acpi_map_cpuid(int apic_id, u32 acpi_id);
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 
+/* in processor_pdc.c */
+void acpi_processor_set_pdc(acpi_handle handle);
+
 /* in processor_throttling.c */
 int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
-- 
1.9.1

