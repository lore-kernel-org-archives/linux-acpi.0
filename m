Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8EA326924;
	Wed, 15 Jul 2026 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131738; cv=none; b=kwrzadaZXfSQ1ifjqFInty/jEp9q437Azzxhc3ahOuNS2zgIDSYN+P5v0cjLX6o7WlubhWkpl+fHSK8npp340CDklirUg9khc+xp1SwonrPiKVI7EPQHSitnY3amojkxD/ReYfe7mYgoIuW85iMre4EFP1NGASTt4XkDFjf5ja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131738; c=relaxed/simple;
	bh=VL1Iq5O6TVtNHTsx5IP7Kgws7EcKFJo0NIN1naJp298=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TB71smCimuwS8PPE3ckz4BzJ1LU53J/DX2aSUouccpn77WT0rzyglkQTAz6CbH0fRBJ8SI3n+muvGmV2mzNmo7yABMsZSKniZR2gDy+Qkd+ChkYP/aX6pyrSL9UZkupiMF5X0RHNXDfJYHxSewLiX8KPHaAgWqnm1sGsDNRmPDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EO4mE+lp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EO4mE+lp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6705B1477;
	Wed, 15 Jul 2026 09:08:51 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40C113F7B4;
	Wed, 15 Jul 2026 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784131735; bh=VL1Iq5O6TVtNHTsx5IP7Kgws7EcKFJo0NIN1naJp298=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EO4mE+lpYoEy2GmzXsAaov+j2nYPyv+PpMTUdFBA5Crm/SFn3kCAwXDDFFTlwHDaw
	 YdCKSzYyAQvw2mBuT3YlpyeC88e4GLEQ6Rw4K1qT7FIRjthVUc94q+qIRPz6SEOS9u
	 oeq2F2FW0uHm5RMqn0mFNoqHI0NqxEI6Ifmhn758=
Message-ID: <2a5efa78-952f-41a5-b372-e138cb30361d@arm.com>
Date: Wed, 15 Jul 2026 17:08:51 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v3 15/16] arm_mpam: prevent MPAM-Fb accesses inside IRQ
 handler
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-16-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260710144520.917375-16-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/10/26 15:45, Andre Przywara wrote:
> When an MPAM MSC gets into an error condition, it can trigger an error
> IRQ. We cannot really do much about those errors, but we at least query
> and log the error, then disable MPAM functionality.
> 
> This error report relies on reading the MSC's error status register
> (ESR) in the IRQ handler, which is not possible for MPAM-Fb based
> MSC accesses, since they involve mailbox routines that might sleep.
> The same is true for clearing the interrupt at the source, which
> requires MSC access.
> 
> For simplicity just skip the ESR read when the MSC is not using direct
> MMIO accesses, and just ignore the pending interrupts. 

Is this definitely ok? Don't we just keep on calling the hardirq handler on a level triggered
interrupt. Does a IRQF_ONESHOT threaded interrupt where the threaded part calls
mpam_disable_msc_ecr() and schedules mpam_broken_work make things better.

What you have may be ok but I don't know enough to be sure.

Thanks,

Ben

We will wrap up
> MPAM functionality regardless, knowing the exact error value will not
> change that.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 38 ++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 4d3e642486d4..220b4a06e739 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -2645,7 +2645,7 @@ static int mpam_disable_msc_ecr(void *_msc)
>  
>  static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>  {
> -	u64 reg;
> +	u64 reg = 0;
>  	u16 partid;
>  	u8 errcode, pmg, ris;
>  
> @@ -2654,25 +2654,33 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>  					   &msc->accessibility)))
>  		return IRQ_NONE;
>  
> -	mpam_msc_read_esr(msc, &reg);
> +	/* MPAM-Fb MSC accesses cannot be done in atomic context. */
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		mpam_msc_read_esr(msc, &reg);
>  
> -	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
> -	if (!errcode)
> -		return IRQ_NONE;
> +		errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
> +		if (!errcode)
> +			return IRQ_NONE;
>  
> -	/* Clear level triggered irq */
> -	mpam_msc_clear_esr(msc);
> +		/* Clear level triggered irq */
> +		mpam_msc_clear_esr(msc);
>  
> -	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
> -	pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
> -	ris = FIELD_GET(MPAMF_ESR_RIS, reg);
> +		partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
> +		pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
> +		ris = FIELD_GET(MPAMF_ESR_RIS, reg);
>  
> -	pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
> -			   msc->id, mpam_errcode_names[errcode], partid, pmg,
> -			   ris);
> +		pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
> +				   msc->id, mpam_errcode_names[errcode], partid,
> +				   pmg, ris);
>  
> -	/* Disable this interrupt. */
> -	mpam_disable_msc_ecr(msc);
> +		/* Disable this interrupt. */
> +		mpam_disable_msc_ecr(msc);
> +	} else {
> +		struct irq_data *d = irq_get_irq_data(irq);
> +
> +		pr_err_ratelimited("unknown error irq %d/%ld from msc:%u\n",
> +				   irq, d ? irqd_to_hwirq(d) : -1, msc->id);
> +	}
>  
>  	/* Are we racing with the thread disabling MPAM? */
>  	if (!mpam_is_enabled())

