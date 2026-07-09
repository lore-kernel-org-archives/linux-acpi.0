Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5D3F8705;
	Thu,  9 Jul 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586474; cv=none; b=tAVCT0jb1UTKltx/xFj2gswNIBR8F+DOqril7FfWrCH3CM0tGnkmy44BDlbIK61YBgMwqQVUzLkrCnfSn/9Mlr7NdYUcfx+LV2yH8fvGmVVY8zCPhrHmM0mJl71pZnzi+ynO++cjcFnxZGXEhuYOAmUq5BgSSHP4M7iOkK9FQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586474; c=relaxed/simple;
	bh=3hDsoBZkjo4pr4F43GJKc0fqYV4voq1DnKXaZdhJ+kk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iurMH9eOMAbepys8/osbLeC7OFpC+aKvPmOcqAZ9rVm9Cfj3JnEGq3qHfGWE0UDRkqtD/gUypE4Td1bjkxbeG757MdTIE6gUe0iQHk3+6kUFnAMOfTcg2WkeXJWqWDC1Gjl+lmbzhZnq3eUckXWQKgpMpZvmc4REgjHzrCU5QXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TF+sRJn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TF+sRJn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D089B1F000E9;
	Thu,  9 Jul 2026 08:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586462;
	bh=D4umqGeoeFLr6ftk+dGLX5Hz/2l8UNfoWaVJnZJbcDk=;
	h=From:Subject:Date:To:Cc;
	b=TF+sRJn9wetWvMfU0qANWtkHuUr6cJTyk9itf1gBHkAh32EYt1HTY2pL0rxdNrjzV
	 3fs6VMBOFuLWXmxOcWpiJRRwukZuLhSzgntG1d2zMAsmYnNIvcAGXnLFvHxYFReGvK
	 LIzak11bgPIsrJAsh6Azp8TIiGVrWLyBwDgmcHC809MyfqoIaHaqnGlR4rJKtdc8/b
	 xb9QvH6auIofaK7mlzSB/wpXkcesBMymRDmkBcOwBbi480wbYden5ujV4QsTC66oO3
	 Z/FYvFFqVdozJlsMUdnkdXDFCJLIe17Rhs1qz8/BCDAkwdsYPgQDXMcP0ofaGRjUcr
	 rb0iTUeFcYb/Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v4 0/7] irqchip/ACPI: Arm GICv5 IWB ACPI IRQ probe deferral
Date: Thu, 09 Jul 2026 10:40:10 +0200
Message-Id: <20260709-gic-v5-acpi-iwb-probe-deferral-v4-0-48dae790f871@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpeT2oC/4XOQU7DMBCF4atUXjPIHsdO0hX3QCxsZ5waqiQaF
 wOqcnecdlEhFlk+afT9cxWZOFEWx8NVMJWU0zzV0TwdRDi5aSRIQ90CJVrZYAtjClAMuLAkSF8
 eFp49wUCRmN0ZwhC6pvfKdaYRFVmYYvq+BV7f7jt/+ncKl03dLk4pX2b+uX1Q1HZ3jxlp9mJFg
 QSvW9+Zvu+0xZcP4onOzzOPYqsVfHhW6l0Pq4c6Rqest+T9P08/vFaqXU9XLxhjMUQZCfs/3rq
 uv8jwKKl/AQAA
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
Changes in v4:
- Applied v3 review comments and tags
- Link to v3: https://patch.msgid.link/20260701-gic-v5-acpi-iwb-probe-deferral-v3-0-c5562cf0fe29@kernel.org

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
      ACPI: Add acpi_device_clear_deps() helper function
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

