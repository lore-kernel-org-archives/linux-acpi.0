From: Hoan Tran <hotran@apm.com>
Subject: [PATCH] ACPI: CPPC: Return error if _CPC is invalid on a CPU
Date: Fri, 17 Jun 2016 15:16:31 -0700
Message-ID: <1466201791-13351-1-git-send-email-hotran@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33509 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbcFQWQt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jun 2016 18:16:49 -0400
Received: by mail-pf0-f169.google.com with SMTP id i123so30757434pfg.0
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jun 2016 15:16:49 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, pprakash@codeaurora.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, Hoan Tran <hotran@apm.com>

Based on 8.4.7.1 section of ACPI 6.1 specification, if the platform
supports CPPC, the _CPC object must exist under all processor objects.
If cpc_desc_ptr pointer is invalid on any CPUs, acpi_get_psd_map()
should return error and CPPC cpufreq driver can not be registered.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/acpi/cppc_acpi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 85fd8f7..2e98173 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -299,8 +299,10 @@ int acpi_get_psd_map(struct cpudata **all_cpu_data)
 			continue;
 
 		cpc_ptr = per_cpu(cpc_desc_ptr, i);
-		if (!cpc_ptr)
-			continue;
+		if (!cpc_ptr) {
+			retval = -EFAULT;
+			goto err_ret;
+		}
 
 		pdomain = &(cpc_ptr->domain_info);
 		cpumask_set_cpu(i, pr->shared_cpu_map);
@@ -322,8 +324,10 @@ int acpi_get_psd_map(struct cpudata **all_cpu_data)
 				continue;
 
 			match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
-			if (!match_cpc_ptr)
-				continue;
+			if (!match_cpc_ptr) {
+				retval = -EFAULT;
+				goto err_ret;
+			}
 
 			match_pdomain = &(match_cpc_ptr->domain_info);
 			if (match_pdomain->domain != pdomain->domain)
@@ -353,8 +357,10 @@ int acpi_get_psd_map(struct cpudata **all_cpu_data)
 				continue;
 
 			match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
-			if (!match_cpc_ptr)
-				continue;
+			if (!match_cpc_ptr) {
+				retval = -EFAULT;
+				goto err_ret;
+			}
 
 			match_pdomain = &(match_cpc_ptr->domain_info);
 			if (match_pdomain->domain != pdomain->domain)
-- 
1.9.1

