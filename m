Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A873E2BDC0E;
	Fri, 11 Sep 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143804; cv=none; b=S6PctCZVRuULtidtwJgOr+ut4uw3Im4fRGVrRUdom+S94MOK4xW5miP/sqtGVkVrAcxEHeuMMzzTaWpcqlDQNBPiYVQJqZVWVsy5d1Z6STpbtjdtaHRSL+aZs2Yos5ABrrHxljyp1BzVqduNmxvET4kaNU2orllwROM+rp+VHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143804; c=relaxed/simple;
	bh=cF2rHoPHNtjoruLUsmFFA7ElnvzZvWiENPhyyCo2U5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlPkncr1LiX8oEAy/pJ3BG/30YpUo6xI3KboLOfKVcHtlIWyLEVSKW3F3oQWhMIs7jKLHtsy9P+bjL3eMXoOIUQ89JQmV4LkfmOQHFZO+XNyDdQ2CYAdlqs+hCVzg0xB7r8JlazXoT7m2Fckp/RfGyckspJKsYc0Ke2YKgKZg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pw9zKi+/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pw9zKi+/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ABE32BC3;
	Fri, 11 Sep 2026 09:23:18 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19FF43F7B4;
	Fri, 11 Sep 2026 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789143802; bh=cF2rHoPHNtjoruLUsmFFA7ElnvzZvWiENPhyyCo2U5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pw9zKi+/2eQ2NOfn6/sMAztLIfuDRe4HCfj8AQSTTYeoXZnCahELPnENpWUd4PbfF
	 fkzHla2qIVd0I3QS6KXvmciOV4HOpiZA6ExqiaqfYeD9NW784K5Pgeoph1Owv44hGR
	 zWnCmmi9zr6zlN8gyvxB8GbrjujNUqc6Lv8qWqhg=
Message-ID: <37db65c7-db4a-4085-a586-62931d73299f@arm.com>
Date: Fri, 11 Sep 2026 17:23:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/14] arm_mpam: propagate MSC access errors for
 interrupt control
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
 Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260911112835.714162-1-andre.przywara@arm.com>
 <20260911112835.714162-9-andre.przywara@arm.com>
 <89a13b60-a1fe-442f-ab0d-b0d37a118ad1@arm.com>
 <a305546a-29f4-45fb-a3e6-09a051733a2a@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <a305546a-29f4-45fb-a3e6-09a051733a2a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andre,

On 11/09/2026 17:19, Andre Przywara wrote:
> Hi Ben,
> 
> On 9/11/26 16:26, Ben Horgan wrote:
>> Hi Andre,
>>
>> On 11/09/2026 12:28, Andre Przywara wrote:
>>> Allow the functions dealing with interrupt registration and enablement
>>> to check for and return errors, and propagate MSC read and write errors
>>> from the lower level up.
>>> This does not cover the IRQ handler yet, as this needs some more
>>> attention.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
>>
>> Commenting here as this is the last error propagation patch. I think we need a clean boundary for
>> the error propagation. As you said a while back I think we can propagate error for all non-static
>> functions from mpam_devices.c and the callers can discard the errors if appropriate. For instance,
>> mpam_reset_class_locked() should propagate any error.
> 
> So I checked all non-static functions in mpam_devices.c: most either don't deal with MSCs at all, or
> already propagate errors.
> The two outliers are mpam_disable(), which must be "void", due to it being called via DECLARE_WORK,
> and mpam_reset_class_locked(), as you write above. The latter is a bit sad, because the caller is
> void, so any errors would be discarded there anyway, but for the sake of completeness we should
> indeed propagate here.
> 
> And I guess it doesn't make sense to continue the vMSC or RIS list iterations after detecting the
> first error, but we just bail out immediately? Because any error would trigger mpam_disable() anyway?

Yeah, bailing early makes sense to me.

Thanks,

Ben

> 
> Cheers,
> Andre
> 
> 
>>
>> Thanks,
>>
>> Ben
>>
>>> ---
>>>   drivers/resctrl/mpam_devices.c | 31 +++++++++++++++----------------
>>>   1 file changed, 15 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>>> index 558efab75f911..eb26c25b9f970 100644
>>> --- a/drivers/resctrl/mpam_devices.c
>>> +++ b/drivers/resctrl/mpam_devices.c
>>> @@ -1105,7 +1105,9 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>>       }
>>>         /* Clear any stale errors */
>>> -    mpam_msc_clear_esr(msc);
>>> +    ret = mpam_msc_clear_esr(msc);
>>> +    if (ret)
>>> +        return ret;
>>>         spin_lock(&partid_max_lock);
>>>       mpam_partid_max = min(mpam_partid_max, msc->partid_max);
>>> @@ -2668,9 +2670,7 @@ static int mpam_enable_msc_ecr(void *_msc)
>>>   {
>>>       struct mpam_msc *msc = _msc;
>>>   -    __mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
>>> -
>>> -    return 0;
>>> +    return __mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
>>>   }
>>>     /* This can run in mpam_disable(), and the interrupt handler on the same CPU */
>>> @@ -2678,9 +2678,7 @@ static int mpam_disable_msc_ecr(void *_msc)
>>>   {
>>>       struct mpam_msc *msc = _msc;
>>>   -    __mpam_write_reg(msc, MPAMF_ECR, 0);
>>> -
>>> -    return 0;
>>> +    return __mpam_write_reg(msc, MPAMF_ECR, 0);
>>>   }
>>>     static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>>> @@ -2777,11 +2775,13 @@ static int mpam_register_irqs(void)
>>>                   return err;
>>>           }
>>>   -        mutex_lock(&msc->error_irq_lock);
>>> -        msc->error_irq_req = true;
>>> -        mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
>>> -        msc->error_irq_hw_enabled = true;
>>> -        mutex_unlock(&msc->error_irq_lock);
>>> +        scoped_guard(mutex, &msc->error_irq_lock) {
>>> +            msc->error_irq_req = true;
>>> +            err = mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
>>> +            if (err)
>>> +                return err;
>>> +            msc->error_irq_hw_enabled = true;
>>> +        }
>>>       }
>>>         return 0;
>>> @@ -2800,10 +2800,10 @@ static void mpam_unregister_irqs(void)
>>>           if (irq <= 0)
>>>               continue;
>>>   -        mutex_lock(&msc->error_irq_lock);
>>> +        guard(mutex)(&msc->error_irq_lock);
>>>           if (msc->error_irq_hw_enabled) {
>>> -            mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
>>> -            msc->error_irq_hw_enabled = false;
>>> +            if (!mpam_touch_msc(msc, mpam_disable_msc_ecr, msc))
>>> +                msc->error_irq_hw_enabled = false;
>>>           }
>>>             if (msc->error_irq_req) {
>>> @@ -2815,7 +2815,6 @@ static void mpam_unregister_irqs(void)
>>>               }
>>>               msc->error_irq_req = false;
>>>           }
>>> -        mutex_unlock(&msc->error_irq_lock);
>>>       }
>>>   }
>>>   
>>
> 

