Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4B37F002;
	Fri, 16 Oct 2026 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160143; cv=none; b=sGf3QvL+e+6dfDHjxPsaqvDmdr/JqbqtdeXYOptmJQ8I9x1Sgpf9i/UpdrtpFpk91/V52EHJtf+q6LX0C+5Ff7XVe/9L8oxUBmwri1pI85wGZnVUbZkngF3SICVbD4pqDAE6iKM3iZ1Q/a3kigRQJ7dc6WhcYOLzeUrIyxCv+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160143; c=relaxed/simple;
	bh=nKnDUu92x5eggGrhdzEzUVYb3s56rgO2PPXeJTTObFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZX/4ZwHYk96j/SaEQ/6++x7pAypdRIWZKZdh9KJHhxnR+rwBdJ1PwAb/4zuKjPOAu6mmoycKYXB31Y8CPDqsQsMMRbM6Lw1E/StYnqSIaT2vGqRIWkSfWHWi4+iinT8OBa9uXOCKcfJUnmF02XIEWH9ZblrJmG7O2LFvG8yDsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eLKMiUR+; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eLKMiUR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3a
	O3he/ck1f9a/54WH1E/2DGTL2mByRYGGeMQm/SoeE=; b=eLKMiUR+EDbxnCuZOh
	fqm/dsSw9/HI8XowupzpY+q9yUWbphQROmdg6d00O6oLxTjBuM2tRmJhkXp08uGp
	MODb8CH9mT2nhe8NZ+lri0xjHCFvdeGvKaCy98PG7vq5bQs/BG3vELrInxvRv4ZO
	iA2Lcd9Sz5YZPY/zUMZX5A0Yc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnP8WEMdJqohssAg--.59795S2;
	Fri, 16 Oct 2026 22:15:32 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] mailbox: pcc: validate PCCT subspaces before parsing
Date: Fri, 16 Oct 2026 22:15:30 +0800
Message-Id: <20261016141530.2795073-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnP8WEMdJqohssAg--.59795S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr18Cry3Jr4kGFW3Kw4Uurg_yoWrXrWxpF
	4jva98KrW3Ja13Wr12vws5AF45A3yI9a4UtF43K3sagw43KFy5WFW0k3429r95AFZ2gF12
	v3W7tF4UCF4vyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUeCJ9UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AW89mrSMYWyewAA36

The PCC mailbox probe walks PCCT entries by their declared lengths
without checking that each entry is contained in the table. It also
passes generic headers to type-specific parsers without establishing the
required record size. Malformed firmware can therefore move the cursor
outside the PCCT or cause out-of-bounds field reads.

Validate the table header, each subspace range, and the minimum size for
supported subspace types during both the counting and probe passes.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/mailbox/pcc.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 9888dab64639..37b2ddb44bda 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -553,6 +553,42 @@ static const struct mbox_chan_ops pcc_chan_ops = {
 	.last_tx_done = pcc_last_tx_done,
 };
 
+static bool pcc_subspace_is_valid(struct acpi_subtable_header *entry,
+				  unsigned long end)
+{
+	unsigned long start = (unsigned long)entry;
+	size_t length, min_length;
+
+	if (start >= end || end - start < sizeof(*entry))
+		return false;
+
+	length = entry->length;
+	if (length < sizeof(*entry) || length > end - start)
+		return false;
+
+	switch (entry->type) {
+	case ACPI_PCCT_TYPE_GENERIC_SUBSPACE:
+		min_length = sizeof(struct acpi_pcct_subspace);
+		break;
+	case ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE:
+		min_length = sizeof(struct acpi_pcct_hw_reduced);
+		break;
+	case ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2:
+		min_length = sizeof(struct acpi_pcct_hw_reduced_type2);
+		break;
+	case ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE:
+		min_length = sizeof(struct acpi_pcct_ext_pcc_master);
+		break;
+	case ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE:
+		min_length = sizeof(struct acpi_pcct_ext_pcc_slave);
+		break;
+	default:
+		return false;
+	}
+
+	return length >= min_length;
+}
+
 /**
  * parse_pcc_subspace - Count PCC subspaces defined
  * @header: Pointer to the ACPI subtable header under the PCCT.
@@ -568,6 +604,9 @@ static int parse_pcc_subspace(union acpi_subtable_headers *header,
 {
 	struct acpi_pcct_subspace *ss = (struct acpi_pcct_subspace *) header;
 
+	if (!pcc_subspace_is_valid(&ss->header, end))
+		return -EINVAL;
+
 	if (ss->header.type < ACPI_PCCT_TYPE_RESERVED)
 		return 0;
 
@@ -812,6 +851,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	struct acpi_table_header *pcct_tbl;
 	struct acpi_subtable_header *pcct_entry;
 	struct acpi_table_pcct *acpi_pcct_tbl;
+	unsigned long table_end;
 	acpi_status status = AE_OK;
 	int i, rc, count = pcc_chan_count;
 
@@ -821,6 +861,13 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	if (ACPI_FAILURE(status) || !pcct_tbl)
 		return -ENODEV;
 
+	acpi_pcct_tbl = (struct acpi_table_pcct *)pcct_tbl;
+	if (pcct_tbl->length < sizeof(*acpi_pcct_tbl)) {
+		rc = -EINVAL;
+		goto err;
+	}
+	table_end = (unsigned long)pcct_tbl + pcct_tbl->length;
+
 	pcc_mbox_channels = devm_kcalloc(dev, count, sizeof(*pcc_mbox_channels),
 					 GFP_KERNEL);
 	if (!pcc_mbox_channels) {
@@ -844,7 +891,6 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	pcct_entry = (struct acpi_subtable_header *) (
 		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
 
-	acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
 	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL) {
 		pcc_mbox_ctrl->txdone_irq = true;
 		pcc_mbox_ctrl->txdone_poll = false;
@@ -856,6 +902,11 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	for (i = 0; i < count; i++) {
 		struct pcc_chan_info *pchan = chan_info + i;
 
+		if (!pcc_subspace_is_valid(pcct_entry, table_end)) {
+			rc = -EINVAL;
+			goto err;
+		}
+
 		pcc_mbox_channels[i].con_priv = pchan;
 		pchan->chan.mchan = &pcc_mbox_channels[i];
 
-- 
2.34.1

