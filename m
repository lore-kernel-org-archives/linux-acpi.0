Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA3B27A123;
	Thu,  9 Jul 2026 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603631; cv=none; b=lHdFknxUMBHnLKfX2H6Rg6iUzd21icJk7eqkg/Eq83R97w21hHsFNbNzNgdcp39dSSCOoivmFQWM7C6pVCjc1M4OTiOZXT6IeillZ+XzuZZX+Thql8pms6Md7ImQOdLBemp6IHo0fZUYIukONgDM9Zn2UaQgL1lZp8nSMWwu7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603631; c=relaxed/simple;
	bh=/vSW9G273Fx+u6eCWpvDQgVYx18uDGd8bVORrtrVlbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+/hk+sUCfihcnYGJoJpzce7DPzcsh9CuUk/AyAB3izFbOkDBJbVXpswHE5wFlotnVhF+EIa2s7TguIYYVZPb9/yrkgxQFzmToUg5Fj3t1PuZzdxLBr8tF67oO6f0+Kye0JHXATgT4VRLrbatR3Grf5aqdx2hhmc/kuKjTdZL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a/mi1HRW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a/mi1HRW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C7C3592;
	Thu,  9 Jul 2026 06:27:04 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60A03F85F;
	Thu,  9 Jul 2026 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783603628; bh=/vSW9G273Fx+u6eCWpvDQgVYx18uDGd8bVORrtrVlbg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a/mi1HRW65xRn0e4rWg+yrQmq4my+H0r2jlv6m71zL5t1jDD0wJ9Sn256TuJKDWPv
	 LGkvumaTF6+ycV1AlJspA5tbT37QZxTEfyzyF/QCcfiCxP+ZAogeqUdLeI3Xfbx8ks
	 y7RsrsULJjqUfduL+iHEMSrR69zjbobgD0/oy4Ko=
Message-ID: <7f929d11-d9ee-4a30-a3ea-7a535111b35e@arm.com>
Date: Thu, 9 Jul 2026 14:27:04 +0100
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
 <f418f531-bc0b-4bff-a96f-121034c6c693@arm.com>
 <00e8ba98-735d-4c78-9056-3032036183e7@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <00e8ba98-735d-4c78-9056-3032036183e7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andre,

On 7/9/26 13:06, Andre Przywara wrote:
> Hi,
> 
> On 7/3/26 12:54, Ben Horgan wrote:
>> Hi Andre,
>>
>> On 7/2/26 17:22, Andre Przywara wrote:
>>> When an MPAM MSC gets into an error condition, it can trigger an error
>>> IRQ. We cannot really do much about those errors, but we at least query
>>> and log the error, then disable MPAM functionality.
>>>
>>> This error report relies on reading the MSC's error status register
>>> (ESR) in the IRQ handler, which is not possible for MPAM-Fb based
>>> MSC accesses, since they involve mailbox routines that might sleep.
>>> The same is true for clearing the interrupt at the source, which
>>> requires MSC access.
>>>
>>> For simplicity just skip the ESR read when the MSC is not using direct
>>> MMIO accesses, and just ignore the pending interrupts. We will wrap up
>>> MPAM functionality regardless, knowing the exact error value will not
>>> change that.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>   drivers/resctrl/mpam_devices.c | 35 +++++++++++++++++++---------------
>>>   1 file changed, 20 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/
>>> mpam_devices.c
>>> index b858ff389bff..4a088e6cd235 100644
>>> --- a/drivers/resctrl/mpam_devices.c
>>> +++ b/drivers/resctrl/mpam_devices.c
>>> @@ -2639,7 +2639,7 @@ static int mpam_disable_msc_ecr(void *_msc)
>>>     static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>>>   {
>>> -    u64 reg;
>>> +    u64 reg = 0;
>>>       u16 partid;
>>>       u8 errcode, pmg, ris;
>>>   @@ -2648,25 +2648,30 @@ static irqreturn_t __mpam_irq_handler(int
>>> irq, struct mpam_msc *msc)
>>>                          &msc->accessibility)))
>>>           return IRQ_NONE;
>>>   -    mpam_msc_read_esr(msc, &reg);
>>> +    /* MPAM-Fb MSC accesses cannot be done in atomic context. */
>>> +    if (msc->iface == MPAM_IFACE_MMIO) {
>>> +        mpam_msc_read_esr(msc, &reg);
>>>   -    errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
>>> -    if (!errcode)
>>> -        return IRQ_NONE;
>>> +        errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
>>> +        if (!errcode)
>>> +            return IRQ_NONE;
>>>   -    /* Clear level triggered irq */
>>> -    mpam_msc_clear_esr(msc);
>>> +        /* Clear level triggered irq */
>>> +        mpam_msc_clear_esr(msc);
>>>   -    partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
>>> -    pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
>>> -    ris = FIELD_GET(MPAMF_ESR_RIS, reg);
>>> +        partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
>>> +        pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
>>> +        ris = FIELD_GET(MPAMF_ESR_RIS, reg);
>>>   -    pr_err_ratelimited("error irq from msc:%u '%s', partid:%u,
>>> pmg: %u, ris: %u\n",
>>> -               msc->id, mpam_errcode_names[errcode], partid, pmg,
>>> -               ris);
>>> +        pr_err_ratelimited("error irq from msc:%u '%s', partid:%u,
>>> pmg: %u, ris: %u\n",
>>> +                   msc->id, mpam_errcode_names[errcode], partid,
>>> +                   pmg, ris);
>>>   -    /* Disable this interrupt. */
>>> -    mpam_disable_msc_ecr(msc);
>>> +        /* Disable this interrupt. */
>>> +        mpam_disable_msc_ecr(msc);
>>
>> As an error interrupt is final can we just disable the IRQ?
> 
> Doing that should be covered by mpam_unregister_irqs() as part of the
> mpam_broken_work, shouldn't it? Or do you want to do it earlier?


I think leaving it to mpam_broken_work risks having the hard irq handler
run again and again once we get an error interrupt. I'm just looking at
the code today but I think this is analogous to using IRQF_ONESHOT to
mask the interrupt until the threaded handler is finished.

> 
>> Is it
>> useful? I see there is a function disable_irq_no_sync().
> 
> If we want to do it earlier, the _nosync variant sounds promising,
> although the comment talks about it being nested, so I guess it would
> need to be balanced? Which might be tricky here, since I guess the IRQ
> would be disabled again in mpam_unregister_irqs()?

mpam_unregister_irqs() disables the interrupt by clearing the msc enable
in mpam_disable_msc_ecr() rather than disabling by irq. I don't see how
this would cause a problem. Or does free_percpu_irq() or devm_free_irq()
do something incompatible?

> 
>>> +    } else {
>>> +        pr_err_ratelimited("unknown error irq from msc:%u\n", msc->id);
>>
>> Should we report by irq number?
>> As MSC may share interrupts we don't know which MSC caused the error irq
>> at this point. On MMIO platforms we read the ESR to establish this.
> 
> I see what you mean, though I am not sure if the user would be able to
> make sense of any interrupt number? I would put it in anyway, more
> information doesn't hurt.
> 
> Cheers,
> Andre
> 
>> Thanks,
>>
>> Ben
>>
>>> +    }
>>>         /* Are we racing with the thread disabling MPAM? */
>>>       if (!mpam_is_enabled())
>>
> 

