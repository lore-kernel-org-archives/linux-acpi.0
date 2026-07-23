Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339044C9549;
	Thu, 23 Jul 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817598; cv=none; b=Mu8MSj3yqC0WK/TWfiXdUVmVsaB0o0XTEgiJCLh5Ue4BNLCf1hbO8e9q9Lf96uCNwFc2CLZzHOTd6PeOBj9r28Il3LrkWsQtkpBWSlh5iArkDey/4rDHW57uFMSEzIbYvi0DbGysY9HDOCE3fHxPtdjeqzYlgKdYBUhl8ByiH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817598; c=relaxed/simple;
	bh=GcI2SiPc0YGZnO56whRXr7+e5nlvFiscXF4ro/2oLjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSk92whh22c10ar0KHLoRLRzM88NJacV+8luICCcFdVGsKatu9L+4psylrwhK4v2FypcIUWc02NC9NEIreyVSz/OF+foUXZkLJBpx3Bc5DA5cvpOWTtrnguVJJWxWlqxPZ7esC7aWQbvUQtUmm7HGmMzXg5/AAw6qefWTjq5rMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuL+UN19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuL+UN19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EBC1F00A3F;
	Thu, 23 Jul 2026 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817586;
	bh=FYAIdNSFBh1tmWSYv6lySAtsNEn5shjkM0e1ZGc5R34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PuL+UN198q7F/FI5K2WK66u6V0dGz+4sEVxeovHwtnaTHcezoiNVfSXWiDuYK2nWM
	 BKAsn4THe7WXp8dXXfI+QfirBef4So5lAQ+U1fCby+P5MvhTcoe6Zsm/2fGNxahafx
	 jLoGrla2CQ7AN5krQDzf5F1qRf3jWpZCdg/vVrj55syHMdY0q5qOiynaYdXR4cTw6T
	 eWRw7S0Hw7wWdljODviiHS0YP6ArA4S/5VxiCM1CeEIB46e/MrY+jrlaLGg2x11u97
	 V7mCjbKDsdu7ZswFLY1rbYlyfQdFD2SbzKA0T46VB4ygPSoKqvAticlV5ngxRfrT6z
	 rfYcfW7b8kyrw==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v2 3/3] mailbox: pcc: Fix command timeout due to missed interrupt
Date: Thu, 23 Jul 2026 15:39:28 +0100
Message-ID: <20260723143928.2625970-4-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723143928.2625970-1-sudeep.holla@kernel.org>
References: <20260723143928.2625970-1-sudeep.holla@kernel.org>
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
the lockless flag updates and READ_ONCE() in the interrupt handler. The
following ordered I/O accessor orders the flag store before the platform
is notified.

Clear chan_in_use if ringing the doorbell fails. Otherwise, leave it set
until the interrupt handler completes the transaction, clearing it before
the mailbox core can submit another transfer.

Fixes: 3db174e478cb ("mailbox: pcc: Support shared interrupt for multiple subspaces")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/mailbox/pcc.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 8dfa80b0a90f..9888dab64639 100644
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
+ * @chan_in_use: lockless flag used by type 3 initiator subspaces to filter
+ *		platform interrupts. Only one transfer can occur at a time, but
+ *		the interrupt handler may sample the flag on another CPU, so all
+ *		accesses must use READ_ONCE() or WRITE_ONCE(). Other subspace
+ *		types do not test it.
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
@@ -320,8 +319,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
 		return IRQ_NONE;
 
+	/*
+	 * Initiator subspaces use this flag to filter shared interrupts. Use
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
+	 * Clear this flag after updating the interrupt ack register and before
+	 * notifying the client and mailbox core. mbox_chan_txdone() may submit
+	 * the next queued transfer and set the flag again. Use WRITE_ONCE() for
+	 * the lockless update observed by the send and interrupt paths.
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
+	 * ordered I/O accessor used to ring the doorbell orders this store
+	 * before the platform is notified.
+	 */
+	if (pchan->plat_irq > 0)
+		WRITE_ONCE(pchan->chan_in_use, true);
 	ret = pcc_chan_reg_read_modify_write(&pchan->db);
-	if (!ret && pchan->plat_irq > 0)
-		pchan->chan_in_use = true;
+	if (ret && pchan->plat_irq > 0)
+		WRITE_ONCE(pchan->chan_in_use, false);
 
 	return ret;
 }
-- 
2.43.0

