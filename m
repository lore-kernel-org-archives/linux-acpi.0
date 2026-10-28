Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202530;
	b=MFpHGPoOr29x/oQL3XE+pgLE4HQhPw3f15TvaxwFN/JrGf4QsEC5+kagmHjFfCwbCFKK
	 q5RUI8Ryqq1z5Ydyqr6t3GxSxZtpQzl21YTHN6BErZPco+NDHAgMjBaYxwDGqGVpg3Bjg
	 yVoghEx35CXfsudptdQyKT3upwk9ZQQBwIjuPx0201l0C6YIJpOaNfojM8XMOZBPJi3mp
	 jCFND2jhVDOqIuFGzoGQ7s2GseXH4okL6RbGBEpmeXU3804OU4ZtYXx4PeUta03i/RF4h
	 y1qdmwzZGMTSXcNNME5w4/sd1mPflPESQK7Ehjp2NJbTIApkAIRxtSq7zSORRzJlj6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eRgpmD7iw9ZEu6haYupaH8oCiIl9sAcEeSCI7eZ9LnA=;
	b=Hqg5X3kEjiSLgLASvfa6pnd8pZxMdhNl7zx584Dm1KlM6d5Orw1l42L99CsjANYNJOoq
	 o8gnmdA3pmYbXwIJqTzB5Af0mNZdsnCbOdZJnz2MPnS02Znd8Xaxl3CAXtruCE+fDzpZO
	 rr96i25/vw4naXE+10PxbpoBnfB9YAz87f0/VoYJL0KMR0mpQmxqFtWGtLOoct7RjKJns
	 VI43ip+yRMUwwmzSnGUkm9hIDSZfWIbJWF+xunNw19wVbO7cgZd2Qwt0junCJqWt1UFsA
	 WIfrm/qk0IGav70H3HdO105FD/1TpJrRdwWz/YAYJm9++XzTApNUovIGCEuAzd0ggGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDbUNs0+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2D606A333;
	Wed, 28 Oct 2026 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDbUNs0+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142E01F01828;
	Wed, 28 Oct 2026 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202530;
	bh=eRgpmD7iw9ZEu6haYupaH8oCiIl9sAcEeSCI7eZ9LnA=;
	h=From:To:Cc:Subject:Date;
	b=oDbUNs0+7qn9M4nngcFORGhBNHcDJXtW60DY94r8SW75XZBGGBQa8s0svMaAiXS0s
	 /oIQV49Tx/AnZlTmLcy2/4DjZR5MLLLgWbHxGTavvgck+ge4tj9M0SwHT6eT6eWDiB
	 KqGet74ehfdZrY0ug1zMV4JpXGS8R6sXzMfLXfvrS0hAsMSpjvUvHN5EQaJc//DfD/
	 +ndJXfOIBb2DTlIYURdB7Ze9aCqCkxp4K3nJVTMt7JAdpwD9gPqlFcNb1Iwmz/XWjZ
	 NF/K5UKvKu/PPPhpgm+lNPzT/sGm9FqR8lELzSkG7FCi5Zel4SWtNH2ea/esZz2K61
	 MpwI54t6YVqLA==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] mailbox: pcc: Release probe resources on failure
Date: Wed, 28 Oct 2026 15:48:41 +0000
Message-ID: <20261028154841.3315321-1-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCC probe maps register addresses and registers platform GSIs as it
initializes subspaces. When a later step fails, the error path only
releases the PCCT reference, leaving those mappings and GSIs behind.

Record each registered GSI and unwind all resources acquired for every
started subspace, including the partially initialized one.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-d17640d2-d890-497b-9888-783c8b23208e
Fixes: 800cda7b63f2 ("mailbox: pcc: Add PCC register bundle and associated accessor functions")
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/mailbox/pcc.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 14dc4a187bfc..18925cbf472d 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -90,6 +90,7 @@ struct pcc_chan_reg {
  * @cmd_update: PCC register bundle for the command complete update register
  * @error: PCC register bundle for the error status register
  * @plat_irq: platform interrupt
+ * @plat_gsi: ACPI GSI registered for the platform interrupt
  * @type: PCC subspace type
  * @plat_irq_flags: platform interrupt flags
  * @chan_in_use: lockless flag used by type 3 initiator subspaces to filter
@@ -106,6 +107,7 @@ struct pcc_chan_info {
 	struct pcc_chan_reg cmd_update;
 	struct pcc_chan_reg error;
 	int plat_irq;
+	u32 plat_gsi;
 	u8 type;
 	unsigned int plat_irq_flags;
 	bool chan_in_use;
@@ -606,6 +608,22 @@ pcc_chan_reg_init(struct pcc_chan_reg *reg, struct acpi_generic_address *gas,
 	return 0;
 }
 
+static void pcc_release_subspace(struct pcc_chan_info *pchan)
+{
+	if (pchan->error.vaddr)
+		iounmap(pchan->error.vaddr);
+	if (pchan->cmd_update.vaddr)
+		iounmap(pchan->cmd_update.vaddr);
+	if (pchan->cmd_complete.vaddr)
+		iounmap(pchan->cmd_complete.vaddr);
+	if (pchan->db.vaddr)
+		iounmap(pchan->db.vaddr);
+	if (pchan->plat_irq_ack.vaddr)
+		iounmap(pchan->plat_irq_ack.vaddr);
+	if (pchan->plat_irq > 0)
+		acpi_unregister_gsi(pchan->plat_gsi);
+}
+
 /**
  * pcc_parse_subspace_irq - Parse the PCC IRQ and PCC ACK register
  *
@@ -636,6 +654,7 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 		       pcct_ss->platform_interrupt);
 		return -EINVAL;
 	}
+	pchan->plat_gsi = pcct_ss->platform_interrupt;
 	pchan->plat_irq_flags = pcct_ss->flags;
 
 	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
@@ -820,7 +839,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	struct acpi_subtable_header *pcct_entry;
 	struct acpi_table_pcct *acpi_pcct_tbl;
 	acpi_status status = AE_OK;
-	int i, rc, count = pcc_chan_count;
+	int idx = 0, rc, count = pcc_chan_count;
 
 	/* Search for PCCT */
 	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
@@ -860,11 +879,12 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 		pcc_mbox_ctrl->txdone_poll = true;
 	}
 
-	for (i = 0; i < count; i++) {
-		struct pcc_chan_info *pchan = chan_info + i;
+	while (idx < count) {
+		struct pcc_chan_info *pchan = chan_info + idx;
+		struct mbox_chan *chan = &pcc_mbox_channels[idx++];
 
-		pcc_mbox_channels[i].con_priv = pchan;
-		pchan->chan.mchan = &pcc_mbox_channels[i];
+		chan->con_priv = pchan;
+		pchan->chan.mchan = chan;
 
 		if (pcct_entry->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE &&
 		    !pcc_mbox_ctrl->txdone_irq) {
@@ -904,6 +924,8 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	else
 		return 0;
 err:
+	while (idx > 0)
+		pcc_release_subspace(&chan_info[--idx]);
 	acpi_put_table(pcct_tbl);
 	return rc;
 }
-- 
2.43.0

