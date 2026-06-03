Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA1399031;
	Wed,  3 Jun 2026 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474892; cv=none; b=CwTpGVUhBVl8MdDhTOMYwUYjLqNSb7qh1Qpheo173fNLcSsHY1q+E2V8+MkdXnBsZdk1d1GmgW62gEOuM0+FcukgSYj2kfKYjb48Rg2ypNoYlahebI2Ji/38CBFv9HFqgFFrGqxDbciFv9BHVyNkHD6q4tAjUoRQf2FTvBElymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474892; c=relaxed/simple;
	bh=XhRtdiyd040yUK8FqiEBDtVTp8aXqvJE+fpUDChkCcQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D08QdkSy5CYRQxIhotZ4bPiIRz5Wr6Qaa4nTZAHykym8/GORT7E2eaONNf/qvIkDzy2o1HVDIaPzajAV9SZ8JZHeHK9ldtdgQNJG39574bmloItoFEg/U24Efn8hjX2+qyaE7lpqWOogygxC/rob1cBTmyKz6j74/TEpJvN9TOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHpJpaiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHpJpaiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F78D1F00893;
	Wed,  3 Jun 2026 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474891;
	bh=roqByI0ANZaxZ2rldGt9p/o5LQVsge3W6W4aPEvMzNI=;
	h=From:Subject:Date:To:Cc;
	b=nHpJpaiXA8Jdl1wSU0NSaD4Ku591j9xRmKXRBCzPKXzbx8TVUP6iTkbVe/Z1CSxhs
	 nIYwaXfPbxWHRSQPrsq1qcHSzR+fv79cQI0FDMiSoqjm0ituzsptvJ0OyZwwmc1m+G
	 mm2aGRjbJJVxtSoY0ibiC/tLDtD6kAWmw6rP6WE74r/fCokS45ESO3ygnDVOUES0aE
	 xk+pPxDJr5IjLLtB1h9U8KNBa4TVZh7uqf0+FLfKJ81GRXSHZjLHIfLneFTDBB+NbZ
	 Ge/ovSUZ7TyfNaSRb8LmTMCsL1MnirYZ0essElbcZGIJakcsmGdyc+OPaCQoPm+Lvc
	 4Wq5WDBdEF25Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v2 0/6] irqchip/ACPI: Arm GICv5 IWB ACPI IRQ probe deferral
Date: Wed, 03 Jun 2026 10:20:56 +0200
Message-Id: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjjH2oC/4WOyw6CMBBFf4V07RgolIcr/8OwaMsAo4aSKVYN4
 d/l8QEuT3Jyz52FRyb04hLNgjGQJzesIE+RsL0eOgRqVhYylnmcyQI6shAUaDsS0NvAyM4gNNg
 is36CbWyZVSbRpcrEOjIytvTZA7f6YP8yd7TTtroZPfnJ8Xd/EJLNO2IqVv9iIYEYTFqYUlVVm
 eby+kAe8Hl23Il6WZYf10ma498AAAA=
X-Change-ID: 20260427-gic-v5-acpi-iwb-probe-deferral-cdc849b1a854
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15.2

On Arm GICv5 systems, the IWB (Interrupt Wire Bridge) handles wired interrupts
and it is in charge of translating interrupt wires to GICv5 ITS messages.

In ACPI systems, an IWB is backed by a platform device. Device drivers for
devices whose IRQs are routed to an IWB might probe earlier than the IWB device
driver, which can result in failures in that until the IWB driver is probed and
its IRQ domain is duly registered, IRQs routed to it cannot be resolved.

Some interrupt controllers for the RISC-V architecture suffer from the same
issue; RISC-V, in its ACPI IRQ layer solved the problem by automatically
creating device dependencies that result in the interrupt controllers drivers
being probed before any device driver whose devices IRQs are routed to them is
probed.

Instead of reinventing the wheel, this series move the aforementioned RISC-V
code to generic ACPI IRQ handling code (while fixing some bits and pieces) and
implement GICv5 IWB ACPI probe deferral on top of it.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
Changes in v2:
- Split the patchset in several logic units according to review
- Link to v1: https://patch.msgid.link/20260505-gic-v5-acpi-iwb-probe-deferral-v1-0-b37b85998362@kernel.org

---
Lorenzo Pieralisi (6):
      ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop termination
      ACPI: RISC-V: Check acpi_get_handle() status in riscv_acpi_add_prt_dep()
      ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop handling
      ACPI: irq: Move RISC-V interrupt controllers autodep to ACPI IRQ code
      ACPI/IORT: Implement ACPI infrastructure to enable GICv5 IWB probe deferral
      irqchip/gic-v5: Enable GICv5 IWB ACPI probe ordering detection

 arch/riscv/include/asm/acpi.h       |   1 +
 drivers/acpi/arm64/iort.c           |  22 ++++-
 drivers/acpi/irq.c                  | 172 +++++++++++++++++++++++++++++++++++-
 drivers/acpi/riscv/irq.c            | 141 +----------------------------
 drivers/acpi/scan.c                 |   1 +
 drivers/irqchip/irq-gic-v3.c        |   2 +-
 drivers/irqchip/irq-gic-v5-iwb.c    |   5 ++
 drivers/irqchip/irq-gic-v5.c        |  13 ++-
 drivers/irqchip/irq-gic.c           |   2 +-
 drivers/irqchip/irq-loongarch-cpu.c |   2 +-
 drivers/irqchip/irq-riscv-intc.c    |   3 +-
 include/linux/acpi.h                |   5 +-
 include/linux/acpi_iort.h           |   3 +-
 13 files changed, 218 insertions(+), 154 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260427-gic-v5-acpi-iwb-probe-deferral-cdc849b1a854

Best regards,
--  
Lorenzo Pieralisi <lpieralisi@kernel.org>

