Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519D3597B;
	Tue, 28 Jul 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253739; cv=none; b=dKlUk3GHZOgxe897WDElmMVof1n/XBHDTvEkhBGesk+BBTH2mdp3BuuLe3vgXsJ74hZ0B9kNyctkyccUy4bBlywIsf40tBATBU+DQKY9DsG/ji6kmvSXTsGcGgHE4EkvrhZV8JU2+7Ddk/BPuBznYP9snndnxuRCIYPalbODSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253739; c=relaxed/simple;
	bh=zr+9PxuDJ8lVkBBcPMcBlC8LCkYW7GLO6vnyeUF46Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mn9zYJPErPwfAljQZuWPMyK7Yh918e3oYEybHeCPAnGArkXtjPa3PtJQ5E6NFohpm/nwRg+tI25YL/HevpSJviysxhI3gELkrS8DvfrJOrkrwAB8mg2DvuSZhvffI9pOu3kKUOP0VCH/CuY4QM/l/dj8bGX5ulBAG7MX9HwUpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sdfWHKkq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sdfWHKkq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16956169E;
	Tue, 28 Jul 2026 08:48:53 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E0F03F66F;
	Tue, 28 Jul 2026 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785253737; bh=zr+9PxuDJ8lVkBBcPMcBlC8LCkYW7GLO6vnyeUF46Tw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sdfWHKkq+5CXHiHCV32yCTAkdMpxSOe2krpGhrxe+7SD9xNOR0XUje2Y+l3Hu/2ln
	 dDzKpX1lq9LoumIAdJ7EV4Zq3ceOUSo54++8dAj6TFMHRvdX6PiCW17pUJpJLt3pCv
	 SW2d3bsmt4+r5UO/bpDtJs1vw+X/6RiCbPbdQJlM=
Message-ID: <d471ead3-d6fd-4e2e-a800-5bbeba42cb90@arm.com>
Date: Tue, 28 Jul 2026 16:48:53 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [RFC PATCH] arm_mpam: remove sanity check of accessibility when
 error interrupt is SPI on SMT platforms
To: Yadong Qi <yadong.qi@linux.alibaba.com>, james.morse@arm.com,
 reinette.chatre@intel.com, fenghuay@nvidia.com,
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
 sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ying.huang@linux.alibaba.com
Cc: ptg-linux-kernel@linux.alibaba.com
References: <20260720072409.2660-1-yadong.qi@linux.alibaba.com_quarantine>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260720072409.2660-1-yadong.qi@linux.alibaba.com_quarantine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yadong,

On 7/20/26 08:24, Yadong Qi wrote:
> On SMT platforms, an L2 cache MSC is typically shared between sibling
> threads. Per the MPAM ACPI spec (DEN0065B), the MSC's linked device
> should be set to the processor container of those siblings, so the
> kernel derives msc->accessibility as just the sibling CPUs.
> 
> Per the MPAM spec (IHI0099B), when an MSC is not integrated into a PE,
> SPI/LPI is the recommended error interrupt. SPIs are not per-CPU, and a
> sanity check in mpam_msc_setup_error_irq() requires accessibility ==
> cpu_possible_mask — assuming a shared interrupt must be routable to all
> CPUs. This creates a conflict on SMT platforms: the MSC has a restricted
> accessibility but a shared error interrupt, causing probe to fail with:
> 
>   msc:N is a private resource with a shared error interrupt
> 
> This RFC patch removes the check to allow MSC probe to succeed on SMT
> platforms, but this is mainly intended to start a discussion. We would
> appreciate advice on the right way to handle this conflict. Is this a
> spec issue, or should the driver handle SPI error interrupts differently

For advice on questions broader than just linux please ask arm support: support@arm.com

> when an MSC has a restricted accessibility mask?

I expect the MPAM driver could be taught to deal with SPI interrupts without global affinity.

> 
> Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
> ---
>  drivers/resctrl/mpam_devices.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index b69f99488111..e8b2b5e00d7c 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1964,13 +1964,6 @@ static int mpam_msc_setup_error_irq(struct mpam_msc *msc)
>  	if (irq_is_percpu(irq))
>  		return __setup_ppi(msc);
>  
> -	/* sanity check: shared interrupts can be routed anywhere? */
> -	if (!cpumask_equal(&msc->accessibility, cpu_possible_mask)) {
> -		pr_err_once("msc:%u is a private resource with a shared error interrupt",
> -			    msc->id);
> -		return -EINVAL;
> -	}
> -

To do this the MPAM driver would have to remove the interrupt from balancing, IRQF_NOBALANCING, and
control the balancing itself.

Thanks,

Ben

>  	return 0;
>  }
>  

