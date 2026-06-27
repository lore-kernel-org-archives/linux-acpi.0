Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26A25D527;
	Sat, 27 Jun 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782570666; cv=none; b=e3kRkI0tZ9bu0keWxs3mstCzXNCOuyDfdGIwP2V9LqwC7DSNUh0Q114GoWRe63N8jsBfV0J+X4lBqGcThiJKgQePRoL0uFXmhcktiZYmnW9fA4cAMzsFJzbq8LXatarcqtKTEALhec1pNUPtWH+cgBi7LQZ4ulo9eGckEK0JQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782570666; c=relaxed/simple;
	bh=56SxzWsNLEhTQwKoXdNHHJBtkwn2hn1Dvlamh3lIfI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8Cc4qKbvvVswa7hQtUNta5zVgUs2MnCPVW0qUOVy0iRy70CpZpj/mjzEVaFU/yyqrIIj3f5A+Id3KmcizolsuAAQgRvoKespHg2X/JD/ndv7vP210scg5ORoRznDGrijrdC+vx+z2IDn8oEigKxIMu48PIqOF36oLGXdwyUTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI8n4i4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI8n4i4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452771F000E9;
	Sat, 27 Jun 2026 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782570664;
	bh=JCH3A23ChIfn7eVR4HFqZbMo637oQStVmjDk7xE8v0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iI8n4i4g+v4PokTcys3CI9ddr3dJkaRpBh9sN5MUwFV7gB0uE1MwJSx3aoNR9supz
	 pA/K1rDMPnKeLMIktpJ02z7U7OjeT/VW054FAU6/moAvQvKXxtvYpktpDfeL5lpdUH
	 EhKU1bNuYl/4v6LgQkbLOidnZlHv4Ghh3iHwxwcXzxKgSBrz4Lp86bYKFfUt70FMPc
	 ZbRyXI5Wt2tPRydYSajhPAhtfHRQWZxDRgyqfYR/hIj3STie2U5+xzC4CxdcBx+Tll
	 jMC72noSSS1G8KXzahBDRzLi5d7DkrpeJRbqE+ECbeYxHcPjQK3ZCyE1vG31u3rRyU
	 b5O9uHH+U0caw==
Date: Sat, 27 Jun 2026 15:31:01 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Huisong Li <lihuisong@huawei.com>
Cc: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH] mailbox: pcc: Fix probabilistic command execution timeout
Message-ID: <20260627-bright-objective-bloodhound-db3fde@sudeepholla>
References: <20260417031429.2509443-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417031429.2509443-1-lihuisong@huawei.com>

Hi Huisong,

Sorry for the delay, this seem to have slipped through the cracks.

On Fri, Apr 17, 2026 at 11:14:29AM +0800, Huisong Li wrote:
> In some scenarios, PCC command may experience probabilistic timeout.
> This is primarily caused by the chan_in_use flag being updated after
> ringing the doorbell, coupled with a lack of proper memory barriers
> across CPU cores.
> 
> On fast platforms, a race condition occurs: the platform processing
> completes and triggers an interrupt before the local CPU sets
> chan_in_use to true. When the interrupt handler pcc_mbox_irq() runs,
> it reads chan_in_use as false and incorrectly ignores the interrupt.
> 
> This patch fixes the race by:
> 1. Moving the chan_in_use update before ringing the doorbell.
> 2. Using smp_store_release() to ensure the flag update is visible
>    to other cores before subsequent hardware or software actions
>    are triggered.
> 3. Using smp_load_acquire() in the interrupt handler to ensure the
>    latest flag value is read before deciding to skip the interrupt.
>

I don't think we need store_release/load_acquire semantics here. IIUC
we don't need to make all preceding memory updates visible to the IRQ handler.
i.e. seeing the flag updated doesn't require observing all the updates before
the flag itself. This flag is not publishing extra data to be consumed after
the check.

How about something like below ? If you agree and it works, add my
Reviewed-by and post.

Regards,
Sudeep

-->8
mailbox: pcc: Fix command timeout due to missed interrupt

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
Link: https://patch.msgid.link/20260417031429.2509443-1-lihuisong@huawei.com
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/mailbox/pcc.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 6fbc17d41774..bde5e0852157 100644
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

@@ -466,9 +470,18 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
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
-	if (!ret && pchan->plat_irq > 0)
-		pchan->chan_in_use = true;
+	if (ret && pchan->plat_irq > 0)
+		WRITE_ONCE(pchan->chan_in_use, false);

 	return ret;
 }
--
2.43.0

