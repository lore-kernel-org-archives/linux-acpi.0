Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3996B40B6EE;
	Mon, 20 Jul 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563080; cv=none; b=nmI31QTEn7sQyCDRF/aUBDr1Bhfz9cyloLtG+JRDoEM8YkqHJI2gpdFfHaZvIz76Eq/F0PeL8skBPLIqgsVynfxOy3WLvwEpqSX+RKbC1Ou3nn7MiaLczj27yORE3RmYFlJ76jQ62pORLE9uYCx0T6FA0ixSOQini+nNXrYNWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563080; c=relaxed/simple;
	bh=+Ta08LuTdVVNYuqpibbCapitJeFJ0YVrX75P7ECoc9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jx2vMpw4duNQJ0GjAUt26jMIqyxXhAXiroinZ5TMf8m3TqBSpgsAgUc2agnNxtd+Q6HFiV8EXDuKfAFWb3yT3hx6cLxrNmzcdKxTnzD3euPA7+LMRRS7ZKx3rapBaHQMWvJRfoQECysru4hcCVHwweBomq/qljt7pgkoZnJRmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oCO3rvvN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oCO3rvvN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AF7C1476;
	Mon, 20 Jul 2026 08:57:53 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D47733F86F;
	Mon, 20 Jul 2026 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784563077; bh=+Ta08LuTdVVNYuqpibbCapitJeFJ0YVrX75P7ECoc9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oCO3rvvNXB1hJ4RyHiYI9ouQxrEjOujADv4lS7MvJ7CCG5TSUAqoXBVsMzL0bsR9a
	 c/GB7afxQaOzltKc06bUTCoGTDbtlXnUJZcwk46ftsjQNlHNCfvwWZekQljVRZBRy0
	 +CRaBRT8OwJ+MZf5KLtfETX0rqMYPAIq0wb0FmXY=
Message-ID: <f83038fe-e56d-48dd-a0cc-25f5e240cf49@arm.com>
Date: Mon, 20 Jul 2026 17:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/16] arm_mpam: propagate MSC read errors for state
 saving functions
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
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-9-andre.przywara@arm.com>
 <20260710120054.000035dc@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260710120054.000035dc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 7/10/26 21:00, Jonathan Cameron wrote:
> On Fri, 10 Jul 2026 16:45:12 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> Allow the mpam_save_mbwu_state() function to return an error, and
>> propagate read errors from the lower level up.
> 
> I'm not following why propagating errors is related to the
> if (val != MSMON___L_NRDY)
> as nothing in this patch is changing val.

This MSMON__L_NRDY bit is some kind of software error condition, that 
gets set in mpam_msc_read_mbwu_l() to indicate an unstable value 
condition. In the lack of an error return value this was somewhat 
shoehorned into the return value, and now we can get rid of that kludge, 
since we gained a proper error return value. At least that was my hope, 
but maybe I missed something.

Cheers,
Andre

> 
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 30 +++++++++++++++++++-----------
>>   1 file changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 530ac0fe97b5..b2ecaba29fcc 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1782,7 +1782,7 @@ static int mpam_save_mbwu_state(void *arg)
>>   {
>>   	int i;
>>   	u64 val;
>> -	int ret = 0;
>> +	int ret;
>>   	struct mon_cfg *cfg;
>>   	u32 cur_flt, cur_ctl, mon_sel;
>>   	struct mpam_msc_ris *ris = arg;
>> @@ -1799,8 +1799,12 @@ static int mpam_save_mbwu_state(void *arg)
>>   		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
>>   			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>>   		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
>> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
>> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
>> +		if (ret)
>> +			goto out_unlock;
>> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
>> +		if (ret)
>> +			goto out_unlock;
>>   		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>>   
>>   		if (mpam_ris_has_mbwu_long_counter(ris)) {
>> @@ -1811,20 +1815,24 @@ static int mpam_save_mbwu_state(void *arg)
>>   		} else {
>>   			u32 val32;
>>   
>> -			mpam_read_monsel_reg(msc, MBWU, &val32);
>> +			ret = mpam_read_monsel_reg(msc, MBWU, &val32);
>> +			if (ret)
>> +				goto out_unlock;
>> +
>>   			val = val32;
>>   			mpam_write_monsel_reg(msc, MBWU, 0);
>>   		}
>>   
>> -		cfg->mon = i;
>> -		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
>> -		cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
>> -		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
>> -		mbwu_state->correction += val;
>> -		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
>> +		if (val != MSMON___L_NRDY) {
> 
> with ACQUIRE() you can just do
> 		if (val == MS_MON__L_NRDY)
> 			return;
> 
> and leave the rest where it was.
> However I don't actually see what this has to do wiht the main purpose of the
> patch to propagate errors. Perhaps a bit more detail in the commit message.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> +			cfg->mon = i;
>> +			cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
>> +			cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
>> +			cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
>> +			mbwu_state->correction += val;
>> +			mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
>> +		}
>>   		mpam_mon_sel_unlock(msc);
>>   	}
>> -
>>   	return 0;
>>   
>>   out_unlock:
> 

