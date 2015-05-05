From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 2/7] ACPI / processor: remove phys_id in acpi_processor_get_info()
Date: Tue,  5 May 2015 10:46:33 +0800
Message-ID: <1430793998-21631-3-git-send-email-hanjun.guo@linaro.org>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36779 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965407AbbEECri (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 22:47:38 -0400
Received: by pabsx10 with SMTP id sx10so177869111pab.3
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2015 19:47:36 -0700 (PDT)
In-Reply-To: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

Use pr->phys_id to replace phys_id to simplify the code.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_processor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index d6ac918..95492d0 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -215,7 +215,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	union acpi_object object = { 0 };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
-	phys_cpuid_t phys_id;
 	int device_declaration = 0;
 	acpi_status status = AE_OK;
 	static int cpu0_initialized;
@@ -263,10 +262,10 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		pr->acpi_id = value;
 	}
 
-	phys_id = acpi_get_phys_id(pr->handle, device_declaration, pr->acpi_id);
-	if (phys_id == PHYS_CPUID_INVALID)
+	pr->phys_id = acpi_get_phys_id(pr->handle, device_declaration,
+					pr->acpi_id);
+	if (pr->phys_id == PHYS_CPUID_INVALID)
 		acpi_handle_debug(pr->handle, "failed to get CPU physical ID.\n");
-	pr->phys_id = phys_id;
 
 	pr->id = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
 	if (!cpu0_initialized && !acpi_has_cpu_in_madt()) {
-- 
1.9.1

