Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C12FFF8F;
	Thu,  9 Jul 2026 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598823; cv=none; b=BI5zXvgredXiqeAO4cUVAzKbCvltxYAKPwf3HFwroUytiClCqqw/6pcBt4updzm+L/KAZTCOsVk6RND4zgCo/ClE8j4xjxfA2NBz/1XVcei7+FRgC9fcGH/35ExFDyXsqfhtHO3ZjxlfmEdFpur57fzFJAAfzU2QHVjs5azhTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598823; c=relaxed/simple;
	bh=jPtXJeS/69sVHJHwLW5PFf9uHtm+WegMDEkeOn5/+UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxFJKPBVTVen/8rghrxIU7lwBDeeWM+KZN0WJp6tiXo4SgSyjq2jQVTl+lWelgTLLp06s2OPVWDAsfwU42RuEAmDWWHkgqZJNNRb3JcpRfB+N1Z3TX/l7E7I8rp8Zy0OPZ0hISsqqzUl+To1A4x4uicyNsq/zhGmPxvXcHAmpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jwhKsbjB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jwhKsbjB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D264F3569;
	Thu,  9 Jul 2026 05:06:56 -0700 (PDT)
Received: from [10.41.150.148] (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05E973F66F;
	Thu,  9 Jul 2026 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783598821; bh=jPtXJeS/69sVHJHwLW5PFf9uHtm+WegMDEkeOn5/+UY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jwhKsbjBWbONaR3cbE8YYLNW83WLz7CITsLvHnWNTKklG84IrXtK14DRnZ1whfZhx
	 cWi+Wg5k7sDU+z15Rm1DNs6WIN6c8gdhHNorK38niMOi0pr7VHopxOKO7bwwQfmgsv
	 wsWsFIz989IDWMiUSTMHFD5ThS1olDSLQ2yFElPE=
Message-ID: <00e8ba98-735d-4c78-9056-3032036183e7@arm.com>
Date: Thu, 9 Jul 2026 14:06:56 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] arm_mpam: prevent MPAM-Fb accesses inside IRQ
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
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260702162229.4008659-1-andre.przywara@arm.com>
 <20260702162229.4008659-15-andre.przywara@arm.com>
 <f418f531-bc0b-4bff-a96f-121034c6c693@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <f418f531-bc0b-4bff-a96f-121034c6c693@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/3/26 12:54, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/2/26 17:22, Andre Przywara wrote:
>> When an MPAM MSC gets into an error condition, it can trigger an error
>> IRQ. We cannot really do much about those errors, but we at least query
>> and log the error, then disable MPAM functionality.
>>
>> This error report relies on reading the MSC's error status register
>> (ESR) in the IRQ handler, which is not possible for MPAM-Fb based
>> MSC accesses, since they involve mailbox routines that might sleep.
>> The same is true for clearing the interrupt at the source, which
>> requires MSC access.
>>
>> For simplicity just skip the ESR read when the MSC is not using direct
>> MMIO accesses, and just ignore the pending interrupts. We will wrap up
>> MPAM functionality regardless, knowing the exact error value will not
>> change that.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 35 +++++++++++++++++++---------------
>>   1 file changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index b858ff389bff..4a088e6cd235 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -2639,7 +2639,7 @@ static int mpam_disable_msc_ecr(void *_msc)
>>   
>>   static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>>   {
>> -	u64 reg;
>> +	u64 reg = 0;
>>   	u16 partid;
>>   	u8 errcode, pmg, ris;
>>   
>> @@ -2648,25 +2648,30 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>>   					   &msc->accessibility)))
>>   		return IRQ_NONE;
>>   
>> -	mpam_msc_read_esr(msc, &reg);
>> +	/* MPAM-Fb MSC accesses cannot be done in atomic context. */
>> +	if (msc->iface == MPAM_IFACE_MMIO) {
>> +		mpam_msc_read_esr(msc, &reg);
>>   
>> -	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
>> -	if (!errcode)
>> -		return IRQ_NONE;
>> +		errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
>> +		if (!errcode)
>> +			return IRQ_NONE;
>>   
>> -	/* Clear level triggered irq */
>> -	mpam_msc_clear_esr(msc);
>> +		/* Clear level triggered irq */
>> +		mpam_msc_clear_esr(msc);
>>   
>> -	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
>> -	pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
>> -	ris = FIELD_GET(MPAMF_ESR_RIS, reg);
>> +		partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
>> +		pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
>> +		ris = FIELD_GET(MPAMF_ESR_RIS, reg);
>>   
>> -	pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
>> -			   msc->id, mpam_errcode_names[errcode], partid, pmg,
>> -			   ris);
>> +		pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
>> +				   msc->id, mpam_errcode_names[errcode], partid,
>> +				   pmg, ris);
>>   
>> -	/* Disable this interrupt. */
>> -	mpam_disable_msc_ecr(msc);
>> +		/* Disable this interrupt. */
>> +		mpam_disable_msc_ecr(msc);
> 
> As an error interrupt is final can we just disable the IRQ?

Doing that should be covered by mpam_unregister_irqs() as part of the 
mpam_broken_work, shouldn't it? Or do you want to do it earlier?

> Is it
> useful? I see there is a function disable_irq_no_sync().

If we want to do it earlier, the _nosync variant sounds promising, 
although the comment talks about it being nested, so I guess it would 
need to be balanced? Which might be tricky here, since I guess the IRQ 
would be disabled again in mpam_unregister_irqs()?

>> +	} else {
>> +		pr_err_ratelimited("unknown error irq from msc:%u\n", msc->id);
> 
> Should we report by irq number?
> As MSC may share interrupts we don't know which MSC caused the error irq
> at this point. On MMIO platforms we read the ESR to establish this.

I see what you mean, though I am not sure if the user would be able to 
make sense of any interrupt number? I would put it in anyway, more 
information doesn't hurt.

Cheers,
Andre

> Thanks,
> 
> Ben
> 
>> +	}
>>   
>>   	/* Are we racing with the thread disabling MPAM? */
>>   	if (!mpam_is_enabled())
> 

