From: Alexey Klimov <alexey.klimov@arm.com>
Subject: [PATCH RESEND] mailbox: pcc: fix channel calculation in get_pcc_channel()
Date: Tue,  2 Feb 2016 11:29:22 +0000
Message-ID: <1454412562-28543-1-git-send-email-alexey.klimov@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54746 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754279AbcBBL3a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Feb 2016 06:29:30 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: jassisinghbrar@gmail.com, sudeep.holla@arm.com, ashwin.chaugule@linaro.org, pprakash@codeaurora.org, linux-kernel@vger.kernel.org

This patch fixes the calculation of pcc_chan for non-zero id.
After the compiler ignores the (unsigned long) cast the
pcc_mbox_channels pointer is type-cast and then the type-cast
offset is added which results in address outside of the range
leading to the kernel crashing.

We might add braces and make it:

pcc_chan = (struct mbox_chan *)
		((unsigned long) pcc_mbox_channels +
		(id * sizeof(*pcc_chan)));

but let's go with array approach here and use id as index.

Tested on Juno board.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>
---
 drivers/mailbox/pcc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 45d85ae..8f779a1 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -81,16 +81,10 @@ static struct mbox_controller pcc_mbox_ctrl = {};
  */
 static struct mbox_chan *get_pcc_channel(int id)
 {
-	struct mbox_chan *pcc_chan;
-
 	if (id < 0 || id > pcc_mbox_ctrl.num_chans)
 		return ERR_PTR(-ENOENT);
 
-	pcc_chan = (struct mbox_chan *)
-		(unsigned long) pcc_mbox_channels +
-		(id * sizeof(*pcc_chan));
-
-	return pcc_chan;
+	return &pcc_mbox_channels[id];
 }
 
 /**
-- 
1.9.1

