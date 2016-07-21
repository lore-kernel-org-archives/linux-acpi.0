From: Hoan Tran <hotran@apm.com>
Subject: [PATCH] ACPI: CPPC: Support PCC with interrupt flag
Date: Thu, 21 Jul 2016 14:07:45 -0700
Message-ID: <1469135265-27048-1-git-send-email-hotran@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, pprakash@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, Hoan Tran <hotran@apm.com>
List-Id: linux-acpi@vger.kernel.org

For PCC mailbox with interrupt flag, CPPC should call mbox_chan_txdone()
function to notify the mailbox framework about TX completion.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
This patch is tested on top and depends on patch[1]:
[1] http://www.spinics.net/lists/linux-acpi/msg66041.html
 - [PATCH v3] mailbox: pcc: Support HW-Reduced Communication Subspace type 2

 drivers/acpi/cppc_acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2e98173..19606aa 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -191,7 +191,11 @@ static int send_pcc_cmd(u16 cmd)
 			last_cmd_cmpl_time = ktime_get();
 	}
 
-	mbox_client_txdone(pcc_channel, ret);
+	if (pcc_channel->mbox->txdone_irq)
+		mbox_chan_txdone(pcc_channel, ret);
+	else
+		mbox_client_txdone(pcc_channel, ret);
+
 	return ret;
 }
 
-- 
1.9.1
