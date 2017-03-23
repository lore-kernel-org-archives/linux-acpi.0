From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH] ACPI / Processor: Remove setup_max_cpus check in acpi_processor_add
Date: Thu, 23 Mar 2017 15:21:53 -0600
Message-ID: <1490304113-18264-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdCWVWI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Mar 2017 17:22:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, Prashanth Prakash <pprakash@codeaurora.org>

When maxcpus=X kernel argument is used, we parse the ACPI tables only
for the first X cpus. The per-cpu ACPI data include the _PSD tables
which gives information about related cpus.

cppc_cpufreq and acpi-cpufreq parses the table once during init to
deduce the related cpus. If a user brings a new cpu online after boot
the related cpu data becomes incorrect.

acpi_get_psd_map() in acpi_cppc.c returns error if it fails to find
the parsed ACPI data for possible CPU resulting in cppc_cpufreq
initialization failure.

With this change we will probe all possible CPUs prior to cpufreq
initialization, but will bring only setup_max_cpus online. nr_cpus
kernel parameter can be used to restict even parsing per-cpu ACPI
tables.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/acpi_processor.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 0143135..f098e25 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -388,11 +388,6 @@ static int acpi_processor_add(struct acpi_device *device,
 	if (result) /* Processor is not physically present or unavailable */
 		return 0;
 
-#ifdef CONFIG_SMP
-	if (pr->id >= setup_max_cpus && pr->id != 0)
-		return 0;
-#endif
-
 	BUG_ON(pr->id >= nr_cpu_ids);
 
 	/*
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

