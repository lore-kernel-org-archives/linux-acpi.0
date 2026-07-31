Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE3F5695;
	Fri, 31 Jul 2026 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504803; cv=none; b=AYqskukKx5eARcUUV1AlmOBcQ5nDuEOJbhZ7FQ/tDJD31o3XT20ZcpxZukynezP1JC7fUkzO5IcaRz2pN6exyrX77ryB20B/GGzFczInIrBGM3AprFc4X/3HArdytbfgUmv9xtNuj1CBBTtRrdt/JwwT+VbU+cV9svBxVKH8FkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504803; c=relaxed/simple;
	bh=Su2Q0vEK8ZDYhYpvfxPBORRIylsS9MVKYgKQH/+k5h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1QlbEWZnrtW/tlaotIZjAo+q5Akc6xw+kwGv7HDlghYxTAMM6XDx0vodIGzb81TARzY4tBRaMnKkpjxC2XricZzRh9vU2fLoS172S8pFxS5XCowj77vJGZEr3CfzNW4IhctnGzWqol513HxoRb26Bx598M8IL5OE/c8pJNGrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H6BqC0ar; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H6BqC0ar"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE89C204C;
	Fri, 31 Jul 2026 06:33:16 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17D5E3F7B4;
	Fri, 31 Jul 2026 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785504800; bh=Su2Q0vEK8ZDYhYpvfxPBORRIylsS9MVKYgKQH/+k5h4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H6BqC0ar6aExA+pO/+IEowd3nNJXiVsPhWxc5JJ4A/C0p4EoRha2jNW2GwVXw1ssY
	 OGudSuqZT8LMtet8hTH0KbY40RCd46zhLxWhXLwsk+uYittan+J86wnZ/93zZ7zkx2
	 Cd6/adrMz038bOfBVfB0uDbv9SsiPQEJNEq0QCIE=
Message-ID: <0b190985-3a71-43fb-9530-d6b50faf2e27@arm.com>
Date: Fri, 31 Jul 2026 14:33:16 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v6 09/10] arm_mpam: change MPAM-Fb error IRQ to use a
 threaded IRQ handler
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
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260730152539.2712312-1-andre.przywara@arm.com>
 <20260730152539.2712312-10-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260730152539.2712312-10-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/30/26 16:25, Andre Przywara wrote:
> When an MPAM MSC gets into an error condition, it can trigger an error
> IRQ. We cannot really do much about those errors, but we at least query
> and log the error, then disable MPAM functionality.
> 
> This error report relies on reading the MSC's error status register
> (ESR) in the current hard-IRQ handler, which is not possible for MPAM-Fb
> based MSC accesses, since they involve mailbox routines that might sleep.
> The same is true for clearing the interrupt at the source, which requires
> an MSC access as well.
> 
> When an MSC is using MPAM-Fb, change the error IRQ to use a threaded IRQ
> handler, with an empty hard IRQ routine, and doing all the MSC accesses
> (to access the status and disable the IRQ line) in the threaded part.
> The change is minimal, we just check for the first MSC access error and
> bail out early. MMIO based MSCs keep using a hard-IRQ handler, since
> they must be at least non-migrate-able when doing MSC accesses, for the
> CPU affinity check to work.
> Also forbid per-CPU interrupts (PPIs) for MPAM-Fb, as we cannot use a
> threaded IRQ here.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 64 ++++++++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index daaf3cf48475..606ae4af2be9 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -2660,24 +2660,38 @@ static int mpam_disable_msc_ecr(void *_msc)
>  	return 0;
>  }
>  
> +/*
> + * This will run as the threaded IRQ handler part when using MPAM-Fb, but
> + * as the sole hard-IRQ handler for MMIO based accesses.
> + */
>  static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>  {
>  	u64 reg;
> +	int ret;
>  	u16 partid;
>  	u8 errcode, pmg, ris;
>  
> -	if (WARN_ON_ONCE(!msc) ||
> +	if (WARN_ON_ONCE(!msc))
> +		return IRQ_NONE;
> +
> +	if (msc->iface == MPAM_IFACE_MMIO &&
>  	    WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
>  					   &msc->accessibility)))
>  		return IRQ_NONE;
>  
> -	mpam_msc_read_esr(msc, &reg);
> +	ret = mpam_msc_read_esr(msc, &reg);
> +	if (ret) {
> +		pr_err_ratelimited("unknown error irq from msc:%u\n", msc->id);
> +
> +		/* Try out best here ... */
> +		goto out_disable;
> +	}
>  
>  	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
>  	if (!errcode)
>  		return IRQ_NONE;
>  
> -	/* Clear level triggered irq */
> +	/* Clear level triggered irq. Ignore errors, we need to proceed. */
>  	mpam_msc_clear_esr(msc);
>  
>  	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
> @@ -2688,19 +2702,19 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>  			   msc->id, mpam_errcode_names[errcode], partid, pmg,
>  			   ris);
>  
> -	/* Disable this interrupt. */
> +out_disable:
> +	/* Disable this interrupt. Ignore errors, we need to proceed anyway. */
>  	mpam_disable_msc_ecr(msc);

If we fail to disable the interrupt then I don't think we can claim we handled it.
Shouldn't we, after scheduling broken work, return IRQ_NONE?

Thanks,

Ben

>  
> -	/* Are we racing with the thread disabling MPAM? */
> -	if (!mpam_is_enabled())
> -		return IRQ_HANDLED;
> -
>  	/*
> -	 * Schedule the teardown work. Don't use a threaded IRQ as we can't
> -	 * unregister the interrupt from the threaded part of the handler.
> +	 * Schedule the teardown work. We have to defer it as we can't
> +	 * unregister the interrupt from the threaded part of a handler.
> +	 * Check whether we are racing with the thread disabling MPAM.
>  	 */
> -	mpam_disable_reason = "hardware error interrupt";
> -	schedule_work(&mpam_broken_work);
> +	if (mpam_is_enabled()) {
> +		mpam_disable_reason = "hardware error interrupt";
> +		schedule_work(&mpam_broken_work);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -2736,6 +2750,11 @@ static int mpam_register_irqs(void)
>  		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
>  		/* We anticipate sharing the interrupt with other MSCs */
>  		if (irq_is_percpu(irq)) {
> +			if (msc->iface != MPAM_IFACE_MMIO) {
> +				dev_err(&msc->pdev->dev,
> +					"Only MMIO MSCs can use per-CPU interrupts\n");
> +				return -EINVAL;
> +			}
>  			err = request_percpu_irq(irq, &mpam_ppi_handler,
>  						 "mpam:msc:error",
>  						 msc->error_dev_id);
> @@ -2747,9 +2766,24 @@ static int mpam_register_irqs(void)
>  					       &_enable_percpu_irq, &irq,
>  					       true);
>  		} else {
> -			err = devm_request_irq(&msc->pdev->dev, irq,
> -					       &mpam_spi_handler, IRQF_SHARED,
> -					       "mpam:msc:error", msc);
> +			irq_handler_t hard, threaded;
> +
> +			/*
> +			 * MPAM-Fb needs a sleepable context for the MSC
> +			 * accesses, whereas MMIO requires at least a
> +			 * non-migrateable context for the processor ID check.
> +			 */
> +			if (msc->iface == MPAM_IFACE_MMIO) {
> +				hard = &mpam_spi_handler;
> +				threaded = NULL;
> +			} else {
> +				hard = NULL;
> +				threaded = &mpam_spi_handler;
> +			}
> +			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
> +							hard, threaded,
> +							IRQF_SHARED | IRQF_ONESHOT,
> +							"mpam:msc:error", msc);
>  			if (err)
>  				return err;
>  		}

