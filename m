From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 4/7] Xen / ACPI / processor: use invalid_logical_cpuid()
Date: Tue,  5 May 2015 10:46:35 +0800
Message-ID: <1430793998-21631-5-git-send-email-hanjun.guo@linaro.org>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35910 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965423AbbEECrr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 22:47:47 -0400
Received: by pabsx10 with SMTP id sx10so177872220pab.3
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2015 19:47:46 -0700 (PDT)
In-Reply-To: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

Use invalid_logical_cpuid(pr->id) instead of direct comparison
of -1.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/xen-acpi-cpuhotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xen-acpi-cpuhotplug.c b/drivers/xen/xen-acpi-cpuhotplug.c
index 3e62ee4..5a62aa0 100644
--- a/drivers/xen/xen-acpi-cpuhotplug.c
+++ b/drivers/xen/xen-acpi-cpuhotplug.c
@@ -77,7 +77,7 @@ static int xen_acpi_processor_enable(struct acpi_device *device)
 
 	pr->id = xen_pcpu_id(pr->acpi_id);
 
-	if ((int)pr->id < 0)
+	if (invalid_logical_cpuid(pr->id))
 		/* This cpu is not presented at hypervisor, try to hotadd it */
 		if (ACPI_FAILURE(xen_acpi_cpu_hotadd(pr))) {
 			pr_err(PREFIX "Hotadd CPU (acpi_id = %d) failed.\n",
@@ -226,7 +226,7 @@ static acpi_status xen_acpi_cpu_hotadd(struct acpi_processor *pr)
 		return AE_ERROR;
 
 	pr->id = xen_hotadd_cpu(pr);
-	if ((int)pr->id < 0)
+	if (invalid_logical_cpuid(pr->id))
 		return AE_ERROR;
 
 	/*
-- 
1.9.1

