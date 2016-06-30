From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 2/5] ACPI/CPPC: acquire pcc_lock only while accessing PCC subspace
Date: Thu, 30 Jun 2016 12:02:35 -0600
Message-ID: <1467309758-26536-3-git-send-email-pprakash@codeaurora.org>
References: <1467309758-26536-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52788 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbcF3SC4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2016 14:02:56 -0400
In-Reply-To: <1467309758-26536-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org, pprakash@codeaurora.org

We need to acquire pcc_lock only when we are accessing registers
that are in the PCC subspsace.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/cppc_acpi.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 28170c2..a4b2b50 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -761,7 +761,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	struct cpc_register_resource *highest_reg, *lowest_reg, *ref_perf,
 								 *nom_perf;
 	u64 high, low, ref, nom;
-	int ret = 0;
+	int ret = 0, regs_in_pcc = 0;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -773,13 +773,13 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	ref_perf = &cpc_desc->cpc_regs[REFERENCE_PERF];
 	nom_perf = &cpc_desc->cpc_regs[NOMINAL_PERF];
 
-	spin_lock(&pcc_lock);
-
 	/* Are any of the regs PCC ?*/
 	if ((highest_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
-			(lowest_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
-			(ref_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
-			(nom_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)) {
+		(lowest_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
+		(ref_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
+		(nom_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)) {
+		spin_lock(&pcc_lock);
+		regs_in_pcc = 1;
 		/* Ring doorbell once to update PCC subspace */
 		if (send_pcc_cmd(CMD_READ) < 0) {
 			ret = -EIO;
@@ -806,7 +806,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		ret = -EFAULT;
 
 out_err:
-	spin_unlock(&pcc_lock);
+	if (regs_in_pcc)
+		spin_unlock(&pcc_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
@@ -823,7 +824,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *delivered_reg, *reference_reg;
 	u64 delivered, reference;
-	int ret = 0;
+	int ret = 0, regs_in_pcc = 0;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -833,11 +834,11 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
 	reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
 
-	spin_lock(&pcc_lock);
-
 	/* Are any of the regs PCC ?*/
 	if ((delivered_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
 		(reference_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)) {
+		spin_lock(&pcc_lock);
+		regs_in_pcc = 1;
 		/* Ring doorbell once to update PCC subspace */
 		if (send_pcc_cmd(CMD_READ) < 0) {
 			ret = -EIO;
@@ -863,7 +864,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	perf_fb_ctrs->prev_reference = reference;
 
 out_err:
-	spin_unlock(&pcc_lock);
+	if (regs_in_pcc)
+		spin_unlock(&pcc_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
@@ -888,10 +890,9 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
 
-	spin_lock(&pcc_lock);
-
 	/* If this is PCC reg, check if channel is free before writing */
 	if (desired_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		spin_lock(&pcc_lock);
 		ret = check_pcc_chan();
 		if (ret)
 			goto busy_channel;
@@ -910,7 +911,8 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 			ret = -EIO;
 	}
 busy_channel:
-	spin_unlock(&pcc_lock);
+	if (desired_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
+		spin_unlock(&pcc_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_set_perf);
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

