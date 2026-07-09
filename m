Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07943BFACB;
	Thu,  9 Jul 2026 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582500; cv=none; b=qUa0k1e8mOQLTFk+9E6jFG0pbcGOAKdJXaXMnXc7c67pKitxjuKloQJ0IYoP7vx+JKWpf7iKtKOI0/6VlA5ot7wj5spacbUiO/zbCqzNSjP68omI7JcXUtKhngzWI6Yjg+U7uJLHcq/Qo/tbXVYnVnb6sJuvQEJX0vPOcuozfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582500; c=relaxed/simple;
	bh=66zG2d9zsYOd+DElbNs9ua75fdJfZCXLCzoMIQb2+JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfuGMwPb+UzyKzc1phZLnxjvaDkRkx5RxCR/cswbjiHu0qQA0SxqD/O2Tl2QppHVtCUrSEfGGSHuq6zfLsjcU/6s53IWKA7EswmZtccM2hCcJ6K0wa/flPkq6naxcJFSNoCVpTEbiDIoPA37A+2stoUF7QpmuouPG6mLccobyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d1pTRXZ6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d1pTRXZ6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92EF715A1;
	Thu,  9 Jul 2026 00:34:52 -0700 (PDT)
Received: from [10.41.150.148] (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8363F66F;
	Thu,  9 Jul 2026 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783582496; bh=66zG2d9zsYOd+DElbNs9ua75fdJfZCXLCzoMIQb2+JQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d1pTRXZ6UVsx1u0U2+SyDD2mwhSrCjkE9GB6a3oOdcneINwF0C7nGmUVCMs8YTDAL
	 0iMMDOoK9gbB0vSgR+3aXn+LC/CEFfJI/Cnrww1hnT8vMprDaAL9BLgJvk0Im9l8o7
	 ZQdGhk1QFxEKunC9W1uf9CK9wDfuV/WOSYySn1TM=
Message-ID: <4d1f25a3-d1a3-4521-ae49-d41fd1367a58@arm.com>
Date: Thu, 9 Jul 2026 09:34:50 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] arm_mpam: propagate MSC read errors for wrapper
 functions
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
 <20260702162229.4008659-3-andre.przywara@arm.com>
 <029910c3-e90f-4a35-8b01-4d3ff548deea@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <029910c3-e90f-4a35-8b01-4d3ff548deea@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/1/26 21:56, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/2/26 17:22, Andre Przywara wrote:
>> Allow the wrapper functions for IDR and ESR accesses to return an
>> error, and propagate read errors from the lower level up.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 51 +++++++++++++++++++++++-----------
>>   1 file changed, 35 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index df14b4513382..ce8738adb6ff 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -247,27 +247,34 @@ static bool mpam_msc_check_aidr(struct mpam_msc *msc)
>>   	return true;
>>   }
>>   
>> -static u64 mpam_msc_read_idr(struct mpam_msc *msc)
>> +static int mpam_msc_read_idr(struct mpam_msc *msc, u64 *res)
>>   {
>>   	u32 idr_high = 0, idr_low;
>> +	int ret;
>>   
>>   	lockdep_assert_held(&msc->part_sel_lock);
>>   
>> -	mpam_read_partsel_reg(msc, IDR, &idr_low);
>> -	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
>> -		mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
>> +	ret = mpam_read_partsel_reg(msc, IDR, &idr_low);
>> +	if (!ret && FIELD_GET(MPAMF_IDR_EXT, idr_low))
>> +		ret = mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
>>   
>> -	return ((u64)idr_high << 32) | idr_low;
>> +	if (!ret)
>> +		*res = ((u64)idr_high << 32) | idr_low;
>> +
>> +	return ret;
>>   }
> 
> Why does the pattern here, use of !ret rather than early return, differ
> from the one you've used in mpam_msc_read_esr()?

No particular reason, I think I switched patterns, for instance 
depending on whether a lock was held or not, or when there are some side 
effect of that function, so probably just repeated the last exercise.

I changed it to return early here.

Cheers,
Andre

> 
>>   
>> -static void mpam_msc_clear_esr(struct mpam_msc *msc)
>> +static int mpam_msc_clear_esr(struct mpam_msc *msc)
>>   {
>>   	u32 esr_low;
>> +	int ret;
>>   
>> -	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
>> +	ret = __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
>> +	if (ret)
>> +		return ret;
>>   
>>   	if (!esr_low)
>> -		return;
>> +		return 0;
>>   
>>   	/*
>>   	 * Clearing the high/low bits of MPAMF_ESR can not be atomic.
>> @@ -277,18 +284,30 @@ static void mpam_msc_clear_esr(struct mpam_msc *msc)
>>   	 */
>>   	if (msc->has_extd_esr)
>>   		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
>> +
>>   	__mpam_write_reg(msc, MPAMF_ESR, 0);
>> +
>> +	return 0;
>>   }
>>   
>> -static u64 mpam_msc_read_esr(struct mpam_msc *msc)
>> +static int mpam_msc_read_esr(struct mpam_msc *msc, u64 *res)
>>   {
>>   	u32 esr_high = 0, esr_low;
>> +	int ret;
>>   
>> -	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
>> -	if (msc->has_extd_esr)
>> -		__mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
>> +	ret = __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (msc->has_extd_esr) {
>> +		ret = __mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>> -	return ((u64)esr_high << 32) | esr_low;
>> +	*res = ((u64)esr_high << 32) | esr_low;
>> +
>> +	return 0;
>>   }
>>   
>>   static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
>> @@ -993,7 +1012,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>   
>>   	/* Grab an IDR value to find out how many RIS there are */
>>   	mutex_lock(&msc->part_sel_lock);
>> -	idr = mpam_msc_read_idr(msc);
>> +	mpam_msc_read_idr(msc, &idr);
>>   	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
>>   
>>   	mutex_unlock(&msc->part_sel_lock);
>> @@ -1009,7 +1028,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>   	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
>>   		mutex_lock(&msc->part_sel_lock);
>>   		__mpam_part_sel(ris_idx, 0, msc);
>> -		idr = mpam_msc_read_idr(msc);
>> +		mpam_msc_read_idr(msc, &idr);
>>   		mutex_unlock(&msc->part_sel_lock);
>>   
>>   		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
>> @@ -2492,7 +2511,7 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>>   					   &msc->accessibility)))
>>   		return IRQ_NONE;
>>   
>> -	reg = mpam_msc_read_esr(msc);
>> +	mpam_msc_read_esr(msc, &reg);
>>   
>>   	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
>>   	if (!errcode)
> 

