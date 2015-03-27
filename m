From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 7/7] ACPI / processor: Introduce invalid_phys_cpuid()
Date: Fri, 27 Mar 2015 21:55:13 +0800
Message-ID: <1427464513-14414-10-git-send-email-hanjun.guo@linaro.org>
References: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36565 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824AbbC0N41 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2015 09:56:27 -0400
Received: by pdcp1 with SMTP id p1so5743449pdc.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2015 06:56:26 -0700 (PDT)
In-Reply-To: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

Introduce invalid_phys_cpuid() to identify cpu with invalid
physical ID, then used it as replacement of the direct comparisons
with PHYS_CPUID_INVALID.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_processor.c | 4 ++--
 drivers/acpi/processor_core.c | 4 ++--
 include/linux/acpi.h          | 5 +++++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 62c846b..92a5f73 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	acpi_status status;
 	int ret;
 
-	if (pr->phys_id == PHYS_CPUID_INVALID)
+	if (invalid_phys_cpuid(pr->phys_id))
 		return -ENODEV;
 
 	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
@@ -264,7 +264,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 
 	pr->phys_id = acpi_get_phys_id(pr->handle, device_declaration,
 					pr->acpi_id);
-	if (pr->phys_id == PHYS_CPUID_INVALID)
+	if (invalid_phys_cpuid(pr->phys_id))
 		acpi_handle_debug(pr->handle, "failed to get CPU physical ID.\n");
 
 	pr->id = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index fd4140d..33a38d6 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -184,7 +184,7 @@ phys_cpuid_t acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
 	phys_cpuid_t phys_id;
 
 	phys_id = map_mat_entry(handle, type, acpi_id);
-	if (phys_id == PHYS_CPUID_INVALID)
+	if (invalid_phys_cpuid(phys_id))
 		phys_id = map_madt_entry(type, acpi_id);
 
 	return phys_id;
@@ -196,7 +196,7 @@ int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id)
 	int i;
 #endif
 
-	if (phys_id == PHYS_CPUID_INVALID) {
+	if (invalid_phys_cpuid(phys_id)) {
 		/*
 		 * On UP processor, there is no _MAT or MADT table.
 		 * So above phys_id is always set to PHYS_CPUID_INVALID.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fd8a2a4..9a1f467 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -157,6 +157,11 @@ static inline bool invalid_logical_cpuid(u32 cpuid)
 	return (int)cpuid < 0;
 }
 
+static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
+{
+	return (int)phys_id < 0;
+}
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu);
-- 
1.9.1

