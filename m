Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812F38551D;
	Thu, 30 Jul 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413250; cv=none; b=XBlTRBEZ++dWQfGwaObWKea7z3sITqHmggi3UBD/XUYC3CjQmrXh/MKC/wSV/YF86fadyzS5PeSeFGscPGy02XgWKJZPxeE/zAtWtoc5lsujNmOAu2jq2sRkk+swOlcMe6gjHQTGT3UgVoDJJoMZVnfAdTeBIdb+lVuDGT8zXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413250; c=relaxed/simple;
	bh=21ia43FmNLq2y0FsA3F0kaUAm6yUkF+pRr+vqWLTMhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPZ0n6keOK6LbgVvG0B2JcpeiGWnYay6A7Sly2upFygsTx4OlO9h0AwYF55mI0GlnuFOSbhzsbaSZ4/mAo+lNVn9eM9NLzWmEeDTBgrK5MpMbFFRYhcoY2zLAGEpUGQusnwKlSoFQ+aTZYgtLqMU8O/ZaRIhPT/3BBjFrUJyf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fHd8F1UU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fHd8F1UU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B94CE1684;
	Thu, 30 Jul 2026 05:07:23 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E3A53F86F;
	Thu, 30 Jul 2026 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785413247; bh=21ia43FmNLq2y0FsA3F0kaUAm6yUkF+pRr+vqWLTMhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHd8F1UUUR0YRIy6hArlDGYNvRodLaYi+EqYwlOqad5WU4lPfTCktn4mXh9o/awQO
	 cBnjqKbMk3bXO/S8JHjdVzufNeRumBM3nfZ50IkaDlRSQjNpiaYoz0xwjFgh4P1fQj
	 V6im/bwI3P5MwbjPOnLZ2ZQWI8WWeDW123g7Mxwc=
Message-ID: <691560ab-d8a3-49ef-a5d8-e2306e381748@arm.com>
Date: Thu, 30 Jul 2026 14:07:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] arm_mpam: change error IRQ to use a threaded IRQ
 handler
To: Ben Horgan <ben.horgan@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
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
References: <20260729134124.2506269-1-andre.przywara@arm.com>
 <20260729134124.2506269-10-andre.przywara@arm.com>
 <881a3224-fb19-4ded-ae7e-3f7ae139fe52@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <881a3224-fb19-4ded-ae7e-3f7ae139fe52@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 7/29/26 17:23, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/29/26 14:41, Andre Przywara wrote:
>> When an MPAM MSC gets into an error condition, it can trigger an error
>> IRQ. We cannot really do much about those errors, but we at least query
>> and log the error, then disable MPAM functionality.
>>
>> This error report relies on reading the MSC's error status register
>> (ESR) in the IRQ handler, which is not possible for MPAM-Fb based
>> MSC accesses, since they involve mailbox routines that might sleep.
>> The same is true for clearing the interrupt at the source, which
>> requires an MSC access as well.
>>
>> Change the error IRQ to use a threaded IRQ handler, with an empty hard
>> IRQ routine, and doing all the MSC accesses (to access the status and
>> disable the IRQ line) in the threaded part. The change is minimal, we
>> just check for the first MSC access error and bail out early.
>> Also forbid per-CPU interrupts (PPIs) for MPAM-Fb, as we cannot use a
>> threaded IRQ here.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 42 ++++++++++++++++++++++------------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index abe1e628928f..e535603d2c7d 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -2659,9 +2659,11 @@ static int mpam_disable_msc_ecr(void *_msc)
>>   	return 0;
>>   }
>>   
>> +/* threaded IRQ handler for shared IRQs, to allow MPAM-Fb accesses to sleep */
> 
> This comment seems incomplete. The same handler is used for the PPI hardirq.

Yes, I failed to convey that it's only a threaded handler for shared 
IRQs. Reworded that to cover both cases.

>>   static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>>   {
>>   	u64 reg;
>> +	int ret;
>>   	u16 partid;
>>   	u8 errcode, pmg, ris;
>>   
>> @@ -2670,13 +2672,19 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>>   					   &msc->accessibility)))
>>   		return IRQ_NONE;
>>   
>> -	mpam_msc_read_esr(msc, &reg);
>> +	ret = mpam_msc_read_esr(msc, &reg);
> 
> This is also called for MMIO accesses and the checks in the reads and writes call smp_processor_id()
> which will give warnings if we are preemptible. There is also a similar to check higher up in this
> handler. We need to choose in what context we call things based on whether we are using MMIO
> accesses or MPAM-Fb.

Alright, after some off-line discussion we settled for keeping a 
hard-IRQ handler for MMIO, and just use a threaded handler for MPAM-Fb. 
Should solve this problem elegantly.

Thanks for pointing this out!

Cheers,
Andre

> 
> Thanks,
> 
> Ben
> 
>> +	if (ret) {
>> +		pr_err_ratelimited("unknown error irq from msc:%u\n", msc->id);
>> +
>> +		/* Try out best here ... */
>> +		goto out_disable;
>> +	}
>>   
>>   	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
>>   	if (!errcode)
>>   		return IRQ_NONE;
>>   
>> -	/* Clear level triggered irq */
>> +	/* Clear level triggered irq. Ignore errors, we need to proceed. */
>>   	mpam_msc_clear_esr(msc);
>>   
>>   	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
>> @@ -2687,19 +2695,19 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>>   			   msc->id, mpam_errcode_names[errcode], partid, pmg,
>>   			   ris);
>>   
>> -	/* Disable this interrupt. */
>> +out_disable:
>> +	/* Disable this interrupt. Ignore errors, we need to proceed anyway. */
>>   	mpam_disable_msc_ecr(msc);
>>   
>> -	/* Are we racing with the thread disabling MPAM? */
>> -	if (!mpam_is_enabled())
>> -		return IRQ_HANDLED;
>> -
>>   	/*
>> -	 * Schedule the teardown work. Don't use a threaded IRQ as we can't
>> -	 * unregister the interrupt from the threaded part of the handler.
>> +	 * Schedule the teardown work. We have to defer it as we can't
>> +	 * unregister the interrupt from the threaded part of a handler.
>> +	 * Check whether we are racing with the thread disabling MPAM.
>>   	 */
>> -	mpam_disable_reason = "hardware error interrupt";
>> -	schedule_work(&mpam_broken_work);
>> +	if (mpam_is_enabled()) {
>> +		mpam_disable_reason = "hardware error interrupt";
>> +		schedule_work(&mpam_broken_work);
>> +	}
>>   
>>   	return IRQ_HANDLED;
>>   }
>> @@ -2735,6 +2743,11 @@ static int mpam_register_irqs(void)
>>   		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
>>   		/* We anticipate sharing the interrupt with other MSCs */
>>   		if (irq_is_percpu(irq)) {
>> +			if (msc->iface != MPAM_IFACE_MMIO) {
>> +				dev_err(&msc->pdev->dev,
>> +					"Only MMIO MSCs can use per-CPU interrupts\n");
>> +				return -EINVAL;
>> +			}
>>   			err = request_percpu_irq(irq, &mpam_ppi_handler,
>>   						 "mpam:msc:error",
>>   						 msc->error_dev_id);
>> @@ -2746,9 +2759,10 @@ static int mpam_register_irqs(void)
>>   					       &_enable_percpu_irq, &irq,
>>   					       true);
>>   		} else {
>> -			err = devm_request_irq(&msc->pdev->dev, irq,
>> -					       &mpam_spi_handler, IRQF_SHARED,
>> -					       "mpam:msc:error", msc);
>> +			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
>> +							NULL, &mpam_spi_handler,
>> +							IRQF_SHARED | IRQF_ONESHOT,
>> +							"mpam:msc:error", msc);
>>   			if (err)
>>   				return err;
>>   		}
> 

