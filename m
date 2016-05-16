From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH] ACPI/CPPC: Support for batching CPPC requests
Date: Mon, 16 May 2016 17:39:11 -0600
Message-ID: <1463441951-13207-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45657 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbcEPXjV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 May 2016 19:39:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, ashwin.chaugule@linaro.org, pprakash@codeaurora.org

CPPC defined in section 8.4.7 of ACPI 6.1 specification suggests
"To amortize the cost of PCC transactions, OSPM should read or write
all PCC registers via a single read or write command when possible"
This patch enables opportunistic batching of frequency transition
requests whenever the request happen to overlap in time.

Currently the access to pcc is serialized by a spin lock which does
not scale well as we increase the number of cores in the system. This
patch improves the scalability by allowing the differnt CPU cores to
update PCC subspace in parallel and by batching requests which will
reduce certain types of operation(checking command completion bit,
ringing doorbell) by a significant margin.

Profiling shows significant improvement in the time to service freq.
transition request. Using a workload which includes multiple iteration
of configure+make of vim (with -j24 option):
Without batching requests(without this patch),
	6 domains: Avg=3D20us/request; 24 domains: Avg=3D52us/request
With batching requests(with this patch),
	6 domains: Avg=3D16us/request; 24 domains: Avg=3D19us/request
domain: An individual cpu or a set of related CPUs whose frequency can
be scaled independently

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/cppc_acpi.c | 166 +++++++++++++++++++++++++++++++++++++++=
+-------
 1 file changed, 141 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8adac69..3edfd50 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -43,12 +43,34 @@
=20
 #include <acpi/cppc_acpi.h>
 /*
- * Lock to provide mutually exclusive access to the PCC
- * channel. e.g. When the remote updates the shared region
- * with new data, the reader needs to be protected from
- * other CPUs activity on the same channel.
+ * Lock to provide controlled access to the PCC channel.
+ *
+ * For performance critical usecases(currently cppc_set_perf)
+ *	We need to take read_lock and check if channel belongs to OSPM befo=
re
+ * reading or writing to PCC subspace
+ *	We need to take write_lock before transferring the channel ownershi=
p to
+ * the platform via a Doorbell
+ *
+ * For non-performance critical usecases(init)
+ *	Take write_lock for all purposes which gives exclusive access
+ *
+ * Why not use spin lock?
+ *	One of the advantages of CPPC is that we can batch/group a large nu=
mber
+ * of requests from differnt CPUs and send one request to the platform=
=2E Using a
+ * read-write spinlock allows us to do this in a effecient manner.
+ *	On larger multicore systems, if we get a large group of cppc_set_pe=
rf
+ * calls they all serialize behind a spin lock, but using a rwlock we =
can
+ * execute the requests in a much more scalable manner.
+ *	See cppc_set_perf() for more details
+ */
+static DEFINE_RWLOCK(pcc_lock);
+
+/*
+ * This bool is set to True when we have updated the CPC registers but=
 hasn't
+ * triggered a doorbell yet.
+ * Once we trigger a doorbell for WRITE command we reset this to False
  */
-static DEFINE_SPINLOCK(pcc_lock);
+static bool pending_pcc_write_cmd;
=20
 /*
  * The cpc_desc structure contains the ACPI register details
@@ -105,6 +127,10 @@ static int check_pcc_chan(void)
 	return ret;
 }
=20
+/*
+ * This function transfers the ownership of the PCC to the platform
+ * So it must be called while holding write_lock(pcc_lock)
+ */
 static int send_pcc_cmd(u16 cmd)
 {
 	int ret =3D -EIO;
@@ -119,6 +145,16 @@ static int send_pcc_cmd(u16 cmd)
 	 * the channel before writing to PCC space
 	 */
 	if (cmd =3D=3D CMD_READ) {
+		/*
+		 * If there are pending cpc_writes, then we stole the channel
+		 * before write completion, so first send a WRITE command to
+		 * platform
+		 */
+		if (pending_pcc_write_cmd) {
+			pending_pcc_write_cmd =3D FALSE;
+			send_pcc_cmd(CMD_WRITE);
+		}
+
 		ret =3D check_pcc_chan();
 		if (ret)
 			return ret;
@@ -723,6 +759,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf=
_caps *perf_caps)
 								 *nom_perf;
 	u64 high, low, ref, nom;
 	int ret =3D 0;
+	bool caps_regs_in_pcc =3D FALSE;
=20
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -734,13 +771,15 @@ int cppc_get_perf_caps(int cpunum, struct cppc_pe=
rf_caps *perf_caps)
 	ref_perf =3D &cpc_desc->cpc_regs[REFERENCE_PERF];
 	nom_perf =3D &cpc_desc->cpc_regs[NOMINAL_PERF];
=20
-	spin_lock(&pcc_lock);
-
-	/* Are any of the regs PCC ?*/
+	/* Are any of the regs PCC ? */
 	if ((highest_reg->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLATFO=
RM_COMM) ||
 			(lowest_reg->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_=
COMM) ||
 			(ref_perf->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_CO=
MM) ||
 			(nom_perf->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_CO=
MM)) {
+
+		caps_regs_in_pcc =3D TRUE;
+		write_lock(&pcc_lock);
+
 		/* Ring doorbell once to update PCC subspace */
 		if (send_pcc_cmd(CMD_READ) < 0) {
 			ret =3D -EIO;
@@ -767,7 +806,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf=
_caps *perf_caps)
 		ret =3D -EFAULT;
=20
 out_err:
-	spin_unlock(&pcc_lock);
+	if (caps_regs_in_pcc)
+		write_unlock(&pcc_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
@@ -785,6 +825,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf=
_fb_ctrs *perf_fb_ctrs)
 	struct cpc_register_resource *delivered_reg, *reference_reg;
 	u64 delivered, reference;
 	int ret =3D 0;
+	bool ctrs_regs_in_pcc =3D FALSE;
=20
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -794,11 +835,12 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_pe=
rf_fb_ctrs *perf_fb_ctrs)
 	delivered_reg =3D &cpc_desc->cpc_regs[DELIVERED_CTR];
 	reference_reg =3D &cpc_desc->cpc_regs[REFERENCE_CTR];
=20
-	spin_lock(&pcc_lock);
-
 	/* Are any of the regs PCC ?*/
 	if ((delivered_reg->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLAT=
=46ORM_COMM) ||
 			(reference_reg->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLATFO=
RM_COMM)) {
+		ctrs_regs_in_pcc =3D TRUE;
+		write_lock(&pcc_lock);
+
 		/* Ring doorbell once to update PCC subspace */
 		if (send_pcc_cmd(CMD_READ) < 0) {
 			ret =3D -EIO;
@@ -824,7 +866,9 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf=
_fb_ctrs *perf_fb_ctrs)
 	perf_fb_ctrs->prev_reference =3D reference;
=20
 out_err:
-	spin_unlock(&pcc_lock);
+	if (ctrs_regs_in_pcc)
+		write_unlock(&pcc_lock);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
@@ -849,13 +893,34 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls=
 *perf_ctrls)
=20
 	desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
=20
-	spin_lock(&pcc_lock);
-
-	/* If this is PCC reg, check if channel is free before writing */
+	/*
+	 * This is Phase-I where we want to write to CPC registers
+	 * -> We want all CPUs to be able to execute this phase in parallel
+	 *
+	 * Since read_lock can be acquired by multiple CPUs simultaneously we
+	 * achieve that goal here
+	 */
 	if (desired_reg->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLATFOR=
M_COMM) {
-		ret =3D check_pcc_chan();
-		if (ret)
-			goto busy_channel;
+		read_lock(&pcc_lock);	/* BEGIN Phase-I */
+		/*
+		 * If there are pending write commands i.e pending_pcc_write_cmd
+		 * is TRUE, then we know OSPM owns the channel as another CPU
+		 * has already checked for command completion bit and updated
+		 * the corresponding CPC registers
+		 */
+		if (!pending_pcc_write_cmd) {
+			ret =3D check_pcc_chan();
+			if (ret) {
+				read_unlock(&pcc_lock);
+				return ret;
+			}
+			/*
+			 * Update the pending_write to make sure a PCC CMD_READ
+			 * will not arrive and steal the channel during the
+			 * transition to write lock
+			 */
+			pending_pcc_write_cmd =3D TRUE;
+		}
 	}
=20
 	/*
@@ -864,15 +929,66 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls=
 *perf_ctrls)
 	 */
 	cpc_write(&desired_reg->cpc_entry.reg, perf_ctrls->desired_perf);
=20
-	/* Is this a PCC reg ?*/
+	if (desired_reg->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLATFOR=
M_COMM)
+		read_unlock(&pcc_lock);	/* END Phase-I */
+
+	/*
+	 * This is Phase-II where we transfer the ownership of PCC to Platfor=
m
+	 *
+	 * Short Summary: Basically if we think of a group of cppc_set_perf
+	 * requests that happened in short overlapping interval. The last CPU=
 to
+	 * come out of Phase-I will enter Phase-II and ring the doorbell.
+	 *
+	 * We have the following requirements for Phase-II:
+	 *     1. We want to execute Phase-II only when there are no CPUs
+	 * currently executing in Phase-I
+	 *     2. Once we start Phase-II we want to avoid all other CPUs from
+	 * entering Phase-I.
+	 *     3. We want only one CPU among all those who went through Phase=
-I
+	 * to run phase-II
+	 *
+	 * If write_trylock fails to get the lock and doesn't transfer the
+	 * PCC ownership to the platform, then one of the following will be T=
RUE
+	 *     1. There is at-least one CPU in Phase-I which will later execu=
te
+	 * write_trylock, so the CPUs in Phase-I will be responsible for
+	 * executing the Phase-II.
+	 *     2. Some other CPU has beaten this CPU to successfully execute =
the
+	 * write_trylock and has already acquired the write_lock. We know for=
 a
+	 * fact it(other CPU acquiring the write_lock) couldn=E2=80=99t have =
happened
+	 * before this CPU=E2=80=99s Phase-I as we held the read_lock.
+	 *     3. Some other CPU executing pcc CMD_READ has stolen the
+	 * write_lock, in which case, send_pcc_cmd will check for pending
+	 * CMD_WRITE commands by checking the pending_pcc_write_cmd.
+	 * So this CPU can be certain that its request will be delivered
+	 *    So in all cases, this CPU knows that its request will be delive=
red
+	 * by another CPU and can return
+	 *
+	 * After getting the write_lock we still need to check for
+	 * pending_pcc_write_cmd to take care of the following scenario
+	 *    The thread running this code could be scheduled out between
+	 * Phase-I and Phase-II. Before it is scheduled back on, another CPU
+	 * could have delivered the request to Platform by triggering the
+	 * doorbell and transferred the ownership of PCC to platform. So this
+	 * avoids triggering an unnecessary doorbell and more importantly bef=
ore
+	 * triggering the doorbell it makes sure that the PCC channel ownersh=
ip
+	 * is still with OSPM.
+	 *   pending_pcc_write_cmd can also be cleared by a different CPU, if
+	 * there was a pcc CMD_READ waiting on write_lock and it steals the l=
ock
+	 * before the pcc CMD_WRITE is completed. pcc_send_cmd checks for thi=
s
+	 * case during a CMD_READ and if there are pending writes it delivers
+	 * the write command before servicing the read command
+	 */
 	if (desired_reg->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLATFOR=
M_COMM) {
-		/* Ring doorbell so Remote can get our perf request. */
-		if (send_pcc_cmd(CMD_WRITE) < 0)
-			ret =3D -EIO;
+		if (write_trylock(&pcc_lock)) {		/* BEGIN Phase-II */
+			/* Update only if there are pending write commands */
+			if (pending_pcc_write_cmd) {
+				pending_pcc_write_cmd =3D FALSE;
+				if (send_pcc_cmd(CMD_WRITE) < 0)
+					ret =3D -EIO;
+			}
+			write_unlock(&pcc_lock);	 /* END Phase-II */
+		}
 	}
-busy_channel:
-	spin_unlock(&pcc_lock);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cppc_set_perf);
--=20
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center=
, Inc.=20
is a member of the Code Aurora Forum, a Linux Foundation Collaborative =
Project.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
