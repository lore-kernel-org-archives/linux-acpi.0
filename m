From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V4 1/5] ACPI / CPPC: Optimize PCC Read Write operations
Date: Wed, 17 Feb 2016 13:20:59 -0700
Message-ID: <1455740463-19192-2-git-send-email-pprakash@codeaurora.org>
References: <1455740463-19192-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53103 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964970AbcBQUV1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2016 15:21:27 -0500
In-Reply-To: <1455740463-19192-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: ashwin.chaugule@linaro.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, alexey.klimov@arm.com, Prashanth Prakash <pprakash@codeaurora.org>

From: Ashwin Chaugule <ashwin.chaugule@linaro.org>

Previously the send_pcc_cmd() code checked if the
PCC operation had completed before returning from
the function. This check was performed regardless
of the PCC op type (i.e. Read/Write). Knowing
the type of cmd can be used to optimize the check
and avoid needless waiting. e.g. with Write ops,
the actual Writing is done before calling send_pcc_cmd().
And the subsequent Writes will check if the channel is
free at the entry of send_pcc_cmd() anyway.

However, for Read cmds, we need to wait for the cmd
completion bit to be flipped, since the actual Read
ops follow after returning from the send_pcc_cmd(). So,
only do the looping check at the end for Read ops.

Also, instead of using udelay() calls, use ktime as a
means to check for deadlines. The current deadline
in which the Remote should flip the cmd completion bit
is defined as N * Nominal latency. Where N is arbitrary
and large enough to work on slow emulators and Nominal
latency comes from the ACPI table (PCCT). This helps
in working around the CONFIG_HZ effects on udelay()
and also avoids needing different ACPI tables for Silicon
and Emulation platforms.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/cppc_acpi.c | 101 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6730f96..026cdd4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -39,6 +39,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
+#include <linux/ktime.h>
 
 #include <acpi/cppc_acpi.h>
 /*
@@ -63,25 +64,53 @@ static struct mbox_chan *pcc_channel;
 static void __iomem *pcc_comm_addr;
 static u64 comm_base_addr;
 static int pcc_subspace_idx = -1;
-static u16 pcc_cmd_delay;
 static bool pcc_channel_acquired;
+static ktime_t deadline;
 
 /*
  * Arbitrary Retries in case the remote processor is slow to respond
- * to PCC commands.
+ * to PCC commands. Keeping it high enough to cover emulators where
+ * the processors run painfully slow.
  */
 #define NUM_RETRIES 500
 
+static int check_pcc_chan(void)
+{
+	int ret = -EIO;
+	struct acpi_pcct_shared_memory __iomem *generic_comm_base = pcc_comm_addr;
+	ktime_t next_deadline = ktime_add(ktime_get(), deadline);
+
+	/* Retry in case the remote processor was too slow to catch up. */
+	while (!ktime_after(ktime_get(), next_deadline)) {
+		if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
+			ret = 0;
+			break;
+		}
+		/*
+		 * Reducing the bus traffic in case this loop takes longer than
+		 * a few retries.
+		 */
+		udelay(3);
+	}
+
+	return ret;
+}
+
 static int send_pcc_cmd(u16 cmd)
 {
-	int retries, result = -EIO;
-	struct acpi_pcct_hw_reduced *pcct_ss = pcc_channel->con_priv;
+	int ret = -EIO;
 	struct acpi_pcct_shared_memory *generic_comm_base =
 		(struct acpi_pcct_shared_memory *) pcc_comm_addr;
-	u32 cmd_latency = pcct_ss->latency;
 
-	/* Min time OS should wait before sending next command. */
-	udelay(pcc_cmd_delay);
+	/*
+	 * For CMD_WRITE we know for a fact the caller should have checked
+	 * the channel before writing to PCC space
+	 */
+	if (cmd == CMD_READ) {
+		ret = check_pcc_chan();
+		if (ret)
+			return ret;
+	}
 
 	/* Write to the shared comm region. */
 	writew(cmd, &generic_comm_base->command);
@@ -90,31 +119,30 @@ static int send_pcc_cmd(u16 cmd)
 	writew(0, &generic_comm_base->status);
 
 	/* Ring doorbell */
-	result = mbox_send_message(pcc_channel, &cmd);
-	if (result < 0) {
+	ret = mbox_send_message(pcc_channel, &cmd);
+	if (ret < 0) {
 		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
-				cmd, result);
-		return result;
+				cmd, ret);
+		return ret;
 	}
 
-	/* Wait for a nominal time to let platform process command. */
-	udelay(cmd_latency);
-
-	/* Retry in case the remote processor was too slow to catch up. */
-	for (retries = NUM_RETRIES; retries > 0; retries--) {
-		if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
-			result = 0;
-			break;
-		}
-	}
+	/*
+	 * For READs we need to ensure the cmd completed to ensure
+	 * the ensuing read()s can proceed. For WRITEs we dont care
+	 * because the actual write()s are done before coming here
+	 * and the next READ or WRITE will check if the channel
+	 * is busy/free at the entry of this call.
+	 */
+	if (cmd == CMD_READ)
+		ret = check_pcc_chan();
 
-	mbox_client_txdone(pcc_channel, result);
-	return result;
+	mbox_client_txdone(pcc_channel, ret);
+	return ret;
 }
 
 static void cppc_chan_tx_done(struct mbox_client *cl, void *msg, int ret)
 {
-	if (ret)
+	if (ret < 0)
 		pr_debug("TX did not complete: CMD sent:%x, ret:%d\n",
 				*(u16 *)msg, ret);
 	else
@@ -306,6 +334,7 @@ static int register_pcc_channel(int pcc_subspace_idx)
 {
 	struct acpi_pcct_hw_reduced *cppc_ss;
 	unsigned int len;
+	u64 usecs_lat;
 
 	if (pcc_subspace_idx >= 0) {
 		pcc_channel = pcc_mbox_request_channel(&cppc_mbox_cl,
@@ -335,7 +364,14 @@ static int register_pcc_channel(int pcc_subspace_idx)
 		 */
 		comm_base_addr = cppc_ss->base_address;
 		len = cppc_ss->length;
-		pcc_cmd_delay = cppc_ss->min_turnaround_time;
+
+		/*
+		 * cppc_ss->latency is just a Nominal value. In reality
+		 * the remote processor could be much slower to reply.
+		 * So add an arbitrary amount of wait on top of Nominal.
+		 */
+		usecs_lat = NUM_RETRIES * cppc_ss->latency;
+		deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
 
 		pcc_comm_addr = acpi_os_ioremap(comm_base_addr, len);
 		if (!pcc_comm_addr) {
@@ -604,7 +640,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 			(ref_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
 			(nom_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)) {
 		/* Ring doorbell once to update PCC subspace */
-		if (send_pcc_cmd(CMD_READ)) {
+		if (send_pcc_cmd(CMD_READ) < 0) {
 			ret = -EIO;
 			goto out_err;
 		}
@@ -662,7 +698,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	if ((delivered_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
 			(reference_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)) {
 		/* Ring doorbell once to update PCC subspace */
-		if (send_pcc_cmd(CMD_READ)) {
+		if (send_pcc_cmd(CMD_READ) < 0) {
 			ret = -EIO;
 			goto out_err;
 		}
@@ -713,6 +749,13 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 
 	spin_lock(&pcc_lock);
 
+	/* If this is PCC reg, check if channel is free before writing */
+	if (desired_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		ret = check_pcc_chan();
+		if (ret)
+			goto busy_channel;
+	}
+
 	/*
 	 * Skip writing MIN/MAX until Linux knows how to come up with
 	 * useful values.
@@ -722,10 +765,10 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	/* Is this a PCC reg ?*/
 	if (desired_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
 		/* Ring doorbell so Remote can get our perf request. */
-		if (send_pcc_cmd(CMD_WRITE))
+		if (send_pcc_cmd(CMD_WRITE) < 0)
 			ret = -EIO;
 	}
-
+busy_channel:
 	spin_unlock(&pcc_lock);
 
 	return ret;
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

