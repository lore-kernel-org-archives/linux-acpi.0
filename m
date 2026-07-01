Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB355349CFE;
	Wed,  1 Jul 2026 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916745; cv=none; b=XwVpeT+Lrk69gTFgfPI4Cg5WsfptE2XDUQhqzzYXPH04mvKte8V/v9dpDjc50MuamCiDK98duaCF3Pfv4cU+qND4Z+y5+xi+DpkOan4gBQZO2cRcim3UYf3Au5/zGdPNZYVNHmUt0U4elJiDmpdgBEhFV3UJZjREBjj+RB8i5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916745; c=relaxed/simple;
	bh=yHiaP8Hl7HMMHw5FJt39Cs+fGQoLSNKrEf/oEEWe/eY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BmwZirFwg10AjPSQyrfVSfpb5L4j2qU69RNsr7wVkmlapjipX0imKVnmj8qZ2cg/OfhuwRYZT2HVP9JSE1H+zA/e3M9ZDyJv3CcDH1mRWbtttIw8+K5AUwPaZQvlwwxy9PKvO66t3TAhBfH2N+vo9aijffAwSeh9n9O+EuifkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoK3yVLq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoK3yVLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8C21F000E9;
	Wed,  1 Jul 2026 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916743;
	bh=Y5GPSe78Q5PjJXi20U4VevdrhXl/hoPlY9EOq/pY7EM=;
	h=From:Subject:Date:To:Cc;
	b=MoK3yVLq+W15I4AOMyVYLmpF3ez/cN2lMqWlA3YC9V1xpyXintrTQ4nZzRkhLrmK5
	 /V2BK8e7lPybPgHgjEaf46MYajsbqKQ5Ld8A1hEyPuxFXosjznffJIij8Bpi8dSBYd
	 iOmjOLUAad+5MkdhxSwA9TID/bI+9trjJmUg691hggyijAeRG14JhCiOr7HXPMNDcB
	 5m4qSqP4dg1O8zd2IPObW8yETeTzNy235L877ikXVf3rMGMd9lFXDzuOtX8GaLpR/D
	 bsoNIarfZoS0tLhNbeYAu462hl3i+P1qqsfd/lMiHLTlHsUOVuFRHCW3qSLKrD2yYU
	 rZuQjZ6qigeUA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v3 0/7] irqchip/ACPI: Arm GICv5 IWB ACPI IRQ probe deferral
Date: Wed, 01 Jul 2026 16:38:48 +0200
Message-Id: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-0-c5562cf0fe29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgmRWoC/4WOy27CMBBFfwV5zVSOHZuEVf+jYuFxJmEKSqIxG
 CqUf28ei6orlke6Oue+VCJhSuq4eymhzImHfga736l4Dn1HwM3MymjjdWkO0HGE7CDEkYEfCKM
 MSNBQSyLhCrGJVVljESpXqlkyCrX8XANfp43THb8p3hbrsjhzug3ysz7IxbLbYk67d7FcgAa0B
 6xcXVfWm88LSU/Xj0E6tdSy+fN5bd/6zOwztm1D4dET4j/fNE2/o0MnEy8BAAA=
X-Change-ID: 20260427-gic-v5-acpi-iwb-probe-deferral-cdc849b1a854
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>
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
Changes in v3:
- Added stub to clear ACPI device dependencies
- Added review tags
- Rebased against v7.2-rc1
- Link to v2: https://patch.msgid.link/20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org

Changes in v2:
- Split the patchset in several logic units according to review
- Link to v1: https://patch.msgid.link/20260505-gic-v5-acpi-iwb-probe-deferral-v1-0-b37b85998362@kernel.org

To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
To: Anup Patel <anup@brainfault.org>
To: Hanjun Guo <guohanjun@huawei.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: loongarch@lists.linux.dev

---
Lorenzo Pieralisi (7):
      ACPI: Add acpi_device_clear_dep() helper function
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
 drivers/irqchip/irq-gic-v5-iwb.c    |   2 +
 drivers/irqchip/irq-gic-v5.c        |  13 ++-
 drivers/irqchip/irq-gic.c           |   2 +-
 drivers/irqchip/irq-loongarch-cpu.c |   2 +-
 drivers/irqchip/irq-riscv-intc.c    |   3 +-
 include/linux/acpi.h                |  13 ++-
 include/linux/acpi_iort.h           |   3 +-
 13 files changed, 223 insertions(+), 154 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260427-gic-v5-acpi-iwb-probe-deferral-cdc849b1a854

Best regards,
--  
Lorenzo Pieralisi <lpieralisi@kernel.org>

