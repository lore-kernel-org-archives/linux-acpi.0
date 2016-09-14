From: Hoan Tran <hotran@apm.com>
Subject: [RESEND PATCH] ACPI: CPPC: Support PCC with interrupt flag
Date: Wed, 14 Sep 2016 10:54:58 -0700
Message-ID: <1473875698-12402-1-git-send-email-hotran@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, pprakash@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, Hoan Tran <hotran@apm.com>
List-Id: linux-acpi@vger.kernel.org

For PCC mailbox with interrupt flag, CPPC should call mbox_chan_txdone()
function to notify the mailbox framework about TX completion.

Signed-off-by: Hoan Tran <hotran@apm.com>
Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/cppc_acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3d1ae6d..d0d0504 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -311,7 +311,10 @@ static int send_pcc_cmd(u16 cmd)
 	if (pcc_data.pcc_mrtt)
 		last_cmd_cmpl_time = ktime_get();
 
-	mbox_client_txdone(pcc_data.pcc_channel, ret);
+	if (pcc_data.pcc_channel->mbox->txdone_irq)
+		mbox_chan_txdone(pcc_data.pcc_channel, ret);
+	else
+		mbox_client_txdone(pcc_data.pcc_channel, ret);
 
 end:
 	if (cmd == CMD_WRITE) {
-- 
1.9.1
