Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593978;
	b=mJzySO36KCgpmxW91zH6FvrTwcYu02kYdOh9PZrQ8XLA6CcmuPgAgJQP0cXyZIMjAHFN
	 MwscsAF8HQ1mEqGrabKxGCHsi2tJYJwyw3+UekTrCU9BUODfblmKLUdavarlPFV+ouZL6
	 3pHD7EiaDrNVNMMXf7yt8WhcOZaoiRfS4ouC2Gy6NqxosShTVYHRBBq7MFmDJIImx4Db/
	 6VHuFY+70IZLyEON8rgjR2yjKeBnt4eUnIcgcNEzvLAg1r6NN42IJxnhMt0Jg79pTQ4XR
	 ga1HAHwgHw+3Scyt4fi4PJ7XB2STIZjO5otKlUY5rrbunQsUljN3D2ybEyIHDUmuYvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593978;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=MatOHa22WtG+l0uamrIjaG0NC2JllSJQL/SZcG1SYnk=;
	b=Msk8prsDJHYSXWDMZwWFzVcgIuXA3jBzske3sWhqKRaznNWh3ssPRBrQj6M+mFYvjLro
	 9UMRvT4SAMwQ3VVYmUgafjy6aaJI/vx4oA/Dv99hd3/RD/JpPj1cC0ffWfxeacAZnHLJW
	 ptBkgtmV3Dd1ZaDKs71s+41Mt2JTT04mDFhM4XoH3Tjg6AWv2njHV60TNPMXT2Dpr2tex
	 eILZ96aiMvFnhtQgx0tj4duZsQW8ijhvjDISV5vRKfVbicF86HZ7YeVzWyWkk2ElfXFnB
	 /WqYhmk7mK+G+t1GkIZlqbP8m1PjdUVkwjm3l6b9spgtnYzPsBriY/Ly2ilmgGNSSkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=C7dnPns2;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0995606A323;
	Wed, 21 Oct 2026 14:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0995606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=C7dnPns2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ma
	tOHa22WtG+l0uamrIjaG0NC2JllSJQL/SZcG1SYnk=; b=C7dnPns2P32vgzywFe
	bpTQKcDN75V5x/VBveIBCSruYf8OzOrgR262scCIwAvYaqs+0+tdTr8ohNNM3Av4
	07sh41SFyfhUji91XZ6dAxI93JFYQUxVLj69+zwqs1ioP/IS//+UZWolm3OKG+f1
	W2uMr0gGy7vTtktpeCdobykE4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3998G0NhqjItXBw--.10228S2;
	Wed, 21 Oct 2026 22:45:27 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Julien Grall <julien.grall@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org
Subject: [PATCH v2 0/6] irqchip: validate ACPI MADT entries before use
Date: Wed, 21 Oct 2026 22:45:18 +0800
Message-Id: <20261021144524.364143-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3998G0NhqjItXBw--.10228S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15XFWUXr1UtF18uFW7Jwb_yoW8CrWxpF
	W5KayYvr4fGrW7Arn3Aw4UXFy5Ja95JrW7tFWfta45ur1rK3WDXay2yFWYqF13Ar13G3ZF
	9r4jqF1xuFZ8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeLvNUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQcGQGrY0Aci1gAA3d

IRQ chip ACPI probing receives MADT records supplied by firmware. The
common probe path does not currently verify that the complete declared
entry is contained in the table, and several callbacks access fixed-size
or version-dependent records without checking their minimum size.
Malformed entries can therefore cause out-of-bounds reads during early
boot.

Add the common declared-range check first, then validate the concrete ITS,
GIC, LIO-PIC, and BIO-PIC records in their respective callbacks. Each patch
remains independently buildable and limits its changes to one parser
implementation.

The series was checked with scripts/checkpatch.pl. Each patch was also
checked individually and in series for application to the base commit
below.

Jiale Yao (6):
  ACPI: irqchip: validate MADT entry bounds before probing
  irqchip/gic-v3-its: validate MADT ITS entries
  irqchip/gic-v3: validate MADT records before use
  irqchip/gic-v5-its: validate MADT translate frames
  irqchip/loongarch-cpu: validate MADT LIO-PIC entries
  irqchip/loongson-eiointc: validate MADT BIO-PIC entries

---
Changes in v2:
- Use BAD_MADT_GICC_ENTRY() for version-dependent GICC records.
- Replace the open-coded distributor size check with BAD_MADT_ENTRY().
- Remove the redundant distributor check from gic_acpi_init().
- Add Fixes and Cc: stable@vger.kernel.org trailers.
- Rebase the series on the current tree.

 drivers/acpi/scan.c                    |  7 +++++++
 drivers/irqchip/irq-gic-v3-its.c       |  3 +++
 drivers/irqchip/irq-gic-v3.c           | 15 +++++++++++++++
 drivers/irqchip/irq-gic-v5-its.c       |  3 +++
 drivers/irqchip/irq-loongarch-cpu.c    |  3 +++
 drivers/irqchip/irq-loongson-eiointc.c | 10 ++++++++--
 6 files changed, 39 insertions(+), 2 deletions(-)


base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.34.1

