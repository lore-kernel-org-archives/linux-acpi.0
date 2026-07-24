Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F75B4156D1;
	Fri, 24 Jul 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911964; cv=none; b=bEGBvh3AXaDzPFFJa4lHS59SESmswTWx1MVM2stlhQtgpJg0fhOoAA7soxt2IovNC74d3ZaNTIVUGHqe7PfzN6oc+lcvLvPe5GRh/HgxBRQzxZQ3lf+ZoQHkWUtmt3/+4L60BXzKqCmzlpaIXy1bg1/X0TfwUtHbm5Aas3jE2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911964; c=relaxed/simple;
	bh=RoBul/17+T3FdgEK+F3KrO5hn7IfjNH0FUsIZl8w4/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJrqyuES1NYackX/caQU/Kd5lSfYOCNXShpQCLj9oSrMIHAIwz+z40pzxP98Yh2VTBHchSWYo4Ovv85NladyZWoXM4a+jNjLx8w1Ub89PbY0nSXd8rV7mid7VxK8pzfQLZTM41WWhAZk5kwBEJenP5ZidW9GOhnV5UcOrS1tCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P0L5J143; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P0L5J143"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6671476;
	Fri, 24 Jul 2026 09:52:36 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B39BF3F66F;
	Fri, 24 Jul 2026 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784911959; bh=RoBul/17+T3FdgEK+F3KrO5hn7IfjNH0FUsIZl8w4/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P0L5J143rZOhfhNxZ0HNkorXC2EWBXDUnvMQwVdQeyWD8eimCgkSLy1In3Xiz9bbL
	 GnWsiBKDKjWuepsOA9ND0ORHgh+bsBORxraV1jC/AQHX/RON78aRxgPcK0+o+e15Nx
	 5OtNegz8+j/ZU/6iWrd4ObOkOQKnVPauDsYd+Zuc=
Message-ID: <63fc5264-f0ef-4aa1-8ffc-10aa3ac98a79@arm.com>
Date: Fri, 24 Jul 2026 17:52:33 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v4 09/10] arm_mpam: prevent MPAM-Fb accesses inside IRQ
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
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-10-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260723155454.1760823-10-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/23/26 16:54, Andre Przywara wrote:
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
>  drivers/resctrl/mpam_devices.c | 36 +++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index b8108ed4b32c..fea3161ffbe9 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -2650,25 +2650,33 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
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

I still think we should use a threaded interrupt with IRQF_ONESHOT and disable the interrupt and
schedule the mpam_disable from there. That way it can be obvious that won't just keep on running the
interrupt handler and never getting to run the scheduled work.

Thanks,

Ben

> +	} else {
> +		struct irq_data *d = irq_get_irq_data(irq);
> +
> +		pr_err_ratelimited("unknown error irq %d/%ld from msc:%u\n",
> +				   irq, d ? irqd_to_hwirq(d) : -1, msc->id);
> +	}
>  
>  	/* Are we racing with the thread disabling MPAM? */
>  	if (!mpam_is_enabled())

