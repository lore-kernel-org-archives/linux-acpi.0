From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH v4 5/5] clocksource: add memory-mapped timer
 support in arm_arch_timer.c
Date: Fri, 18 Mar 2016 10:32:48 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603181031280.3978@nanos>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org> <1458288053-29031-6-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1320791050-1458293570=:3978"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35877 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017AbcCRJeT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2016 05:34:19 -0400
In-Reply-To: <1458288053-29031-6-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fu Wei <fu.wei@linaro.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, marc.zyngier@arm.com, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1320791050-1458293570=:3978
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 18 Mar 2016, fu.wei@linaro.org wrote:
> +static u32 __init arch_timer_mem_cnttidr(struct acpi_gtdt_timer_block *gt_block)
> +{
> +	phys_addr_t cntctlbase_phy;
> +	void __iomem *cntctlbase;
> +	u32 cnttidr;
> +
> +	cntctlbase_phy = (phys_addr_t)gtdt_gt_cntctlbase(gt_block);
> +	if (!cntctlbase_phy) {
> +		pr_err("Can't find CNTCTLBase.\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * According to ARMv8 Architecture Reference Manual(ARM),
> +	 * the size of CNTCTLBase frame of memory-mapped timer
> +	 * is SZ_4K(Offset 0x000 – 0xFFF).
> +	 */
> +	cntctlbase = ioremap(cntctlbase_phy, SZ_4K);
> +	if (!cntctlbase) {
> +		pr_err("Can't map CNTCTLBase\n");
> +		return 0;
> +	}

Why are you continuing when you can't find a base address or the remap fails?

> +	/*
> +	 * Get Generic Timer Counter-timer Timer ID Register
> +	 * for Virtual Timer Capability info
> +	 */
> +	cnttidr = arch_timer_mem_cnttidr(gt_block);

Thanks,

	tglx
--8323329-1320791050-1458293570=:3978--
