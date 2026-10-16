Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D6E4E06D4;
	Fri, 16 Oct 2026 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160052; cv=none; b=dIOROGAKRwpjLttjyNeg2OahM4mTlhz3k10qOgOM1RJhV/7YTeRKjxX8uaJnYopQrDnzuj64PWL4cu3OuSZnJTXkhjYj0QQHoUnZw0mPEjEYD9d+pOfjcTSj1YSXOI/2u2v6yGN2TWwGbpVHGEaMtjiSl1XtqQjeKXW46aDy6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160052; c=relaxed/simple;
	bh=rxcp0R9SD4DFiFD7qKNDkK8BruAIpsl4pNkX3bK3ta4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=no4W3ZCtjiKHJCboC4u2uQoYC7KrHxoHjgISSIAFJ4j7Sf+b03r9Xu/0RcxL0vxUgBeRJIQjaRA9OQE36U5Vdq4pSoixMi7AFuejuT9h/yCnD+3IDYVyBhRc1FzxxfwDiMjpPZJFRg8xABUWIM3A1L7JeMqIsHBeu8Vse0OqQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R9HnGyn2; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R9HnGyn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5G
	GZU1GhM7HtjYZNTj6Fd8UyFQ8wgw6K7NpuKS0+tBM=; b=R9HnGyn2OJYkxqhUwN
	RRmNQaImcNFNkCi4GNFSe3cfI2Izku6htxrZYsYPSapmEFHEITvqZvTYsDFG8rLT
	XlgGskjrYBgYdm5LRtifLsAtCV3T6HYT84O1/8dqCubBBsvbGKzbqGx4XnR4eK4D
	1bmj0JmDkvXTBhUvEuLXlRdXo=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCX5Hj5MNJqeorFAA--.36405S4;
	Fri, 16 Oct 2026 22:13:18 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 2/2] ACPI: riscv: validate interrupt controller MADT entries
Date: Fri, 16 Oct 2026 22:12:48 +0800
Message-Id: <20261016141249.2791819-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016141249.2791819-1-yaojiale02@163.com>
References: <20261016141249.2791819-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCX5Hj5MNJqeorFAA--.36405S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF15Ww17Zr1kZw17ZryrWFg_yoW8GFWxpa
	yUKw4Yyr45tr4fWw1UKr15XFW3W3y5GFsIqFWUua4IqrsrKFWYqFZYqF1a9r95Ja1vgw4a
	9r4ktFy5uFW8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRha93UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8B6a1GrSMP6n-QAA3M

The PLIC and APLIC MADT callbacks cast generic subtable headers to
fixed-size records before checking that the complete records are
present. Truncated firmware entries can therefore cause out-of-bounds
field reads.

Reject entries that do not contain the complete controller-specific
structure before registering an interrupt controller.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/acpi/riscv/irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index da2c42e0ebfd..1f6fee5c5746 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -220,6 +220,9 @@ static int __init riscv_acpi_aplic_parse_madt(union acpi_subtable_headers *heade
 {
 	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
 
+	if (BAD_MADT_ENTRY(aplic, end))
+		return -EINVAL;
+
 	return riscv_acpi_register_ext_intc(aplic->gsi_base, aplic->num_sources, aplic->num_idcs,
 					    aplic->id, ACPI_RISCV_IRQCHIP_APLIC);
 }
@@ -229,6 +232,9 @@ static int __init riscv_acpi_plic_parse_madt(union acpi_subtable_headers *header
 {
 	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
 
+	if (BAD_MADT_ENTRY(plic, end))
+		return -EINVAL;
+
 	return riscv_acpi_register_ext_intc(plic->gsi_base, plic->num_irqs, 0,
 					    plic->id, ACPI_RISCV_IRQCHIP_PLIC);
 }
-- 
2.34.1

