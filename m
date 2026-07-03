Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE33B27E3;
	Fri,  3 Jul 2026 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076179; cv=none; b=CqBYJ8RLejbbb9gaIlHs/06WHMnQC+hHI39EIrH/iWjmCTgpmCmGoWbYuMKeyBEHUDi/XVO/Ktx2gA7P6Iny5+4J+a8BTuGLZ6wPljzGgXbueVWcE3wCNhMeodvZOhedVSdqtrgNBNoP+cpB1r9mY5a5fV3kGDQUqnd7QMzB59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076179; c=relaxed/simple;
	bh=ib+jJeqAaNrgnlTJcoYJ6GWsMpg4EWkroOHnmx53RzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D07X/d4oLwJB9EGDMzy6EnLaSdaQgGF6Wm+sB+Qvc77zXGnWEPLhhPQiEutMQSZDnu7/FBnPjMVBijH8MVsjrHbBOTGNRLPmxmP2px5yqpRh3e8Iaf9qfuFd3p1g59/Mr27zSyJT2F7iKLD2u6cdvmJ0N4rSO4BCY4fIfV/JKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dq3gTaOg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dq3gTaOg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11EC11F91;
	Fri,  3 Jul 2026 03:56:12 -0700 (PDT)
Received: from [10.211.55.3] (unknown [10.57.73.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 405E13F905;
	Fri,  3 Jul 2026 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783076176; bh=ib+jJeqAaNrgnlTJcoYJ6GWsMpg4EWkroOHnmx53RzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dq3gTaOglJw3duLPTmbmtELC62r50lAPmCDJJTHO+w2qzB6g/CyyuOToBNHbUOXZT
	 ULsg2vAvZo6Ho7U5E1FHwj7ioUb5Lw6vwBO5a0t5DoUxnJPVOV3RcyiEbVlbReHkxd
	 kSN8oMq5oJLa34wGP+E3WjG/8VW7NTKRfGjVaEqs=
Message-ID: <f418f531-bc0b-4bff-a96f-121034c6c693@arm.com>
Date: Fri, 3 Jul 2026 11:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 14/15] arm_mpam: prevent MPAM-Fb accesses inside IRQ
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
References: <20260702162229.4008659-1-andre.przywara@arm.com>
 <20260702162229.4008659-15-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260702162229.4008659-15-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/2/26 17:22, Andre Przywara wrote:
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
> MMIO accesses, and just ignore the pending interrupts. We will wrap up
> MPAM functionality regardless, knowing the exact error value will not
> change that.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 35 +++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index b858ff389bff..4a088e6cd235 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -2639,7 +2639,7 @@ static int mpam_disable_msc_ecr(void *_msc)
>  
>  static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>  {
> -	u64 reg;
> +	u64 reg = 0;
>  	u16 partid;
>  	u8 errcode, pmg, ris;
>  
> @@ -2648,25 +2648,30 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
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

As an error interrupt is final can we just disable the IRQ? Is it
useful? I see there is a function disable_irq_no_sync().

> +	} else {
> +		pr_err_ratelimited("unknown error irq from msc:%u\n", msc->id);

Should we report by irq number?
As MSC may share interrupts we don't know which MSC caused the error irq
at this point. On MMIO platforms we read the ESR to establish this.

Thanks,

Ben

> +	}
>  
>  	/* Are we racing with the thread disabling MPAM? */
>  	if (!mpam_is_enabled())

