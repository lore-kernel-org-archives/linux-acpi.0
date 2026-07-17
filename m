Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83D3D0905;
	Fri, 17 Jul 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275029; cv=none; b=ONdGLMv8bH5uAumK6zX4xXSu7LdccudItnt04M1BiczH1yoqNCBXqKPpexDIPIqctaagScJ8L1NB4bOZUBYALPnX+tTacXDW5tzuvKNcdZ0QYa26nfAUHy14ejVycBgz33MAD4jw+2eI+eb6kU8/5mdExM4AH//fyWnC/9ir3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275029; c=relaxed/simple;
	bh=VYkib/2tRK0MBPMozIws6bs2eWmGsXy9ur+00gGPjsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBtfg1/7DoHDPCcc2CcPCXdncq7rUq0fOJAanYakxNIXHsR1VTnOcLEGAEk1Zp0T1A2sRo8LFwETRLEROwad2e0qN0h/Df91wGVnqoNssUGM5/yQHvCe972G2qW4MKQ0O6AUrY/w6cvsv97jTG8ei0xzcMmyHgDqv6CSwthrwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjUYeDjw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjUYeDjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593191F00A3D;
	Fri, 17 Jul 2026 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275026;
	bh=l3gnAzfGUV0GNzGVkfZ16Z7U7vo259vFrwqGerv2HUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XjUYeDjwBeDv4RcNTGVLbpROQIk+JP+bX0Ou3MuG0qYgm4NA9APpkBey4CC5On7EN
	 eK45M6ebVj5oYDAsBuCayDBwAld1jmxuf1KgCcvgOF7XNRMDkQCSDdlHAwKfkzU7iw
	 4kGGB7i2MD83NaWflGp9QgR31ORl5Yy7nDSAKBrANbnnwf83ARONjZ0D8/vBbm2kv5
	 h1gkShOj4fp0V3wDeQoMNE7y6UD8V8yJB7qUDnbYkOMl269QIDbjdeM4fLmtC9priR
	 9R11q6fP6GWz4eWMw9JGBaFdig3lsZsZmIMADe1H86tOGyr04Bdbgkh4075GFW9+zM
	 Yh7OP3VZCWEbg==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 3/3] mailbox: pcc: Fix command timeout due to missed interrupt
Date: Fri, 17 Jul 2026 08:56:49 +0100
Message-ID: <20260717075649.467172-4-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717075649.467172-1-sudeep.holla@kernel.org>
References: <20260717075649.467172-1-sudeep.holla@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Huisong Li <lihuisong@huawei.com>

PCC command execution can time out when a fast platform completes a
transaction and signals the platform interrupt before pcc_send_data()
marks the channel as in use. For shared platform interrupts, the type 3
handler uses chan_in_use to decide whether the interrupt belongs to the
channel. If it observes false, it ignores the completion and the caller
waits until timeout.

Publish chan_in_use before ringing the doorbell. Use WRITE_ONCE() for
the lockless flag update and READ_ONCE() in the interrupt handler when
filtering shared interrupts. The following ordered MMIO accessor used for
the doorbell keeps the earlier store visible before the platform is
notified.

Clear chan_in_use with WRITE_ONCE() when completing the transaction,
matching the lockless flag protocol used by the interrupt and send paths.

Fixes: 3db174e478cb ("mailbox: pcc: Support shared interrupt for multiple subspaces")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/mailbox/pcc.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 8dfa80b0a90f..7f99d4ab0129 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -91,12 +91,11 @@ struct pcc_chan_reg {
  * @plat_irq: platform interrupt
  * @type: PCC subspace type
  * @plat_irq_flags: platform interrupt flags
- * @chan_in_use: this flag is used just to check if the interrupt needs
- *		handling when it is shared. Since only one transfer can occur
- *		at a time and mailbox takes care of locking, this flag can be
- *		accessed without a lock. Note: the type only support the
- *		communication from OSPM to Platform, like type3, use it, and
- *		other types completely ignore it.
+ * @chan_in_use: lockless flag used by initiator subspaces, such as type 3,
+ *		to filter shared platform interrupts. Only one transfer can occur
+ *		at a time, but the interrupt handler may sample the flag on another
+ *		CPU, so all accesses must use READ_ONCE() or WRITE_ONCE().
+ *		Other subspace types ignore it.
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
@@ -320,8 +319,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
 		return IRQ_NONE;
 
+	/*
+	 * Master subspaces use this flag to filter shared interrupts. Use
+	 * READ_ONCE() to sample the lockless flag written by pcc_send_data()
+	 * on another CPU.
+	 */
 	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
-	    !pchan->chan_in_use)
+	    !READ_ONCE(pchan->chan_in_use))
 		return IRQ_NONE;
 
 	if (!pcc_mbox_cmd_complete_check(pchan))
@@ -331,12 +335,12 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 		return IRQ_NONE;
 
 	/*
-	 * Clear this flag after updating interrupt ack register and just
-	 * before mbox_chan_received_data() which might call pcc_send_data()
-	 * where the flag is set again to start new transfer. This is
-	 * required to avoid any possible race in updatation of this flag.
+	 * Clear this flag after updating the interrupt ack register and just
+	 * before mbox_chan_received_data(), which might call pcc_send_data()
+	 * and set the flag again to start a new transfer. Use WRITE_ONCE()
+	 * for the lockless update observed by the send and interrupt paths.
 	 */
-	pchan->chan_in_use = false;
+	WRITE_ONCE(pchan->chan_in_use, false);
 	mbox_chan_received_data(chan, NULL);
 	mbox_chan_txdone(chan, 0);
 
@@ -464,9 +468,18 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	if (ret)
 		return ret;
 
+	/*
+	 * Set chan_in_use before ringing the doorbell so a fast completion
+	 * interrupt is not mistaken for a shared interrupt from another
+	 * subspace. Use WRITE_ONCE() for the lockless flag update. The
+	 * ordered MMIO accessor used to ring the doorbell keeps this store
+	 * visible before the platform is notified.
+	 */
+	if (pchan->plat_irq > 0)
+		WRITE_ONCE(pchan->chan_in_use, true);
 	ret = pcc_chan_reg_read_modify_write(&pchan->db);
 	if (!ret && pchan->plat_irq > 0)
-		pchan->chan_in_use = true;
+		WRITE_ONCE(pchan->chan_in_use, false);
 
 	return ret;
 }
-- 
2.43.0

