Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531993BBFB2;
	Mon, 20 Jul 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563073; cv=none; b=X49jgUnGg62sNO+97IeUy1zxI9XU6ngv2uTodfgVdmaCn8/nyVoJJKJZnATeXRcz4THCI/el3P9V+5kG16csbmiJxcKYGHLgF4L12NbHwRWTegIYocXF/jL7McnYcul40LWp6/eQFaT+aHpJYkhlPwiweE3OXgANK2nMGqH33+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563073; c=relaxed/simple;
	bh=9ww7f0PYnEgmYOOmpY2ymfpW2dHK2p9Smdx186oiZO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDpWlN12Qu1Po9V+h7fTP0qClsPEXLfeU+JLAqIZq2iFcGMxrusKt/0H7JTukGFLsy8Roq2/t6BWQBmKfHx9pxAPb8r8fhuh/BdOoxJ2oBaewYwr7idOxyz0Y37G0xtJNXeeATmkcZ8Un0gOcVQB2c3vFDSJY788zQEcwGVoUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SkLsPBP6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SkLsPBP6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18C4E143D;
	Mon, 20 Jul 2026 08:57:45 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A33083F86F;
	Mon, 20 Jul 2026 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784563069; bh=9ww7f0PYnEgmYOOmpY2ymfpW2dHK2p9Smdx186oiZO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SkLsPBP6cBYQTQTr/KYiC8ZO+TW/7yYvMMnaY48czCW5eKskuOt2M07IgTpJ5JNGS
	 v5KCrNYJKtF0rq5GsicBxp6y46Y4sTPmRVfC81dRhJpNmeatpgMBgIk7c2aIPEpPSL
	 fafQP22w5+EdkguH26ftPb91Zy3qr0yzBGv5+Vn4=
Message-ID: <7cf37e20-b62c-4a42-8c10-8db5a5b4cf44@arm.com>
Date: Mon, 20 Jul 2026 17:57:46 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] arm_mpam: __ris_msmon_read(): get rid of nrdy
 special handling
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
 <20260710144520.917375-8-andre.przywara@arm.com>
 <20260710115656.00001345@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260710115656.00001345@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/10/26 20:56, Jonathan Cameron wrote:
> On Fri, 10 Jul 2026 16:45:11 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> Although so far MSC accesses couldn't fail, there is one special
>> condition that would create an error: when the MBWU counter wouldn't be
>> able to read a stable value, we were setting bit 63 to mark this value
>> as unstable, and return this as an error later.
>> Now since the functions can return a proper error value, we can get rid of
>> this kludge and use the return value directly.
>>
>> Remove the "nrdy" error flag variable, and assign -EBUSY to "ret" to handle
>> this case.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Hi Andre
> 
> I'm still fussing about code flow and style :(
> 
> Obviously none of this is that important, but it does help make
> the code more maintainable in the long run.
> 
> Jonathan
> 
>> ---
>>   drivers/resctrl/mpam_devices.c | 38 +++++++++++++++-------------------
>>   1 file changed, 17 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 84a8715464be..530ac0fe97b5 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1306,7 +1306,6 @@ static void __ris_msmon_read(void *arg)
>>   	u64 now;
>>   	int ret;
>>   	u32 now32;
>> -	bool nrdy = false;
>>   	bool config_mismatch;
>>   	bool overflow = false;
>>   	struct mon_read *m = arg;
>> @@ -1371,14 +1370,18 @@ static void __ris_msmon_read(void *arg)
>>   	switch (m->type) {
>>   	case mpam_feat_msmon_csu:
>>   		ret = mpam_read_monsel_reg(msc, CSU, &now32);
>> +		if (!ret) {
>> +			if ((now32 & MSMON___NRDY))
>> +				ret = -EBUSY;
>> +
>> +			if (mpam_has_quirk(IGNORE_CSU_NRDY, msc) &&
>> +			    m->waited_timeout)
>> +				ret = 0;
> Whilst it is from existing code, this pattern of set and error then clear it
> is less than ideal.  Maybe
> 
> 			if ((now32 & MSMON___NRDY) &&
> 			    !(mpam_has_quirk(IGNORE_CS_NRDY, MSC && m->waited_timeout))
> 				ret = -EBUSY;
> 
> is clearer as that odd intermediate state of ret never happens.

Is it? I see where you are coming from, and I actually had it like this 
before, but I found this combination of conditions harder to read. Also 
this is a quirk, so an exception, and I think the extra check makes this 
clearer that this is some unfortunate mishap we don't really want, but 
have to deal with.

But it's of course easy to change ...

> 
>> +		}
>>   		if (ret)
>>   			goto out_unlock;
>> -		nrdy = now32 & MSMON___NRDY;
>> -		now = FIELD_GET(MSMON___VALUE, now32);
>> -
>> -		if (mpam_has_quirk(IGNORE_CSU_NRDY, msc) && m->waited_timeout)
>> -			nrdy = false;
>>   
>> +		now = FIELD_GET(MSMON___VALUE, now32);
>>   		break;
>>   	case mpam_feat_msmon_mbwu_31counter:
>>   	case mpam_feat_msmon_mbwu_44counter:
>> @@ -1394,9 +1397,11 @@ static void __ris_msmon_read(void *arg)
>>   				now = FIELD_GET(MSMON___L_VALUE, now);
>>   		} else {
>>   			ret = mpam_read_monsel_reg(msc, MBWU, &now32);
>> +			if (!ret && (now32 & MSMON___NRDY))
>> +				ret = -EBUSY;
>>   			if (ret)
>>   				goto out_unlock;
>> -			nrdy = now32 & MSMON___NRDY;
>> +
>>   			now = FIELD_GET(MSMON___VALUE, now32);
>>   		}
>>   
>> @@ -1404,9 +1409,6 @@ static void __ris_msmon_read(void *arg)
>>   		    m->type != mpam_feat_msmon_mbwu_63counter)
>>   			now *= 64;
>>   
>> -		if (nrdy)
>> -			break;
>> -
>>   		mbwu_state = &ris->mbwu_state[ctx->mon];
>>   
>>   		if (overflow)
>> @@ -1419,22 +1421,16 @@ static void __ris_msmon_read(void *arg)
>>   		now += mbwu_state->correction;
>>   		break;
>>   	default:
>> -		m->err = -EINVAL;
>> +		ret = -EINVAL;
>>   	}
>> -	mpam_mon_sel_unlock(msc);
>> -
>> -	if (nrdy)
>> -		m->err = -EBUSY;
>> -
>> -	if (!m->err)
>> -		*m->val += now;
>> -
>> -	return;
>>   
>>   out_unlock:
>>   	mpam_mon_sel_unlock(msc);
>>   
>> -	m->err = ret;
>> +	if (ret)
>> +		m->err = ret;
>> +	else
>> +		*m->val += now;
> 
> If you do the earlier suggestion of ACQUIRE() this all get simpler, but if you do keep
> this, then burn a line or two of code to make it obvious what is error and what isn't.
> 
> 	if (ret) {
> 		m->err = ret;
> 		return;
> 	}
> 
> 	*m->val += now;
>>   }
> 

So I started to put scoped_guard's and ACQUIRE() everywhere now, will 
see how this turns out.

Cheers,
Andre

