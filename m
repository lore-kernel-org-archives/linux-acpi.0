Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242730C632;
	Tue,  5 May 2026 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970907; cv=none; b=jnql38Z1fT3NWk39HkJiKTwcuw2R/f7syAqXdmb0rYnvXRMhBDAVvg6qbjXenH4RKmfXHqlTCEmI4VOUw3fEF+boARKjZ7v+T62d9CkstBlQmCNNlK6ZAx6ub4qDb0z+xPE1KADAN+Ax0FhUj8xqX9s4vZnmNUnUcPMoy5EGSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970907; c=relaxed/simple;
	bh=8QSEESLQsGZMBc0pdl5VKAnCT/dlSZ7hXQFpHTyq4Jo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oKFtUH6iTxGeDgwNJSknrcndztMmooeEgsyZMH8rCKoWaaqI0gYxEn4jHMrFmFVex6C7CGqeOfHxDm5tOKqExLlAKXkXnzB+7mZH4YqYHCfZ/PxDf+Q0C/1LG7UWJx6z7Vu0zHJIMaamZl7E8meeUY2WQRE3Pufe2xbtXVcERJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grrS1HoQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grrS1HoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AB8C2BCB4;
	Tue,  5 May 2026 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777970906;
	bh=8QSEESLQsGZMBc0pdl5VKAnCT/dlSZ7hXQFpHTyq4Jo=;
	h=From:Subject:Date:To:Cc:From;
	b=grrS1HoQJqeMSjxUHuwf1IJls1BF2ihZyJMJJhJ1EjGjI+c9Tt2JL96/I55pHrwX3
	 VPSEqFz10xuZaitHRBYMivIziRm4oFIhEc2CudZmX3agONs5WBFs6a5Xm99/BlglVg
	 OhCIBKUihAceIYCbnfTwXxJM03riMn/JT5S5ZbcKvPWXGq9200XU/fn1Dlc5gzbOBH
	 3JyKrB7p5T6Wom8zir/4d++RFAQ9I4MAFnWmStUvk3xxaFZaxHcgGY36Z0Pe4UJm1v
	 i2GLp8fi6qfF9Ka79O2pFYi567HUX+RwJitgJwE1DyFXot9IgN0qiZioUBgchtsZSo
	 NyW8g9vF1209g==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 0/2] irqchip: Arm GICv5 IWB ACPI IRQ probe deferral
Date: Tue, 05 May 2026 10:48:02 +0200
Message-Id: <20260505-gic-v5-acpi-iwb-probe-deferral-v1-0-b37b85998362@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKu+WkC/yXNTQ6CMBBA4auQWTsJNEV+rmJctNMBxxhopookh
 LtTZflt3tsgsQon6IsNlBdJMk8Z1aUAerhpZJSQDaY019KaBkchXGp0FAXl6zHq7BkDD6zqXki
 BWtv5yrW1hRyJyoOs/8Htfjp9/JPp/avCvh84F3PIggAAAA==
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
Lorenzo Pieralisi (2):
      drivers/acpi: Move RISC-V interrupt controllers autodep to ACPI IRQ code
      irqchip/gic-v5: Add IWB to ACPI probe dependency control

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
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260427-gic-v5-acpi-iwb-probe-deferral-cdc849b1a854

Best regards,
--  
Lorenzo Pieralisi <lpieralisi@kernel.org>

