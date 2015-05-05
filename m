From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 1/7] ACPI / processor: remove cpu_index in acpi_processor_get_info()
Date: Tue,  5 May 2015 10:46:32 +0800
Message-ID: <1430793998-21631-2-git-send-email-hanjun.guo@linaro.org>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36702 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965395AbbEECrc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 22:47:32 -0400
Received: by pabsx10 with SMTP id sx10so177867556pab.3
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2015 19:47:32 -0700 (PDT)
In-Reply-To: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

Just use pr->id instead of cpu_index to simplify the code.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_processor.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 58f335c..d6ac918 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -216,7 +216,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
 	phys_cpuid_t phys_id;
-	int cpu_index, device_declaration = 0;
+	int device_declaration = 0;
 	acpi_status status = AE_OK;
 	static int cpu0_initialized;
 	unsigned long long value;
@@ -268,17 +268,16 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		acpi_handle_debug(pr->handle, "failed to get CPU physical ID.\n");
 	pr->phys_id = phys_id;
 
-	cpu_index = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
+	pr->id = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
 	if (!cpu0_initialized && !acpi_has_cpu_in_madt()) {
 		cpu0_initialized = 1;
 		/*
 		 * Handle UP system running SMP kernel, with no CPU
 		 * entry in MADT
 		 */
-		if ((cpu_index == -1) && (num_online_cpus() == 1))
-			cpu_index = 0;
+		if ((pr->id == -1) && (num_online_cpus() == 1))
+			pr->id = 0;
 	}
-	pr->id = cpu_index;
 
 	/*
 	 *  Extra Processor objects may be enumerated on MP systems with
-- 
1.9.1

