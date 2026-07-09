Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7590643933F;
	Thu,  9 Jul 2026 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583040; cv=none; b=X2cMK6HePRM4w9+wsZJkVsMrOJfFHCuMlnaxOGNNN/RJbqPV/mNjJOB0miTA1BuiGlGvWScMPTJB9HZROkOhrBQ+XaukGSrxSb+qk2tqVnMYC6H/ln8QxqLe36Xy3ohuDA9Yr5VWuOZkrJvkOqE+iF+pM1DBYFMtnTrBI19VkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583040; c=relaxed/simple;
	bh=IgdTSArHQ8oteKx5khmzg/wtXtBIJn8DUtYY+BXoEMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7gwKnTKZjoni/glJ6lfOqJN+ezT66a3lWL8oCZ8D18O6gdKTYGwIzK6RJGa6CYl4pLUakC02LQOc3juNlNxJ1lnUtP+iboc03l4HRD6RWR+SA7/evNTIQ5HPd0Q6tygAfgdQToQCabVtv7FxNecgaWKS6H2vQYdN0zlrhRAjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZofewIXy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZofewIXy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78B09168F;
	Thu,  9 Jul 2026 00:43:54 -0700 (PDT)
Received: from [10.41.150.148] (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 061383F66F;
	Thu,  9 Jul 2026 00:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783583038; bh=IgdTSArHQ8oteKx5khmzg/wtXtBIJn8DUtYY+BXoEMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZofewIXyrEbVv1Dz0DDeV2p7J/CuvpU/Q9ZDTKY27/4tAhvAG8rKCaYqonSW0Ytu2
	 WiwySDPCzw0ipoQ679VApyzY5O6PapengItCRYzO3n/5gtu0FdxHeS/xaM4yF7/DJj
	 DKcJQu1mJG/2FrF+1mhkNsISAwa3ZQn53/Kk6Vkw=
Message-ID: <29e02d92-b294-40e2-8d85-eb62bcb8ae17@arm.com>
Date: Thu, 9 Jul 2026 09:43:52 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] arm_mpam: propagate MSC read errors for
 __ris_msmon_read()
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
 <20260702162229.4008659-7-andre.przywara@arm.com>
 <332b1348-285f-4b4a-9d3d-97f040739703@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <332b1348-285f-4b4a-9d3d-97f040739703@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 7/1/26 22:14, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/2/26 17:22, Andre Przywara wrote:
>> Allow the function for RIS accesses to return an error, and propagate
>> read errors from the lower level up.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 35 +++++++++++++++++++++++++++-------
>>   1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index b259fe20a614..d18c7be86aaa 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1285,9 +1285,14 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type,
>>   	return overflow_val;
>>   }
>>   
>> +/*
>> + * This function might be called via smp_call_function_any(), so propagate
>> + * errors inside the arg struct.
>> + */
>>   static void __ris_msmon_read(void *arg)
>>   {
>>   	u64 now;
>> +	int ret;
>>   	u32 now32;
>>   	bool nrdy = false;
>>   	bool config_mismatch;
>> @@ -1326,7 +1331,9 @@ static void __ris_msmon_read(void *arg)
>>   	 * Read the existing configuration to avoid re-writing the same values.
>>   	 * This saves waiting for 'nrdy' on subsequent reads.
>>   	 */
>> -	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>> +	ret = read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>> +	if (ret)
>> +		goto out_unlock;
>>   
>>   	if (mpam_feat_msmon_mbwu_31counter == m->type)
>>   		overflow = cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS;
>> @@ -1351,7 +1358,9 @@ static void __ris_msmon_read(void *arg)
>>   
>>   	switch (m->type) {
>>   	case mpam_feat_msmon_csu:
>> -		mpam_read_monsel_reg(msc, CSU, &now32);
>> +		ret = mpam_read_monsel_reg(msc, CSU, &now32);
>> +		if (ret)
>> +			goto out_unlock;
>>   		nrdy = now32 & MSMON___NRDY;
>>   		now = FIELD_GET(MSMON___VALUE, now32);
>>   
>> @@ -1371,7 +1380,9 @@ static void __ris_msmon_read(void *arg)
>>   			else
>>   				now = FIELD_GET(MSMON___L_VALUE, now);
>>   		} else {
>> -			mpam_read_monsel_reg(msc, MBWU, &now32);
>> +			ret = mpam_read_monsel_reg(msc, MBWU, &now32);
>> +			if (ret)
>> +				goto out_unlock;
>>   			nrdy = now32 & MSMON___NRDY;
>>   			now = FIELD_GET(MSMON___VALUE, now32);
>>   		}
>> @@ -1402,10 +1413,15 @@ static void __ris_msmon_read(void *arg)
>>   	if (nrdy)
>>   		m->err = -EBUSY;
>>   
>> -	if (m->err)
>> -		return;
>> +	if (!m->err)
>> +		*m->val += now;
> 
> Why does this change? Can't you keep this the 'if' statement as before
> and more the 'return' after the '*m->val += now;'?

Because I need to explicitly return now anyway, since the error path 
below would just unlock again otherwise. So it would look like:

	if (m->err)
		return;

	*m->val += now;

	return;
out_unlock:
	mpam_mon_sel_unlock(msc);
...

which seemed like one return would be enough, and just conditionally do 
the assignment instead. I'd prefer to keep it like in this patch, but 
let me know if you disagree and I would change it to the one sketched above.

Cheers,
Andre

> 
> Thanks,
> 
> Ben
> 
>> +
>> +	return;
>>   
>> -	*m->val += now;
>> +out_unlock:
>> +	mpam_mon_sel_unlock(msc);
>> +
>> +	m->err = ret;
>>   }
>>   
>>   static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>> @@ -1729,6 +1745,7 @@ static int mpam_restore_mbwu_state(void *_ris)
>>   {
>>   	int i;
>>   	u64 val;
>> +	int ret = 0;
>>   	struct mon_read mwbu_arg;
>>   	struct mpam_msc_ris *ris = _ris;
>>   	struct mpam_class *class = ris->vmsc->comp->class;
>> @@ -1741,10 +1758,14 @@ static int mpam_restore_mbwu_state(void *_ris)
>>   			mwbu_arg.val = &val;
>>   
>>   			__ris_msmon_read(&mwbu_arg);
>> +			if (mwbu_arg.err) {
>> +				ret = mwbu_arg.err;
>> +				break;
>> +			}
>>   		}
>>   	}
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   /* Call with MSC cfg_lock held */
> 

