Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336E5233933
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603945; cv=none; b=c8Ry3TibINr3tiCp8NKfOJ1VwxnpJrtlQenXatiUf9fM/y8NEqFDdBxAHJVMEMkcDv053W9caXBJTnuuPZLfpZZ1lMGK5BJfACY/HojFlB78MedyR3BNl4vA2xYoaMrn2qRl8Ag8IHLcoznJfi9zkjZg81prq/70IZGSr2IqBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603945; c=relaxed/simple;
	bh=Lr0/JzLsZHU7DE9GHdkhy4GABMoazF4KGSvu2e2cCiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0xLI8eTda6xyQVHZ5i/BFVm4m8s6ihinTdQfaYDgh8rPKq+XsGDBD5qqrfGfRtHROh1EHygFsoVQKJ4YRLngE4SKoQ2Xr+9GtUEzWAcuLbWhfd4tAsFZrjOZ1JJxxthMqIWUpqmqSR8NLN0NfQdT7nt81V3B6KbSKcRVTYWt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g283wSg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g283wSg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B2E1F00ADE
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783603943;
	bh=2tewPeVsAxKBBt/hHzLYO7y76PO1MYevgazh3aupzok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g283wSg4xREH65kKxISY22wUVdxl54rWeKsiKW2RXCvPyegxW2ONGX7hhCLFYdJB5
	 WVgLRkH6a07mp/jtKrDnS68YtSwIhRktV10UFYiiB+xxprgqItF53QbtCZxsxbMkDS
	 JN3E8m04+5O6cGShbbswRsC1Ygrx5joUh3+SK17xr2RJLBDr+I7dnnSidqFxktJKTq
	 6XWPCUD9zTB0RwlWe0RFr9HHkRABXAQnPxPjfI6QH7HkehkPmkn4W5uJSvJTR/xfDR
	 SiHSgpl21xpnSVLy/TblRrj6vW0W/3JcePp5IfUyn5OVZOAWtcTaYX3On5/I0VuioN
	 YK/dOBWElbPVQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so2090170e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 06:32:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqGfA7FpsZB3E7KGeAqQiNLADkb/OGZ8TmmsDBkK9yJ1OBEd9YH/NwT6BHqfkcPWl01GljF70m+Sb0E@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKO2go5fZVAqgePcMj1+2uTU0SOKS0q+etsRrXlzHaHBUbhcX
	Y70S9iNkNqmdN2IAOcLmRRUGfN+mNxmGJ5F7/We6WqUyo9MZc9QYbQCIQ6440YZHPN94fdHiCuJ
	VZPxCpBLyu8YqE47eJEvWsTreyemTYnI=
X-Received: by 2002:a05:6512:64a8:b0:5b0:12cf:ae3f with SMTP id
 2adb3069b0e04-5b012cfb1e8mr1407950e87.31.1783603942165; Thu, 09 Jul 2026
 06:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709-gic-v5-acpi-iwb-probe-deferral-v4-0-48dae790f871@kernel.org>
In-Reply-To: <20260709-gic-v5-acpi-iwb-probe-deferral-v4-0-48dae790f871@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 9 Jul 2026 15:32:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hDK+C+ZJ4YKd0xbyHW+vEot9z-YrivWSrg1ag7Ebx4cA@mail.gmail.com>
X-Gm-Features: AUfX_my3RabqhVkiaUs2JZU-hHXS-RHiCuP5fgE1pk66iBa2OI-yzz3XlXSUIdk
Message-ID: <CAJZ5v0hDK+C+ZJ4YKd0xbyHW+vEot9z-YrivWSrg1ag7Ebx4cA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] irqchip/ACPI: Arm GICv5 IWB ACPI IRQ probe deferral
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sunil V L <sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 10:41=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Arm GICv5 systems, the IWB (Interrupt Wire Bridge) handles wired inter=
rupts
> and it is in charge of translating interrupt wires to GICv5 ITS messages.
>
> In ACPI systems, an IWB is backed by a platform device. Device drivers fo=
r
> devices whose IRQs are routed to an IWB might probe earlier than the IWB =
device
> driver, which can result in failures in that until the IWB driver is prob=
ed and
> its IRQ domain is duly registered, IRQs routed to it cannot be resolved.
>
> Some interrupt controllers for the RISC-V architecture suffer from the sa=
me
> issue; RISC-V, in its ACPI IRQ layer solved the problem by automatically
> creating device dependencies that result in the interrupt controllers dri=
vers
> being probed before any device driver whose devices IRQs are routed to th=
em is
> probed.
>
> Instead of reinventing the wheel, this series move the aforementioned RIS=
C-V
> code to generic ACPI IRQ handling code (while fixing some bits and pieces=
) and
> implement GICv5 IWB ACPI probe deferral on top of it.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> ---
> Changes in v4:
> - Applied v3 review comments and tags
> - Link to v3: https://patch.msgid.link/20260701-gic-v5-acpi-iwb-probe-def=
erral-v3-0-c5562cf0fe29@kernel.org
>
> Changes in v3:
> - Added stub to clear ACPI device dependencies
> - Added review tags
> - Rebased against v7.2-rc1
> - Link to v2: https://patch.msgid.link/20260603-gic-v5-acpi-iwb-probe-def=
erral-v2-0-23ffa16b6ebb@kernel.org
>
> Changes in v2:
> - Split the patchset in several logic units according to review
> - Link to v1: https://patch.msgid.link/20260505-gic-v5-acpi-iwb-probe-def=
erral-v1-0-b37b85998362@kernel.org
>
> To: "Rafael J. Wysocki" <rafael@kernel.org>
> To: Len Brown <lenb@kernel.org>
> To: Sunil V L <sunilvl@ventanamicro.com>
> To: Marc Zyngier <maz@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Huacai Chen <chenhuacai@kernel.org>
> To: Anup Patel <anup@brainfault.org>
> To: Hanjun Guo <guohanjun@huawei.com>
> To: Sudeep Holla <sudeep.holla@kernel.org>
> To: Catalin Marinas <catalin.marinas@arm.com>
> To: Will Deacon <will@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: loongarch@lists.linux.dev
>
> ---
> Lorenzo Pieralisi (7):
>       ACPI: Add acpi_device_clear_deps() helper function
>       ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop termination
>       ACPI: RISC-V: Check acpi_get_handle() status in riscv_acpi_add_prt_=
dep()
>       ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop handling
>       ACPI: irq: Move RISC-V interrupt controllers autodep to ACPI IRQ co=
de
>       ACPI/IORT: Implement ACPI infrastructure to enable GICv5 IWB probe =
deferral
>       irqchip/gic-v5: Enable GICv5 IWB ACPI probe ordering detection
>
>  arch/riscv/include/asm/acpi.h       |   1 +
>  drivers/acpi/arm64/iort.c           |  22 ++++-
>  drivers/acpi/irq.c                  | 172 ++++++++++++++++++++++++++++++=
+++++-
>  drivers/acpi/riscv/irq.c            | 141 +----------------------------
>  drivers/acpi/scan.c                 |   1 +
>  drivers/irqchip/irq-gic-v3.c        |   2 +-
>  drivers/irqchip/irq-gic-v5-iwb.c    |   2 +
>  drivers/irqchip/irq-gic-v5.c        |  13 ++-
>  drivers/irqchip/irq-gic.c           |   2 +-
>  drivers/irqchip/irq-loongarch-cpu.c |   2 +-
>  drivers/irqchip/irq-riscv-intc.c    |   3 +-
>  include/linux/acpi.h                |  13 ++-
>  include/linux/acpi_iort.h           |   3 +-
>  13 files changed, 223 insertions(+), 154 deletions(-)
> ---

All applied as 7.3 material, thanks!
