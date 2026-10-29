Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246079;
	b=46gUXOadX621RkBGs51F97yPxAKynsLr5R6hD7XaB4/sdYNpjWllo1w0TdT9149ameMr
	 n5L2ymKXryVRnqzTOCrkSNPtnW3U2G9CMg0QrRbgmyF2bBE0Ga8TwkFdWZFa6Lr4TFVZ+
	 qjV3HvpVcNYTZIBzI/nxZG32eSyy+vbeMHvPUWtr2hufp4QdcFYKvsVUUEXROHXMtMJg+
	 JQ0SKCv21CrQQRLP6qFoEDCQftBp2kSlgWMMn2HsRR9hgvMRdgk7TzqztGNb4q7jW4qE2
	 Pdn8MdnPXU7IMRY2znKt7WNRrkha3ZXg/RFR0lwghyStBP4oJx0ckQWsRN1tBYDfH3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246079;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=lIae9g6zUSH+1q+S1sfHr4ypk6wH2cztDIz5qjRcM/w=;
	b=O/zTTuT1l9pFYyGUcnzLvnVINtn6ms0gih81S9+NSohYi/HgkfZ2kkJ2BcCDSrz7dS+x
	 Fu8SDL/Hw6FbHi09lq+UrwEwa1tnoAOUwhEo/mjaWT8xV6XEGZYlaNXWxduukLoWQwoej
	 6BZCre+uXC4rb5DlpwnCApbGIAn4HOTF5+85wBbhFChGeIZNRc5IC6vsWnTs9k70v87/4
	 72fSlJCLhwvOMcTswomBUZIYQJNCnVgv+gs8n7L3RxniBRDw/z4fqIqntKf2h1RijVP5u
	 jFGLBdldYBXpaWZSytF+Zna4bFtyWRHRfTMPKd5HrUIebE5xl3tMrIwng+ezrps/cog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Kh5txQsg;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96D606A31A;
	Thu, 29 Oct 2026 03:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB96D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Kh5txQsg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lI
	ae9g6zUSH+1q+S1sfHr4ypk6wH2cztDIz5qjRcM/w=; b=Kh5txQsglmC1/36ksT
	kf5+/X6xELqoJ/vbHx2IpP4oR9DvdGs6m/lGENOliaxI9b5C2bJ5dd0KIr9bC2Js
	k+Jcx1nBXC4vi3m+zItTFr3Nh9V9v+iXXP1Qxv49A6uxheJh8WbbZ0lpnWLYgjCZ
	ntbPOsWtZEuO/TuEQApTidz0k=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S2;
	Thu, 29 Oct 2026 11:52:55 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Anup Patel <anup@brainfault.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Julien Grall <julien.grall@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	Grant Likely <grant.likely@linaro.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Robert Richter <rrichter@cavium.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	Liupu Wang <wangliupu@loongson.cn>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org
Subject: [PATCH v2 00/20] ACPI/irqchip: validate MADT entries before use
Date: Thu, 29 Oct 2026 11:52:31 +0800
Message-Id: <20261029035253.2333852-1-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFyxCryUKrWkWr1fXrWUurg_yoWxJF18pF
	WUua4rtr4xGr4xAwnxAw18ZFy3Jr93JrW7tFZ5ta4fZrWkKF1DXa1IvFyFqF13Jw1fW3Wj
	9F4FgFyxCFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UrrcfUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhpKhGriwxpqzwAA3u

ACPI interrupt-controller setup passes firmware-supplied MADT subtables
to architecture and irqchip callbacks.  The common table walker only
guarantees that a generic subtable header is readable.  A number of
callbacks cast that header to a larger controller-specific structure and
read typed fields before checking that the complete record is present.
Truncated records can therefore cause out-of-bounds reads during early
CPU and interrupt-controller discovery.

This series combines the previously posted generic/irqchip series [1],
the RISC-V series [2], and the remaining MADT callback checks into one
set.  The common irqchip probe path first rejects entries whose declared
range leaves the table.  Each parser then validates the minimum size of
the concrete record before its first typed access.

Testing
=======

The RISC-V cases were tested with qemu-system-riscv64, EDK2 pflash
firmware, a KASAN-enabled kernel, CONFIG_ACPI_TABLE_UPGRADE=y, and an
uncompressed initramfs containing an overriding MADT.  The malformed
table is one page long and ends with a three-byte RINTC entry, while a
complete struct acpi_madt_rintc is 36 bytes.

On an unpatched kernel the override was accepted and setup_smp() faulted
in acpi_parse_rintc() while reading processor->flags four bytes from the
start of the truncated record.  The record starts three bytes before the
end of the mapped page, so that read entered the following unmapped page:

  Unable to handle kernel paging request
  epc : acpi_parse_rintc+0x46/0x206
  cause: 000000000000000d
  Kernel panic - not syncing: Attempted to kill the idle task!

Applying only the old arch/riscv/kernel/acpi.c and
drivers/irqchip/irq-riscv-intc.c checks produced the same fault because
the setup_smp() parser runs first.  With patch 7 moving the existing
BAD_MADT_ENTRY() check before the flags read, plus patches 9 and 20, the
out-of-bounds access disappeared.  The malformed table was rejected and
the kernel later stopped at the existing acpi_init_rintc_map() BUG for a
machine with no valid RINTC entries.  This is the current fail-closed
behavior; it is not an out-of-bounds access.

The LoongArch LPC-PIC case was exercised with an overriding MADT ending
in a three-byte LPC-PIC entry.  Temporary diagnostic instrumentation in
pch_lpc_parse_madt() reported:

  decl_len=3 sizeof=14 beyond_end=11

This confirms the field accesses covered by patch 19 extend eleven bytes
beyond the supplied record.  LoongArch maps this early table directly,
so the read did not itself cause a page fault.

Dynamic test coverage by patch is therefore:

  7       RISC-V RINTC fault reproduced; the early check prevents it.
  9       The malformed RINTC is rejected in acpi_init_rintc_map().
  19      LoongArch LPC-PIC over-read observed with instrumentation.
  20      Included in the complete RINTC fix; the boot stops at the
          existing fail-closed BUG before irqchip probing reaches it.
  1-6,
  8,
  10-18 No dynamic claim.  The required GICv5, AVEC, redirect-int,
          HTVEC, and related controller models are not available in the
          QEMU configurations used for this test.

All twenty patches were checked with scripts/checkpatch.pl and were
applied both individually where independent and as the complete series
to the base commit below.

Changes in v2:
- Combine and supersede the six-patch irqchip series [1], the two-patch
  RISC-V series [2], and the remaining MADT checks.
- Add the RISC-V QEMU/EDK2 truncated-RINTC reproduction and fixed-kernel
  result.
- Retain the setup_smp() RINTC fix: testing showed that the later RISC-V
  checks alone do not prevent the early boot fault.
- Document the LoongArch LPC-PIC instrumentation result and the QEMU
  hardware-model limitations for the other callbacks.
- Rebase on the current tree and keep Fixes and stable trailers on every
  patch.

[1] https://lore.kernel.org/r/20261021144524.364143-1-yaojiale02@163.com
[2] https://lore.kernel.org/r/20261016141249.2791819-1-yaojiale02@163.com

Jiale Yao (20):
  ACPI: irqchip: validate MADT entry bounds before probing
  irqchip/gic-v3-its: validate MADT ITS entries
  irqchip/gic-v3: validate MADT records before use
  irqchip/gic-v5-its: validate MADT translate frames
  irqchip/loongarch-cpu: validate MADT LIO-PIC entries
  irqchip/loongson-eiointc: validate MADT BIO-PIC entries
  riscv: validate RINTC entries before use
  ACPI: riscv: validate interrupt controller MADT entries
  riscv: acpi: validate RINTC entries before use
  irqchip/gic-v5-irs: validate MADT GICC entries
  irqchip/gic-v5-irs: validate MADT IRS entries
  irqchip/gic-v5: validate MADT IRS records
  irqchip/gic: validate MADT distributor records
  irqchip/loongarch-avec: validate MADT MSI-PIC entries
  irqchip/loongarch-ir: validate MADT MSI-PIC entries
  irqchip/loongson-htvec: validate MADT BIO-PIC entries
  irqchip/loongson-htvec: validate MADT MSI-PIC entries
  irqchip/loongson-liointc: validate MADT HT-PIC entries
  irqchip/loongson-pch-pic: validate MADT LPC-PIC entries
  irqchip/riscv-intc: validate MADT RINTC entries

 arch/riscv/kernel/acpi.c               |  3 +++
 arch/riscv/kernel/smpboot.c            |  6 +++---
 drivers/acpi/riscv/irq.c               |  6 ++++++
 drivers/acpi/scan.c                    |  7 +++++++
 drivers/irqchip/irq-gic-v3-its.c       |  3 +++
 drivers/irqchip/irq-gic-v3.c           | 15 +++++++++++++++
 drivers/irqchip/irq-gic-v5-irs.c       |  6 ++++++
 drivers/irqchip/irq-gic-v5-its.c       |  3 +++
 drivers/irqchip/irq-gic-v5.c           |  3 +++
 drivers/irqchip/irq-gic.c              |  3 +++
 drivers/irqchip/irq-loongarch-avec.c   |  3 +++
 drivers/irqchip/irq-loongarch-cpu.c    |  3 +++
 drivers/irqchip/irq-loongarch-ir.c     |  3 +++
 drivers/irqchip/irq-loongson-eiointc.c | 10 ++++++++--
 drivers/irqchip/irq-loongson-htvec.c   |  6 ++++++
 drivers/irqchip/irq-loongson-liointc.c |  3 +++
 drivers/irqchip/irq-loongson-pch-pic.c |  3 +++
 drivers/irqchip/irq-riscv-intc.c       |  5 ++++-
 18 files changed, 85 insertions(+), 6 deletions(-)

base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
-- 
2.34.1

