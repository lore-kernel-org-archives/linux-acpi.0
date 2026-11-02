Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629435;
	b=Z+SEeouioqkRn7Mi+mZ4shN6rn7ZQ6nzysHTf7lZoizNBT4GkzooeSlADkjM3qzGyEMv
	 kqIVphXthHCsSZzXDi4HGKOoz1TxXQVcS1wHKFW4/W82z89DCLJWk0/m/7RGTgApBkS3J
	 0D9P2Ykydo4yIE1wWnmCdFGxDiMfaI/ECZZ//+gkMzqCUS/jtraNakdnEslDWNyxImNaL
	 HQ6Nm7agfn0aT5+c//63TfSe8IfTX52BkzM2pSDaNtS64M3Tr/j65L+zDnBPOm5f+Mm6z
	 1YRr4n+5cCdZUV3VBoITkvuomHVRK/vZoYTLy8QqQ3YP39HR48kzYBP6MB4GBGUDA7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629435;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kXhg0tNcz/XggPQ5n4ztmniJcr2/pUza6Nt9tHp8FTw=;
	b=YpwvB+ATFAoDLvZ3sypg9wBHQ5BwtXsZiqcvI1gOGBDeNl99f6OGcg/vdCGolvLZIxDb
	 ae4J33U1XssdJhwfTI6K1O1+f1WVKWopLgBxDA9qjurpLGjQSoAPc0vn8cO/6iFFYQYj1
	 FxB0PORWwcNnBez7F1sndslzo0pH2PzB2uEFeI6AKXqeLpLpOcHctFJTNVUOPu8YyBYZe
	 O0ll02eyHPzaRncyQJBEMFEZldqlSijCjBatfJFgTxemrJ3qnZF9H6kJQTk+gB2qhHwsP
	 mBHT/bnjPcMOs9Y8VE6JcSbd4bIg/GxtG4yVmv4xaE45t+5685sjeUN8+nnd9VbzFFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jr1Hy/e7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996F60A5BFC
	for <linux-acpi@vger.kernel.org>; Mon,  2 Nov 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr1Hy/e7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480CA1F00A2C
	for <linux-acpi@vger.kernel.org>; Mon,  2 Nov 2026 14:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629435;
	bh=kXhg0tNcz/XggPQ5n4ztmniJcr2/pUza6Nt9tHp8FTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jr1Hy/e7gI3GUs274WWSQ5hTdQ5yWc90zb48gWhLb60/4pEmfw9+9uWVsm/HzyOl4
	 MufpNBrSMEcHPhe58T6Fh5Gu9hgsP5p01G0u9dfUHlKSUWJU410IysY5UkUw7IUQHP
	 o0OV61MWiAuIHSvjPLVOcWRf6jvD07M24AIJk9dFVb/gg3u/iLjCxyhiztczxiuZUP
	 OD1AE0rQ3KWFQvaZRA9wHMWSz4913505VrD3fjoW5TimJK16316TKfKXDhIOzn0hvC
	 iZomX8ra50oamAdBLDYq4OSrZUxsIEWTBwp3Sv49gLiulo6vqtrPa6ZRJcjGqcSRXm
	 61IsqfbQiwnOQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1ec41d8e9so3287713a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 06:23:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByCIbRjc9IvKPeQ1+QdNHTXWMZT/AXxjj2Kw4vN/NGAcFLT3q/hiajbw8B5B9ATgj3/9LZDqhBMQEqW@vger.kernel.org
X-Gm-Message-State: APuU4Z+IRDZuI6JkOnwu6IqNMLAu/VQ4p7fFTvYhRhsdpvWXWOryB5k4
	ArYtXjSBTetbEC9XDYrvVIfaJJOwVG1ousL13pu5QYUAW4zmGpQ69Ima/aibTL9AsSZQta/MUoC
	KEe+YRyFOncFS/VmP53rX9egIcKC3F/c=
X-Received: by 2002:aa7:d901:0:b0:6b3:8456:e891 with SMTP id
 4fb4d7f45d1cf-6b4d339252cmr5593796a12.6.1793629433728; Mon, 02 Nov 2026
 06:23:53 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029035253.2333852-1-yaojiale02@163.com>
In-Reply-To: <20261029035253.2333852-1-yaojiale02@163.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 2 Nov 2026 22:23:40 +0800
X-Gmail-Original-Message-ID: <CAAhV-H65Pz=9Oy5MND4XCEWUxXkt3WDuW8pUFZBKt5Ysr3_aNA@mail.gmail.com>
X-Gm-Features: AclHuK9o0PutAsPpj7EOwjdyA0-9FdNtllxsLhyG2MkS5DpLOschCOnx7vBo5lY
Message-ID: <CAAhV-H65Pz=9Oy5MND4XCEWUxXkt3WDuW8pUFZBKt5Ysr3_aNA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] ACPI/irqchip: validate MADT entries before use
To: Jiale Yao <yaojiale02@163.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Sunil V L <sunilvl@ventanamicro.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Lorenzo Pieralisi <lpieralisi@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Anup Patel <anup@brainfault.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Tomasz Nowicki <tn@semihalf.com>, 
	Julien Grall <julien.grall@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, 
	Jonathan Cameron <jic23@kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Jones <andrew.jones@linux.dev>, 
	Grant Likely <grant.likely@linaro.org>, Jason Cooper <jason@lakedaemon.net>, 
	Robert Richter <rrichter@cavium.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Tianyang Zhang <zhangtianyang@loongson.cn>, Liupu Wang <wangliupu@loongson.cn>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jiale,

Why can't I see a full list of all Loongson-specific patches in
https://lore.kernel.org/loongarch/ ?

Huacai

On Thu, Oct 29, 2026 at 11:53=E2=80=AFAM Jiale Yao <yaojiale02@163.com> wro=
te:
>
> ACPI interrupt-controller setup passes firmware-supplied MADT subtables
> to architecture and irqchip callbacks.  The common table walker only
> guarantees that a generic subtable header is readable.  A number of
> callbacks cast that header to a larger controller-specific structure and
> read typed fields before checking that the complete record is present.
> Truncated records can therefore cause out-of-bounds reads during early
> CPU and interrupt-controller discovery.
>
> This series combines the previously posted generic/irqchip series [1],
> the RISC-V series [2], and the remaining MADT callback checks into one
> set.  The common irqchip probe path first rejects entries whose declared
> range leaves the table.  Each parser then validates the minimum size of
> the concrete record before its first typed access.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> The RISC-V cases were tested with qemu-system-riscv64, EDK2 pflash
> firmware, a KASAN-enabled kernel, CONFIG_ACPI_TABLE_UPGRADE=3Dy, and an
> uncompressed initramfs containing an overriding MADT.  The malformed
> table is one page long and ends with a three-byte RINTC entry, while a
> complete struct acpi_madt_rintc is 36 bytes.
>
> On an unpatched kernel the override was accepted and setup_smp() faulted
> in acpi_parse_rintc() while reading processor->flags four bytes from the
> start of the truncated record.  The record starts three bytes before the
> end of the mapped page, so that read entered the following unmapped page:
>
>   Unable to handle kernel paging request
>   epc : acpi_parse_rintc+0x46/0x206
>   cause: 000000000000000d
>   Kernel panic - not syncing: Attempted to kill the idle task!
>
> Applying only the old arch/riscv/kernel/acpi.c and
> drivers/irqchip/irq-riscv-intc.c checks produced the same fault because
> the setup_smp() parser runs first.  With patch 7 moving the existing
> BAD_MADT_ENTRY() check before the flags read, plus patches 9 and 20, the
> out-of-bounds access disappeared.  The malformed table was rejected and
> the kernel later stopped at the existing acpi_init_rintc_map() BUG for a
> machine with no valid RINTC entries.  This is the current fail-closed
> behavior; it is not an out-of-bounds access.
>
> The LoongArch LPC-PIC case was exercised with an overriding MADT ending
> in a three-byte LPC-PIC entry.  Temporary diagnostic instrumentation in
> pch_lpc_parse_madt() reported:
>
>   decl_len=3D3 sizeof=3D14 beyond_end=3D11
>
> This confirms the field accesses covered by patch 19 extend eleven bytes
> beyond the supplied record.  LoongArch maps this early table directly,
> so the read did not itself cause a page fault.
>
> Dynamic test coverage by patch is therefore:
>
>   7       RISC-V RINTC fault reproduced; the early check prevents it.
>   9       The malformed RINTC is rejected in acpi_init_rintc_map().
>   19      LoongArch LPC-PIC over-read observed with instrumentation.
>   20      Included in the complete RINTC fix; the boot stops at the
>           existing fail-closed BUG before irqchip probing reaches it.
>   1-6,
>   8,
>   10-18 No dynamic claim.  The required GICv5, AVEC, redirect-int,
>           HTVEC, and related controller models are not available in the
>           QEMU configurations used for this test.
>
> All twenty patches were checked with scripts/checkpatch.pl and were
> applied both individually where independent and as the complete series
> to the base commit below.
>
> Changes in v2:
> - Combine and supersede the six-patch irqchip series [1], the two-patch
>   RISC-V series [2], and the remaining MADT checks.
> - Add the RISC-V QEMU/EDK2 truncated-RINTC reproduction and fixed-kernel
>   result.
> - Retain the setup_smp() RINTC fix: testing showed that the later RISC-V
>   checks alone do not prevent the early boot fault.
> - Document the LoongArch LPC-PIC instrumentation result and the QEMU
>   hardware-model limitations for the other callbacks.
> - Rebase on the current tree and keep Fixes and stable trailers on every
>   patch.
>
> [1] https://lore.kernel.org/r/20261021144524.364143-1-yaojiale02@163.com
> [2] https://lore.kernel.org/r/20261016141249.2791819-1-yaojiale02@163.com
>
> Jiale Yao (20):
>   ACPI: irqchip: validate MADT entry bounds before probing
>   irqchip/gic-v3-its: validate MADT ITS entries
>   irqchip/gic-v3: validate MADT records before use
>   irqchip/gic-v5-its: validate MADT translate frames
>   irqchip/loongarch-cpu: validate MADT LIO-PIC entries
>   irqchip/loongson-eiointc: validate MADT BIO-PIC entries
>   riscv: validate RINTC entries before use
>   ACPI: riscv: validate interrupt controller MADT entries
>   riscv: acpi: validate RINTC entries before use
>   irqchip/gic-v5-irs: validate MADT GICC entries
>   irqchip/gic-v5-irs: validate MADT IRS entries
>   irqchip/gic-v5: validate MADT IRS records
>   irqchip/gic: validate MADT distributor records
>   irqchip/loongarch-avec: validate MADT MSI-PIC entries
>   irqchip/loongarch-ir: validate MADT MSI-PIC entries
>   irqchip/loongson-htvec: validate MADT BIO-PIC entries
>   irqchip/loongson-htvec: validate MADT MSI-PIC entries
>   irqchip/loongson-liointc: validate MADT HT-PIC entries
>   irqchip/loongson-pch-pic: validate MADT LPC-PIC entries
>   irqchip/riscv-intc: validate MADT RINTC entries
>
>  arch/riscv/kernel/acpi.c               |  3 +++
>  arch/riscv/kernel/smpboot.c            |  6 +++---
>  drivers/acpi/riscv/irq.c               |  6 ++++++
>  drivers/acpi/scan.c                    |  7 +++++++
>  drivers/irqchip/irq-gic-v3-its.c       |  3 +++
>  drivers/irqchip/irq-gic-v3.c           | 15 +++++++++++++++
>  drivers/irqchip/irq-gic-v5-irs.c       |  6 ++++++
>  drivers/irqchip/irq-gic-v5-its.c       |  3 +++
>  drivers/irqchip/irq-gic-v5.c           |  3 +++
>  drivers/irqchip/irq-gic.c              |  3 +++
>  drivers/irqchip/irq-loongarch-avec.c   |  3 +++
>  drivers/irqchip/irq-loongarch-cpu.c    |  3 +++
>  drivers/irqchip/irq-loongarch-ir.c     |  3 +++
>  drivers/irqchip/irq-loongson-eiointc.c | 10 ++++++++--
>  drivers/irqchip/irq-loongson-htvec.c   |  6 ++++++
>  drivers/irqchip/irq-loongson-liointc.c |  3 +++
>  drivers/irqchip/irq-loongson-pch-pic.c |  3 +++
>  drivers/irqchip/irq-riscv-intc.c       |  5 ++++-
>  18 files changed, 85 insertions(+), 6 deletions(-)
>
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> --
> 2.34.1
>
