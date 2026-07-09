Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA83F411D;
	Thu,  9 Jul 2026 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597284; cv=none; b=q/+iRtxg2L7CBOZcwgq2X2hh75I98vPX+O2wQ9cdI8sbJbcPH9qUEL+SxLm6ji5kj819GfsSkQ8nSa+zwiz25V/D6SUco00AUlSFksOjPpAPrxCxhV8GIsfjQJelLmwN/uoDKm6UJM2uL6vjQ4R+nNN7q2Wjq4pP5kKrWgQYAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597284; c=relaxed/simple;
	bh=DVOBA94maD0J/ufvobNiNGGqhWrGkbjwD9xVqU9dih4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h9xQt2EXO1uT6bF8E6fXb1aPkOGE2AW4J73aQgPRvUD4nbA5nGfLmYxAHpccdsxNPclM+xEPfZ6j8juha80Pdi4XhHfZRSfugNyOfu29zGfYrbnYUb7NdJ/w8d8Oyvoqo3b83Pb4Gta9ThD8TuYITLO4A8xhdlNBji0/1P8Cqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=PTa0MlDS; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="PTa0MlDS"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bTGyrNL7ip9oalKBbaTMNxbZuutSUqoVRBVAda3sGxQ=;
	b=PTa0MlDSMyKGx0u8nx4vdVrVc9OE4CFn6LLn9Q+LNFzCzMjzTNnDoprj/DojeqdoLvByMEpHF
	wKM7cykYSl2ZKNIpEXMgllIDVoT3e8vx1f4AskhSFWccGx7SYhKiXqJ3ke3Jft8iwj7MwmPPddx
	Bi2J6fAXj7d5f+MMjU8iWMM=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gwt8z1fnCz1cyPZ;
	Thu,  9 Jul 2026 19:32:03 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E7D540586;
	Thu,  9 Jul 2026 19:41:16 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 19:41:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <sudeep.holla@kernel.org>, <jassisinghbrar@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v2] mailbox: pcc: Fix command timeout due to missed interrupt
Date: Thu, 9 Jul 2026 19:41:15 +0800
Message-ID: <20260709114115.3113315-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100005.china.huawei.com (7.202.195.212)

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
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Huisong Li <lihuisong@huawei.com>
Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
---
v1->v2:
 - Use WRITE/READ_ONCLE to replace smp_load_acquire/smp_store_release

v1: https://patch.msgid.link/20260417031429.2509443-1-lihuisong@huawei.com
---
 drivers/mailbox/pcc.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 636879ae1db7..3689706ce419 100644
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
 
@@ -438,9 +442,18 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
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
2.33.0

