Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEA83E4C7D;
	Thu,  9 Jul 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582578; cv=none; b=puEyYvvuZFLQaHFyDr5jJzlsor3UJB1wvklZ+BQZ/EBvlO19+nJSjRkUI2ont4mzpcMPeB4ttlkwq7+0eQN4nDOs6BKbHXR8Dp5MIHQyBNGJkm45sM2CmPGMpzVNMjDBjtn0dy4yQ60YpnhEoqMwHdh8h4lJRej6rNabGFPYoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582578; c=relaxed/simple;
	bh=8sfhycHbh/KxK1a8FZ4v3kkfMX38FffCMj8F1aGLOrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrSSE2nN0S5VewpJYg3i3iD+6fwQ4jskdLft4uCq4MFdS67HeerT7zbzGml6tSGq7KX37JSymkwDBE88VAUh9b7xMGLMWDwhP8Zi1wyQ/AORm3CC7Cg3mI2KFz4KEDBxfquupUg5lWdWkvyMhgkcqEyQEfu34G0pnxbToLqFtjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UDmSLeWY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UDmSLeWY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 471E315A1;
	Thu,  9 Jul 2026 00:36:10 -0700 (PDT)
Received: from [10.41.150.148] (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28073F66F;
	Thu,  9 Jul 2026 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783582574; bh=8sfhycHbh/KxK1a8FZ4v3kkfMX38FffCMj8F1aGLOrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UDmSLeWYCQ6eENgHGLBq2RT///VUSQA3jbHG4hIoVpBhilDuNu9yxytLHkYVSiUeK
	 xzRnXQLJOZp0AjABSNX3qkHZdwNhvHcebz0x47o0LDS/uIlVL9VMzZ4x1e4AEaqVGV
	 d9aj4bfQuRhm32Ixu++/v04/unD8kdPQ87UnG0/E=
Message-ID: <bc669ed1-a0d6-4ee5-b24e-6996af0f5d3a@arm.com>
Date: Thu, 9 Jul 2026 09:36:09 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] arm_mpam: propagate MSC read errors for
 mpam_msc_read_mbwu_l()
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
 <20260702162229.4008659-5-andre.przywara@arm.com>
 <717a2f77-7caa-4cf5-acd5-c2f86686e34e@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <717a2f77-7caa-4cf5-acd5-c2f86686e34e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 7/1/26 22:06, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/2/26 17:22, Andre Przywara wrote:
>> Allow the mpam_msc_read_mbwu_l() function to return an error, and
>> propagate read errors from the lower level up.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 011d1e3544d7..1d06902fb970 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1106,6 +1106,7 @@ static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
>>   
>>   static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
> 
> Now that your changing the other helpers to return an error and pass a
> pointer to hold the register value it would seem more consistent for
> this call to follow the same pattern.

Ah, I wasn't entirely sure whether this MSMON___L_NRDY is just some 
error flag (abuse), since NRDY is some kind of architecture feature.
If that's indeed here the case, I will be changing the prototype and 
adjust the function.

Cheers,
Andre

> Thanks,
> 
> Ben
> 
>>   {
>> +	int ret;
>>   	int retry = 3;
>>   	u32 mbwu_l_low;
>>   	u32 mbwu_l_high1, mbwu_l_high2;
>> @@ -1115,11 +1116,17 @@ static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
>>   	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>>   
>> -	__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
>> +	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
>> +	if (ret)
>> +		return MSMON___L_NRDY;
>> +
>>   	do {
>>   		mbwu_l_high1 = mbwu_l_high2;
>> -		__mpam_read_reg(msc, MSMON_MBWU_L, &mbwu_l_low);
>> -		__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
>> +		ret = __mpam_read_reg(msc, MSMON_MBWU_L, &mbwu_l_low);
>> +		if (!ret)
>> +			ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
>> +		if (ret)
>> +			return MSMON___L_NRDY;
>>   
>>   		retry--;
>>   	} while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);
> 

