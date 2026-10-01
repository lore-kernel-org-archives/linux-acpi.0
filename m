Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192A4A260F;
	Thu,  1 Oct 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866884; cv=none; b=dsh9IQD0s4+T3ubAu9o63MkefAJ3xuNnbToxJhfumjqBswUml3/h9+bH8qZTMOBTfuCnUpQi3cUeb9jMCpGsVVb9hdtxEXIx1K0+Cvoo2FhivfVriNl+cc2gfIPaKrfvf16W6srpFIVa3mnc+a5CnmfHrzU2gpM9josiwwGebCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866884; c=relaxed/simple;
	bh=XTVRVF8m0N+oPT7x4//CBmcmJrGUeaN4+yGD8CNBiOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+8Jl/Cyv+3/XMoB37zvrMqKa+/EsIuojlezgGSwIHsfqcajsG9ETjbSab3KXu5nWEOfZWSN2tf/2TMf93Sly94Rc5M3V7vLIjCwfioozpyghg3vWr0B2TlMJYIaKQr1ffDJCLpaZENk0FWp4BO4jv0UhUDuM9DGcE+MddeoVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G/j4cpma; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G/j4cpma"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD88E497;
	Thu,  1 Oct 2026 08:01:17 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 953FB3F85F;
	Thu,  1 Oct 2026 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790866881; bh=XTVRVF8m0N+oPT7x4//CBmcmJrGUeaN4+yGD8CNBiOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G/j4cpmaNURwJkDqE/EaZyyFQYGzqEP++n8HFWe72Pw+38oyxBYNXYyXPa1SEW/AB
	 k1nn88RJyGZFpJgREFG+BIQtYTl3gdp/xFuMGoFJMvEVsYxwrIBfOf51IalmSMHgsG
	 Zsaxu2rNyH47XphizEDyGo3TUU7P67Y5FcEeFQ5w=
Message-ID: <4cf07f55-9fe0-4083-bd4f-3ee1a2b85753@arm.com>
Date: Thu, 1 Oct 2026 17:01:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/13] arm_mpam: propagate MSC access errors for
 interrupt control
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260924152739.2865510-1-andre.przywara@arm.com>
 <20260924152739.2865510-9-andre.przywara@arm.com>
 <20260924152017.00004ec8@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260924152017.00004ec8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 9/25/26 00:20, Jonathan Cameron wrote:
> On Thu, 24 Sep 2026 17:27:34 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> Allow the functions dealing with interrupt registration and enablement
>> to check for and return errors, and propagate MSC read and write errors
>> from the lower level up.
>> This does not cover the IRQ handler yet, as this needs some more
>> attention.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
> 
> A few trivial things below.  Anyhow, I don't really care about them so

Your comments make sense, and since they shrink the diff, I am all for 
them. Thanks for the tag!

Cheers,
Andre
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
>> ---
>>   drivers/resctrl/mpam_devices.c | 31 +++++++++++++++----------------
>>   1 file changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 558efab75f911..eb26c25b9f970 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1105,7 +1105,9 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>   	}
>>   
>>   	/* Clear any stale errors */
>> -	mpam_msc_clear_esr(msc);
>> +	ret = mpam_msc_clear_esr(msc);
>> +	if (ret)
>> +		return ret;
>>   
>>   	spin_lock(&partid_max_lock);
>>   	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
>> @@ -2668,9 +2670,7 @@ static int mpam_enable_msc_ecr(void *_msc)
>>   {
>>   	struct mpam_msc *msc = _msc;
>>   
>> -	__mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
>> -
>> -	return 0;
>> +	return __mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
>>   }
>>   
>>   /* This can run in mpam_disable(), and the interrupt handler on the same CPU */
>> @@ -2678,9 +2678,7 @@ static int mpam_disable_msc_ecr(void *_msc)
>>   {
>>   	struct mpam_msc *msc = _msc;
>>   
>> -	__mpam_write_reg(msc, MPAMF_ECR, 0);
>> -
>> -	return 0;
>> +	return __mpam_write_reg(msc, MPAMF_ECR, 0);
>>   }
>>   
>>   static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>> @@ -2777,11 +2775,13 @@ static int mpam_register_irqs(void)
>>   				return err;
>>   		}
>>   
>> -		mutex_lock(&msc->error_irq_lock);
>> -		msc->error_irq_req = true;
>> -		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
>> -		msc->error_irq_hw_enabled = true;
>> -		mutex_unlock(&msc->error_irq_lock);
>> +		scoped_guard(mutex, &msc->error_irq_lock) {
>> +			msc->error_irq_req = true;
>> +			err = mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
>> +			if (err)
>> +				return err;
>> +			msc->error_irq_hw_enabled = true;
>> +		}
> 
> Scope ends here so unless something else gets added in later patches, you
> could just use a guard() and reduce the noise.
> 
>>   	}
>>   
>>   	return 0;
>> @@ -2800,10 +2800,10 @@ static void mpam_unregister_irqs(void)
>>   		if (irq <= 0)
>>   			continue;
>>   
>> -		mutex_lock(&msc->error_irq_lock);
> 
> Given you don't return early as a result this is an unrelated change. I don't
> really mind but in ideal world would be a separate patch.
> 
>> +		guard(mutex)(&msc->error_irq_lock);
>>   		if (msc->error_irq_hw_enabled) {
>> -			mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
>> -			msc->error_irq_hw_enabled = false;
>> +			if (!mpam_touch_msc(msc, mpam_disable_msc_ecr, msc))
>> +				msc->error_irq_hw_enabled = false;
>>   		}
>>   
>>   		if (msc->error_irq_req) {
>> @@ -2815,7 +2815,6 @@ static void mpam_unregister_irqs(void)
>>   			}
>>   			msc->error_irq_req = false;
>>   		}
>> -		mutex_unlock(&msc->error_irq_lock);
>>   	}
>>   }
>>   
> 

