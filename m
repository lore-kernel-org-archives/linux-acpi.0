From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 1/2] ACPI / CPPC: read all perf caps in a single cppc read command
Date: Wed, 14 Dec 2016 18:06:33 -0700
Message-ID: <1481763994-28146-2-git-send-email-pprakash@codeaurora.org>
References: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbcLOBGn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Dec 2016 20:06:43 -0500
In-Reply-To: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org, Prashanth Prakash <pprakash@codeaurora.org>

CPPC performance capabilities do not change during runtime, so we can
read perf caps for all CPUs in a single CPPC read command and cache
them locally.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/cppc_acpi.c | 103 +++++++++++++++++++++++++++++++++--------------
 include/acpi/cppc_acpi.h |   1 +
 2 files changed, 73 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3ca0729..45f021a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -92,6 +92,12 @@ struct cppc_pcc_data {
  */
 static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 
+/*
+ * The cppc_perf_caps structure contains the performance capabilities
+ * as described in section 8.4.7.1 of ACPI 6.1 spec
+ */
+static DEFINE_PER_CPU(struct cppc_perf_caps, cpc_perf_caps);
+
 /* pcc mapped address + header size + offset within PCC subspace */
 #define GET_PCC_VADDR(offs) (pcc_data.pcc_comm_addr + 0x8 + (offs))
 
@@ -971,49 +977,84 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
  */
 int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 {
-	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
-	struct cpc_register_resource *highest_reg, *lowest_reg, *ref_perf,
-								 *nom_perf;
-	u64 high, low, nom;
-	int ret = 0, regs_in_pcc = 0;
+	static bool initialized;
+	int ret = 0, i;
+	bool regs_in_pcc = false;
+	struct cppc_perf_caps *caps;
 
-	if (!cpc_desc) {
-		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
-		return -ENODEV;
+	if (initialized) {
+		caps = &per_cpu(cpc_perf_caps, cpunum);
+
+		if (!caps->highest_perf || !caps->lowest_perf ||
+			!caps->nominal_perf || !caps->lowest_non_linear_perf)
+			return -EFAULT;
+
+		memcpy(perf_caps, caps, sizeof(struct cppc_perf_caps));
+		return 0;
 	}
 
-	highest_reg = &cpc_desc->cpc_regs[HIGHEST_PERF];
-	lowest_reg = &cpc_desc->cpc_regs[LOWEST_PERF];
-	ref_perf = &cpc_desc->cpc_regs[REFERENCE_PERF];
-	nom_perf = &cpc_desc->cpc_regs[NOMINAL_PERF];
+	/* Perf caps don't change over time, so read all of them at once */
+	for_each_possible_cpu(i) {
+		struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, i);
+		struct cpc_register_resource *highest_reg, *lowest_reg,
+			*nom_reg, *lowest_non_linear_reg;
+		u64 perf;
 
-	/* Are any of the regs PCC ?*/
-	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
-		CPC_IN_PCC(ref_perf) || CPC_IN_PCC(nom_perf)) {
-		regs_in_pcc = 1;
-		down_write(&pcc_data.pcc_lock);
-		/* Ring doorbell once to update PCC subspace */
-		if (send_pcc_cmd(CMD_READ) < 0) {
-			ret = -EIO;
-			goto out_err;
+		if (!cpc_desc) {
+			pr_debug("No CPC descriptor for CPU:%d\n", i);
+			continue;
+		}
+
+		highest_reg = &cpc_desc->cpc_regs[HIGHEST_PERF];
+		lowest_reg = &cpc_desc->cpc_regs[LOWEST_PERF];
+		lowest_non_linear_reg = &cpc_desc->cpc_regs[LOW_NON_LINEAR_PERF];
+		nom_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
+
+		/* Are any of the regs in PCC ?*/
+		if (!regs_in_pcc) {
+			regs_in_pcc = CPC_IN_PCC(highest_reg) ||
+				CPC_IN_PCC(lowest_reg) ||
+				CPC_IN_PCC(lowest_non_linear_reg) ||
+				CPC_IN_PCC(nom_reg);
+			if (regs_in_pcc) {
+				down_write(&pcc_data.pcc_lock);
+				/* Skip if another CPU has completed init */
+				if (initialized)
+					goto out;
+
+				/* Ring doorbell once to update PCC subspace */
+				if (send_pcc_cmd(CMD_READ) < 0) {
+					ret = -EIO;
+					goto out;
+				}
+			}
 		}
-	}
 
-	cpc_read(cpunum, highest_reg, &high);
-	perf_caps->highest_perf = high;
+		caps = &per_cpu(cpc_perf_caps, i);
 
-	cpc_read(cpunum, lowest_reg, &low);
-	perf_caps->lowest_perf = low;
+		cpc_read(i, highest_reg, &perf);
+		caps->highest_perf = perf;
 
-	cpc_read(cpunum, nom_perf, &nom);
-	perf_caps->nominal_perf = nom;
+		cpc_read(i, lowest_reg, &perf);
+		caps->lowest_perf = perf;
 
-	if (!high || !low || !nom)
-		ret = -EFAULT;
+		cpc_read(i, nom_reg, &perf);
+		caps->nominal_perf = perf;
 
-out_err:
+		cpc_read(i, lowest_non_linear_reg, &perf);
+		caps->lowest_non_linear_perf = perf;
+	}
+
+	initialized = true;
+
+out:
 	if (regs_in_pcc)
 		up_write(&pcc_data.pcc_lock);
+
+	/* Copy over the per cpu data to perf_caps if init ws successful */
+	if (!ret)
+		ret = cppc_get_perf_caps(cpunum, perf_caps);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 427a7c3..3f64660 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -103,6 +103,7 @@ struct cppc_perf_caps {
 	u32 highest_perf;
 	u32 nominal_perf;
 	u32 lowest_perf;
+	u32 lowest_non_linear_perf;
 };
 
 struct cppc_perf_ctrls {
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

