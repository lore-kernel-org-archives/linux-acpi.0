From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V2 3/5] ACPI/CPPC: support for batching CPPC requests
Date: Tue, 26 Jul 2016 13:45:26 -0600
Message-ID: <1469562328-10201-4-git-send-email-pprakash@codeaurora.org>
References: <1469562328-10201-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46258 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854AbcGZTqD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jul 2016 15:46:03 -0400
In-Reply-To: <1469562328-10201-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org, pprakash@codeaurora.org

CPPC defined in section 8.4.7 of ACPI 6.0 specification suggests
"To amortize the cost of PCC transactions, OSPM should read or write
all PCC registers via a single read or write command when possible"
This patch enables opportunistic batching of frequency transition
requests whenever the request happen to overlap in time.

Currently the access to pcc is serialized by a spin lock which does
not scale well as we increase the number of cores in the system. This
patch improves the scalability by allowing the differnt CPU cores to
update PCC subspace in parallel and by batching requests which will
reduce the certain types of operation(checking command completion bit,
ringing doorbell) by a significant margin.

Profiling shows significant improvement in the overall effeciency
to service freq. transition requests. With this patch we observe close
to 30% of the frequency transition requests being batched with other
requests while running apache bench on a ARM platform with 6
independent domains(or sets of related cpus).

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/cppc_acpi.c | 176 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 147 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 93826c7..4a887d4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -40,15 +40,35 @@
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/rwsem.h>
+#include <linux/wait.h>
 
 #include <acpi/cppc_acpi.h>
+
 /*
- * Lock to provide mutually exclusive access to the PCC
- * channel. e.g. When the remote updates the shared region
- * with new data, the reader needs to be protected from
- * other CPUs activity on the same channel.
+ * Lock to provide controlled access to the PCC channel.
+ *
+ * For performance critical usecases(currently cppc_set_perf)
+ *	We need to take read_lock and check if channel belongs to OSPM before
+ * reading or writing to PCC subspace
+ *	We need to take write_lock before transferring the channel ownership to
+ * the platform via a Doorbell
+ *	This allows us to batch a number of CPPC requests if they happen to
+ * originate in about the same time
+ *
+ * For non-performance critical usecases(init)
+ *	Take write_lock for all purposes which gives exclusive access
  */
-static DEFINE_SPINLOCK(pcc_lock);
+static DECLARE_RWSEM(pcc_lock);
+
+/* Indicates if there are any pending/batched PCC write commands */
+static bool pending_pcc_write_cmd;
+
+/* Wait queue for CPUs whose requests were batched */
+static DECLARE_WAIT_QUEUE_HEAD(pcc_write_wait_q);
+
+/* Used to identify if a batched request is delivered to platform */
+static unsigned int pcc_write_cnt;
 
 /*
  * The cpc_desc structure contains the ACPI register details
@@ -70,6 +90,11 @@ static unsigned int pcc_mpar, pcc_mrtt;
 /* pcc mapped address + header size + offset within PCC subspace */
 #define GET_PCC_VADDR(offs) (pcc_comm_addr + 0x8 + (offs))
 
+/* Check if a CPC regsiter is in PCC */
+#define CPC_IN_PCC(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&		\
+				(cpc)->cpc_entry.reg.space_id ==	\
+				ACPI_ADR_SPACE_PLATFORM_COMM)
+
 /*
  * Arbitrary Retries in case the remote processor is slow to respond
  * to PCC commands. Keeping it high enough to cover emulators where
@@ -104,6 +129,10 @@ static int check_pcc_chan(void)
 	return ret;
 }
 
+/*
+ * This function transfers the ownership of the PCC to the platform
+ * So it must be called while holding write_lock(pcc_lock)
+ */
 static int send_pcc_cmd(u16 cmd)
 {
 	int ret = -EIO;
@@ -118,6 +147,16 @@ static int send_pcc_cmd(u16 cmd)
 	 * the channel before writing to PCC space
 	 */
 	if (cmd == CMD_READ) {
+		/*
+		 * If there are pending cpc_writes, then we stole the channel
+		 * before write completion, so first send a WRITE command to
+		 * platform
+		 */
+		if (pending_pcc_write_cmd) {
+			pending_pcc_write_cmd = FALSE;
+			send_pcc_cmd(CMD_WRITE);
+		}
+
 		ret = check_pcc_chan();
 		if (ret)
 			return ret;
@@ -191,6 +230,12 @@ static int send_pcc_cmd(u16 cmd)
 	}
 
 	mbox_client_txdone(pcc_channel, ret);
+
+	if (cmd == CMD_WRITE) {
+		pcc_write_cnt++;
+		wake_up_all(&pcc_write_wait_q);
+	}
+
 	return ret;
 }
 
@@ -776,12 +821,10 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	nom_perf = &cpc_desc->cpc_regs[NOMINAL_PERF];
 
 	/* Are any of the regs PCC ?*/
-	if ((highest_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
-		(lowest_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
-		(ref_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
-		(nom_perf->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)) {
-		spin_lock(&pcc_lock);
+	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
+		CPC_IN_PCC(ref_perf) || CPC_IN_PCC(nom_perf)) {
 		regs_in_pcc = 1;
+		down_write(&pcc_lock);
 		/* Ring doorbell once to update PCC subspace */
 		if (send_pcc_cmd(CMD_READ) < 0) {
 			ret = -EIO;
@@ -809,7 +852,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 
 out_err:
 	if (regs_in_pcc)
-		spin_unlock(&pcc_lock);
+		up_write(&pcc_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
@@ -837,9 +880,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
 
 	/* Are any of the regs PCC ?*/
-	if ((delivered_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) ||
-		(reference_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)) {
-		spin_lock(&pcc_lock);
+	if (CPC_IN_PCC(delivered_reg) || CPC_IN_PCC(reference_reg)) {
+		down_write(&pcc_lock);
 		regs_in_pcc = 1;
 		/* Ring doorbell once to update PCC subspace */
 		if (send_pcc_cmd(CMD_READ) < 0) {
@@ -867,7 +909,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 
 out_err:
 	if (regs_in_pcc)
-		spin_unlock(&pcc_lock);
+		up_write(&pcc_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
@@ -884,6 +926,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cpc_register_resource *desired_reg;
 	int ret = 0;
+	unsigned int local_cnt = 0;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
@@ -892,12 +935,35 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
 
-	/* If this is PCC reg, check if channel is free before writing */
-	if (desired_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
-		spin_lock(&pcc_lock);
-		ret = check_pcc_chan();
-		if (ret)
-			goto busy_channel;
+	/*
+	 * This is Phase-I where we want to write to CPC registers
+	 * -> We want all CPUs to be able to execute this phase in parallel
+	 *
+	 * Since read_lock can be acquired by multiple CPUs simultaneously we
+	 * achieve that goal here
+	 */
+	if (CPC_IN_PCC(desired_reg)) {
+		down_read(&pcc_lock);	/* BEGIN Phase-I */
+		/*
+		 * If there are pending write commands i.e pending_pcc_write_cmd
+		 * is TRUE, then we know OSPM owns the channel as another CPU
+		 * has already checked for command completion bit and updated
+		 * the corresponding CPC registers
+		 */
+		if (!pending_pcc_write_cmd) {
+			ret = check_pcc_chan();
+			if (ret) {
+				up_read(&pcc_lock);
+				return ret;
+			}
+			/*
+			 * Update the pending_write to make sure a PCC CMD_READ
+			 * will not arrive and steal the channel during the
+			 * transition to write lock
+			 */
+			pending_pcc_write_cmd = TRUE;
+		}
+		local_cnt = pcc_write_cnt;
 	}
 
 	/*
@@ -906,15 +972,67 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 */
 	cpc_write(desired_reg, perf_ctrls->desired_perf);
 
-	/* Is this a PCC reg ?*/
-	if (desired_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
-		/* Ring doorbell so Remote can get our perf request. */
-		if (send_pcc_cmd(CMD_WRITE) < 0)
-			ret = -EIO;
+	if (CPC_IN_PCC(desired_reg))
+		up_read(&pcc_lock);	/* END Phase-I */
+	/*
+	 * This is Phase-II where we transfer the ownership of PCC to Platform
+	 *
+	 * Short Summary: Basically if we think of a group of cppc_set_perf
+	 * requests that happened in short overlapping interval. The last CPU to
+	 * come out of Phase-I will enter Phase-II and ring the doorbell.
+	 *
+	 * We have the following requirements for Phase-II:
+	 *     1. We want to execute Phase-II only when there are no CPUs
+	 * currently executing in Phase-I
+	 *     2. Once we start Phase-II we want to avoid all other CPUs from
+	 * entering Phase-I.
+	 *     3. We want only one CPU among all those who went through Phase-I
+	 * to run phase-II
+	 *
+	 * If write_trylock fails to get the lock and doesn't transfer the
+	 * PCC ownership to the platform, then one of the following will be TRUE
+	 *     1. There is at-least one CPU in Phase-I which will later execute
+	 * write_trylock, so the CPUs in Phase-I will be responsible for
+	 * executing the Phase-II.
+	 *     2. Some other CPU has beaten this CPU to successfully execute the
+	 * write_trylock and has already acquired the write_lock. We know for a
+	 * fact it(other CPU acquiring the write_lock) couldn't have happened
+	 * before this CPU's Phase-I as we held the read_lock.
+	 *     3. Some other CPU executing pcc CMD_READ has stolen the
+	 * down_write, in which case, send_pcc_cmd will check for pending
+	 * CMD_WRITE commands by checking the pending_pcc_write_cmd.
+	 * So this CPU can be certain that its request will be delivered
+	 *    So in all cases, this CPU knows that its request will be delivered
+	 * by another CPU and can return
+	 *
+	 * After getting the down_write we still need to check for
+	 * pending_pcc_write_cmd to take care of the following scenario
+	 *    The thread running this code could be scheduled out between
+	 * Phase-I and Phase-II. Before it is scheduled back on, another CPU
+	 * could have delivered the request to Platform by triggering the
+	 * doorbell and transferred the ownership of PCC to platform. So this
+	 * avoids triggering an unnecessary doorbell and more importantly before
+	 * triggering the doorbell it makes sure that the PCC channel ownership
+	 * is still with OSPM.
+	 *   pending_pcc_write_cmd can also be cleared by a different CPU, if
+	 * there was a pcc CMD_READ waiting on down_write and it steals the lock
+	 * before the pcc CMD_WRITE is completed. pcc_send_cmd checks for this
+	 * case during a CMD_READ and if there are pending writes it delivers
+	 * the write command before servicing the read command
+	 */
+	if (CPC_IN_PCC(desired_reg)) {
+		if (down_write_trylock(&pcc_lock)) {		/* BEGIN Phase-II */
+			/* Update only if there are pending write commands */
+			if (pending_pcc_write_cmd) {
+				pending_pcc_write_cmd = FALSE;
+				if (send_pcc_cmd(CMD_WRITE) < 0)
+					ret = -EIO;
+			}
+			up_write(&pcc_lock);			/* END Phase-II */
+		} else
+			/* Wait until pcc_write_cnt is updated by send_pcc_cmd */
+			wait_event(pcc_write_wait_q, local_cnt != pcc_write_cnt);
 	}
-busy_channel:
-	if (desired_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
-		spin_unlock(&pcc_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_set_perf);
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

