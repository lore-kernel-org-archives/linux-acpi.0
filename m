Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946D2F12A1;
	Tue, 28 Jul 2026 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252915; cv=none; b=GmpSuCn8f/gW2BqiwNV86xM3sBG9SqANSM03rpR2UJlOrSXJolHQFdBecRXn1S8DYXGd38OWL0QhHv7g59OSgcbWnEoNwQtmbJiOCzm7Ea/filUnzPfIu4yVvUZ5xajXL/icEjpNeUjixn/KYd6ILqdKk3sWMwZFN5lVLLe/QjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252915; c=relaxed/simple;
	bh=o35aR22hjxn3cvsZtLzIVyQgXimJFv11jll7A6Gyckw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qexJqLslKzUg4xhZ5P3Elm9XDSj+IlAjkb39nLWg01rGtjVPLSbGE76yzveAtUJj8mNAWGxJyuCuwv2Vo41NvhOVWbGRYORLRy565Y9t4H25XdgCS4T58BHzI2vgpyk2Vm+FkJdZhBDgwDAnF+/tMjuK/M74mnELlWHzIWb4rGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NQIpbm4A; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NQIpbm4A"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2190169E;
	Tue, 28 Jul 2026 08:35:07 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A24F63F66F;
	Tue, 28 Jul 2026 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785252911; bh=o35aR22hjxn3cvsZtLzIVyQgXimJFv11jll7A6Gyckw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NQIpbm4Ak+LzXi2jSCRY/87CMWLbQwzUFEYVX+A60UOOcUXAZ+gbu/flKXm3rQ9Be
	 ZFZ76BtNtZmgS74VTkeC+wTW2O9SU68N0WC9km3CUIcNOF4Wph9/jeZoJZKXl60CwX
	 3AjsXk8hGdJSM1m1l6VHMzepiaqs8uSPjmS6jJ4A=
Message-ID: <fb4a7883-2ef5-4ca9-b375-e1a8d3ad111d@arm.com>
Date: Tue, 28 Jul 2026 17:35:07 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] arm_mpam: let low level MSC accessors return an
 error
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-2-andre.przywara@arm.com>
 <20260727231231.62baa831@jic23-huawei>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260727231231.62baa831@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 7/28/26 00:12, Jonathan Cameron wrote:
> On Thu, 23 Jul 2026 17:54:45 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> The upcoming MPAM-Fb support does not use MMIO primitives to access an
>> MSC, but employs a shared-memory/doorbell based firmware protocol.
>> Its complexity means that is must be able to handle errors, whereas we
> 
> that it must
> 
>> always assume an MMIO based MSC access succeeds today.
>>
>> Change the __mpam_read_reg() low level accessor function to return the
>> requested data through a pointer, and return an error code instead.
>> Also change the __mpam_write_reg() accessor function to return an error
>> code. At the moment this is always 0, but this will change with alternative
>> MSC access methods.
> 
> Be consistent on paragraph formatting.  So blank line here.  Check whole
> series for such tiny consistency problems.
> 
>> Change all direct users of those MSC wrappers to comply with the new
>> prototypes, though the errors are not propagated all the way up yet.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Some comments inline.  A few are 'whilst you are here let us make this
> more readable'.  I was in two minds about the temporary lack of handling
> of uninitialised (looking) variables but in the interests of expediency
> I suppose we can rely on the functions never actually failing at this
> point in the series.

I probably should have made this explicit in at least the cover letter, 
but that was the intention: for most of the patches, the lower level 
functions only ever return 0, so no error path will be triggered at this 
point. This allows to code to grow more slowly, and remaining issues are 
then fixed in later patches (7/10-9/10), before only the last patch 
actually activates MPAM-Fb, and introduces the possibility of an error 
return. So there is no real functional change, it's all refactoring.
Interestingly Sashiko missed that, many complaints are about things that 
cannot happen before patch 10/10.

I will add a comment to that effect to the commit message and the cover 
letter.

> I will note that if you did adding the returns from outer calls to inner
> you wouldn't get this problem.  However you might get other problems!

Thanks for the suggestion, I might try it the next time I encounter a 
similar problem! I briefly looked at applying it here, but already 
struggled to identify those outer functions. So I think this "lower 
level first" is still more comprehensible.

>> ---
>>   drivers/resctrl/mpam_devices.c | 204 +++++++++++++++++++++------------
>>   1 file changed, 130 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index b69f99488111..912c21ce7f9f 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
> 
> 
> 
>> -static u64 mpam_msc_read_idr(struct mpam_msc *msc)
>> +static int mpam_msc_read_idr(struct mpam_msc *msc, u64 *res)
>>   {
>> -	u64 idr_high = 0, idr_low;
>> +	u32 idr_high = 0, idr_low;
>> +	int ret;
>>   
>>   	lockdep_assert_held(&msc->part_sel_lock);
>>   
>> -	idr_low = mpam_read_partsel_reg(msc, IDR);
>> -	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
>> -		idr_high = mpam_read_partsel_reg(msc, IDR + 4);
>> +	ret = mpam_read_partsel_reg(msc, IDR, &idr_low);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (FIELD_GET(MPAMF_IDR_EXT, idr_low)) {
>> +		ret = mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
>> +		if (ret)
>> +			return ret;
>> +	}
> As a whilst you are here type of comment. I'd find this more obvious if it were
> 
> 	} else {
> 		idr_high = 0;
> 	}
> 
> rather than assign a default at top of what is now a rather more complex function.

I see what you mean, makes sense.

>>   
>> -	return (idr_high << 32) | idr_low;
>> +	*res = ((u64)idr_high << 32) | idr_low;
>> +
>> +	return 0;
>>   }
> 
> 
>>   
>> -static u64 mpam_msc_read_esr(struct mpam_msc *msc)
>> +static int mpam_msc_read_esr(struct mpam_msc *msc, u64 *res)
>>   {
>> -	u64 esr_high = 0, esr_low;
>> +	u32 esr_high = 0, esr_low;
>> +	int ret;
>>   
>> -	esr_low = __mpam_read_reg(msc, MPAMF_ESR);
>> -	if (msc->has_extd_esr)
>> -		esr_high = __mpam_read_reg(msc, MPAMF_ESR + 4);
>> +	ret = __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
>> +	if (ret)
>> +		return ret;
>>   
>> -	return (esr_high << 32) | esr_low;
>> +	if (msc->has_extd_esr) {
>> +		ret = __mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
>> +		if (ret)
>> +			return ret;
>> +	}
> 
> Same as the other example above.  } else { esr_high = 0; }
> would be slightly clearer now this whole function has gotten more complex.
> 
>> +
>> +	*res = ((u64)esr_high << 32) | esr_low;
>> +
>> +	return 0;
>>   }
>>   
> 
>>   int mpam_register_requestor(u16 partid_max, u8 pmg_max)
>> @@ -774,13 +810,13 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
>>   	mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
>>   
>>   	_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY);
>> -	now = _mpam_read_monsel_reg(msc, MSMON_CSU);
>> +	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
> 
> If an error were to occur and "now" not get assigned, would this being
> accessing undefined data? 

But there will be no error at this point, as __mpam_read_reg() 
unconditionally still returns 0. And this missing error code check will 
be fixed in a later patch, before proper error returns get enabled.

If checking return values doesn't make sense
> in here it should still not result in something static analysis might
> get annoyed by.  This gets cleaned up in next patch so maybe that
> is just about ok.  Alternative would be to just initialize any such
> variables in this patch and drop those initializations in next.
> Doing it just above the code that is going to change anyway would be cleanest.
> 
> 	now = 0;
> 	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
> 
> for example.
> 
> Hmm. I suppose this is a bit of a special case because we know the
> calls don't return errors at this point in the set.
> 
> So whilst I don't like it I'll not insist that you fix all the
> instances of this.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks!

Cheers,
Andre

> 
> 
> 
> 
> 
>>   	can_set = now & MSMON___NRDY;
>>   
>>   	_mpam_write_monsel_reg(msc, MSMON_CSU, 0);
>>   	/* Configuration change to try and coax hardware into setting nrdy */
>>   	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1);
>> -	now = _mpam_read_monsel_reg(msc, MSMON_CSU);
>> +	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
>>   	can_clear = !(now & MSMON___NRDY);

