From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V4 4/5] acpi: cppc: replace writeX/readX to PCC with relaxed version
Date: Wed, 17 Feb 2016 13:21:02 -0700
Message-ID: <1455740463-19192-5-git-send-email-pprakash@codeaurora.org>
References: <1455740463-19192-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53144 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965451AbcBQUV2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2016 15:21:28 -0500
In-Reply-To: <1455740463-19192-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: ashwin.chaugule@linaro.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, alexey.klimov@arm.com, Prashanth Prakash <pprakash@codeaurora.org>

We do not have a strict read/write order requirement while accessing
PCC subspace. The only requirement is all access should be committed
before triggering the PCC doorbell to transfer the ownership of PCC
to the platform and this requirement is enforced by the PCC driver.

Profiling on a many core system shows improvement of about 1.8us on
average per freq change request(about 10% improvement on average).
Since these operations are executed while holding the pcc_lock,
reducing this time helps the CPPC implementation to scale much
better as the number of cores increases.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/cppc_acpi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6970b44..8a0911a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -116,10 +116,10 @@ static int send_pcc_cmd(u16 cmd)
 	}
 
 	/* Write to the shared comm region. */
-	writew(cmd, &generic_comm_base->command);
+	writew_relaxed(cmd, &generic_comm_base->command);
 
 	/* Flip CMD COMPLETE bit */
-	writew(0, &generic_comm_base->status);
+	writew_relaxed(0, &generic_comm_base->status);
 
 	/* Ring doorbell */
 	ret = mbox_send_message(pcc_channel, &cmd);
@@ -601,16 +601,16 @@ static int cpc_read(struct cpc_reg *reg, u64 *val)
 
 		switch (reg->bit_width) {
 		case 8:
-			*val = readb(vaddr);
+			*val = readb_relaxed(vaddr);
 			break;
 		case 16:
-			*val = readw(vaddr);
+			*val = readw_relaxed(vaddr);
 			break;
 		case 32:
-			*val = readl(vaddr);
+			*val = readl_relaxed(vaddr);
 			break;
 		case 64:
-			*val = readq(vaddr);
+			*val = readq_relaxed(vaddr);
 			break;
 		default:
 			pr_debug("Error: Cannot read %u bit width from PCC\n",
@@ -632,16 +632,16 @@ static int cpc_write(struct cpc_reg *reg, u64 val)
 
 		switch (reg->bit_width) {
 		case 8:
-			writeb(val, vaddr);
+			writeb_relaxed(val, vaddr);
 			break;
 		case 16:
-			writew(val, vaddr);
+			writew_relaxed(val, vaddr);
 			break;
 		case 32:
-			writel(val, vaddr);
+			writel_relaxed(val, vaddr);
 			break;
 		case 64:
-			writeq(val, vaddr);
+			writeq_relaxed(val, vaddr);
 			break;
 		default:
 			pr_debug("Error: Cannot write %u bit width to PCC\n",
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

