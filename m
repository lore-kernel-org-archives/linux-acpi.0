From: Hoan Tran <hotran@apm.com>
Subject: [PATCH v2] mailbox: PCC: Fix lockdep warning when request PCC channel
Date: Tue, 18 Oct 2016 00:00:07 -0700
Message-ID: <1476774007-10218-1-git-send-email-hotran@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37906 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758599AbcJRHBB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Oct 2016 03:01:01 -0400
Received: by mail-it0-f54.google.com with SMTP id 66so30128034itl.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Oct 2016 00:01:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jassi Brar <jassisinghbrar@gmail.com>, Prakash Prashanth <pprakash@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, Hoan Tran <hotran@apm.com>

This patch fixes the lockdep warning below

[    7.229767] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
[    7.229776] ------------[ cut here ]------------
[    7.229787] WARNING: CPU: 1 PID: 1 at linux-next/kernel/locking/lockdep.c:2876 loc
kdep_trace_alloc+0xe0/0xf0
[    7.229790] Modules linked in:
[    7.229793]
[    7.229798] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-11756-g86c5152 #46
...
[    7.229900] Call trace:
[    7.229903] Exception stack(0xffff8007da837890 to 0xffff8007da8379c0)
[    7.229906] 7880:                                   ffff8007da834000 0001000000000000
[    7.229909] 78a0: ffff8007da837a70 ffff0000081111a0 00000000600000c5 000000000000003d
[    7.229912] 78c0: 9374bc6a7f3c7832 0000000000381878 ffff000009db7ab8 000000000000002f
[    7.229915] 78e0: ffff00000811aabc ffff000008be2548 ffff8007da837990 ffff00000811adf8
[    7.229918] 7900: ffff8007da834000 00000000024080c0 00000000000000c0 ffff000009021000
[    7.229921] 7920: 0000000000000000 0000000000000000 ffff000008c8f7c8 ffff8007da579810
[    7.229923] 7940: 000000000000002f ffff8007da858000 0000000000000000 0000000000000001
[    7.229926] 7960: 0000000000000001 0000000000000000 ffff00000811a468 0000000000000002
[    7.229929] 7980: 656c62617369645f 0000000000038187 00000000000000ee ffff8007da837850
[    7.229932] 79a0: ffff000009db50c0 ffff000009db569d 0000000000000006 ffff000089db568f
[    7.229936] [<ffff0000081111a0>] lockdep_trace_alloc+0xe0/0xf0
[    7.229940] [<ffff0000081f4950>] __kmalloc_track_caller+0x50/0x250
[    7.229945] [<ffff00000857c088>] devres_alloc_node+0x28/0x60
[    7.229949] [<ffff0000081220e0>] devm_request_threaded_irq+0x50/0xe0
[    7.229955] [<ffff0000087e6220>] pcc_mbox_request_channel+0x110/0x170
[    7.229960] [<ffff0000084b2660>] acpi_cppc_processor_probe+0x264/0x414
[    7.229963] [<ffff0000084ae9f4>] __acpi_processor_start+0x28/0xa0
[    7.229966] [<ffff0000084aeab0>] acpi_processor_start+0x44/0x54
[    7.229970] [<ffff00000857897c>] driver_probe_device+0x1fc/0x2b0
[    7.229974] [<ffff000008578ae4>] __driver_attach+0xb4/0xc0
[    7.229977] [<ffff00000857683c>] bus_for_each_dev+0x5c/0xa0
[    7.229980] [<ffff000008578110>] driver_attach+0x20/0x30
[    7.229983] [<ffff000008577c20>] bus_add_driver+0x110/0x230
[    7.229987] [<ffff000008579320>] driver_register+0x60/0x100
[    7.229991] [<ffff000008d478b8>] acpi_processor_driver_init+0x2c/0xb0
[    7.229996] [<ffff000008083168>] do_one_initcall+0x38/0x130
[    7.230000] [<ffff000008d20d6c>] kernel_init_freeable+0x210/0x2b4
[    7.230004] [<ffff000008945d90>] kernel_init+0x10/0x110
[    7.230007] [<ffff000008082e80>] ret_from_fork+0x10/0x50

It's because the spinlock inside pcc_mbox_request_channel() is
kept too long. This patch releases spinlock before request_irq()
and free_irq() to fix this issue  as spinlock is only needed to
protect the channel data.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
v2
 * Release spinlock before request_irq() and free_irq() instead of
using mutex

 drivers/mailbox/pcc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 08c87fa..b5275a8 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -267,6 +267,8 @@ struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 	if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
 		chan->txdone_method |= TXDONE_BY_ACK;
 
+	spin_unlock_irqrestore(&chan->lock, flags);
+
 	if (pcc_doorbell_irq[subspace_id] > 0) {
 		int rc;
 
@@ -279,8 +281,6 @@ struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 		}
 	}
 
-	spin_unlock_irqrestore(&chan->lock, flags);
-
 	return chan;
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
@@ -310,10 +310,10 @@ void pcc_mbox_free_channel(struct mbox_chan *chan)
 	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
 		chan->txdone_method = TXDONE_BY_POLL;
 
+	spin_unlock_irqrestore(&chan->lock, flags);
+
 	if (pcc_doorbell_irq[id] > 0)
 		devm_free_irq(chan->mbox->dev, pcc_doorbell_irq[id], chan);
-
-	spin_unlock_irqrestore(&chan->lock, flags);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
-- 
1.9.1

