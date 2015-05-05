From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 3/7] ACPI / processor: Introduce invalid_logical_cpuid()
Date: Tue,  5 May 2015 10:46:34 +0800
Message-ID: <1430793998-21631-4-git-send-email-hanjun.guo@linaro.org>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34644 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965407AbbEECrn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 22:47:43 -0400
Received: by pacyx8 with SMTP id yx8so177883033pac.1
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2015 19:47:42 -0700 (PDT)
In-Reply-To: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

In ACPI processor drivers, we use direct comparisons of cpu logical
id with -1 which are error prone in case logical cpuid is accidentally
assinged an error code and prevents us from returning an error-encoding
cpuid directly in some cases.

So introduce invalid_logical_cpuid() to identify cpu with invalid
logical cpu num, then it will be used to replace the direct comparisons
with -1.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_processor.c | 4 ++--
 drivers/acpi/processor_pdc.c  | 5 +----
 include/linux/acpi.h          | 5 +++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 95492d0..62c846b 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -274,7 +274,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		 * Handle UP system running SMP kernel, with no CPU
 		 * entry in MADT
 		 */
-		if ((pr->id == -1) && (num_online_cpus() == 1))
+		if (invalid_logical_cpuid(pr->id) && (num_online_cpus() == 1))
 			pr->id = 0;
 	}
 
@@ -283,7 +283,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  less than the max # of CPUs. They should be ignored _iff
 	 *  they are physically not present.
 	 */
-	if (pr->id == -1) {
+	if (invalid_logical_cpuid(pr->id)) {
 		int ret = acpi_processor_hotadd_init(pr);
 		if (ret)
 			return ret;
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index e5dd808..6dd98d0 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -52,10 +52,7 @@ static bool __init processor_physically_present(acpi_handle handle)
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
-	if (cpuid == -1)
-		return false;
-
-	return true;
+	return invalid_logical_cpuid(cpuid) ? false : true;
 }
 
 static void acpi_set_pdc_bits(u32 *buf)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e4da5e3..913b49f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -158,6 +158,11 @@ typedef u32 phys_cpuid_t;
 #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
 #endif
 
+static inline bool invalid_logical_cpuid(u32 cpuid)
+{
+	return (int)cpuid < 0;
+}
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu);
-- 
1.9.1

