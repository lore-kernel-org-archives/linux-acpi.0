Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0013DEAF2;
	Fri, 24 Jul 2026 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891839; cv=none; b=j5UninYTeNTHEMfrC6FXooSITm90jqa7nDh6qqjeQGhn6sghaZ7YXbJgQ65tWT/iFvjYZ8xBAxd2HFJu4P3YMyG+SJnCNx7ThbPqxI6cta+PlXtLPVsfRrPCesdOdJj6SLCcdbQ0Bdd3gCsoEDcC026aFdywOFYRZu4WZp90HRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891839; c=relaxed/simple;
	bh=XOve+0XtVKVlM/u7vcMwBknwE9v0ZsOgXPcAxAz0/xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5Os/h8yLXC6JO++j+4QXm0U9zXc3gWwdGV2YrowjDxajRG/fQ2NtUCjJO2yH8Sl4EexzAzPus+ZR2CtR/mpwuZ5irzmho9dwAV6aaITU4cq/6w2XQtwPkO/eMVMsEXFBDUfFLBoahrqU+QFl5LONh5zw21JC9/TJAtQPmHRzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EuG4sy5Q; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EuG4sy5Q"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6036C1477;
	Fri, 24 Jul 2026 04:17:12 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76A5C3F59E;
	Fri, 24 Jul 2026 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784891836; bh=XOve+0XtVKVlM/u7vcMwBknwE9v0ZsOgXPcAxAz0/xU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EuG4sy5QmEhYuJHNParTw6VDWlgVw3P44Ml0OYKI7mNOPsSITLwTqFXcavCqnuDyJ
	 0LP62H9PDG8Zm3J0vyUv5+Aqsq/ssw5spzw5ApgIS+yz3g3n//oUFjuHKsIyzXGGx0
	 iyi4T1G2B9Bx6pz3NgSVvQgdeVx21eVns2WVtYHI=
Message-ID: <1864c9a2-2e97-411e-9f12-862a8cfd4101@arm.com>
Date: Fri, 24 Jul 2026 13:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] arm_mpam: propagate MSC access errors for
 __ris_msmon_read()
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-6-andre.przywara@arm.com>
 <20260724-horned-wolf-of-will-a49c1d@sudeepholla>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260724-horned-wolf-of-will-a49c1d@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/24/26 12:02, Sudeep Holla wrote:
> On Thu, Jul 23, 2026 at 05:54:49PM +0200, Andre Przywara wrote:
>> Allow the function for RIS accesses to return an error, and propagate
>> read and write errors from the lower level up.
>> This function is a bit special, since it can be called via an SMP
>> helper, so the prototype must stay as void. So propagate any errors
>> using the "err" field in the struct passed in as the sole argument to
>> that function.
>>
> 
> Not sure if this was already discussed by build bisection regresses between
> 4/10 and 5/10 as you change function prototype there and caller here or
> am I missing to read it correctly ?

Does it? I build tested every patch multiple times yesterday, and just 
repeated it, and it comes back cleanly.

>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 36 +++++++++++++++++++++++++---------
>>   1 file changed, 27 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 9ee4eb4db03f..bcff53477133 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1328,6 +1328,10 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type,
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
>> @@ -1351,7 +1355,9 @@ static void __ris_msmon_read(void *arg)
>>   
>>   	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, ctx->mon) |
>>   		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>> -	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>> +	m->err = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>> +	if (m->err)
>> +		return;
>>   
>>   	switch (m->type) {
>>   	case mpam_feat_msmon_mbwu_31counter:
>> @@ -1371,7 +1377,9 @@ static void __ris_msmon_read(void *arg)
>>   	 * Read the existing configuration to avoid re-writing the same values.
>>   	 * This saves waiting for 'nrdy' on subsequent reads.
>>   	 */
>> -	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>> +	m->err = read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>> +	if (m->err)
>> +		return;
>>
> 
> Atleast read_msmon_ctl_flt_vals() changed to return value in last patch.

Ah, but this is not a problem that breaks the build, as we formerly just 
ignored the (at this point bogus) error value, but now pass it up.
But this is one occasion of "touching the same line twice", that was 
criticised before. Not nice, but the alternative would be to have one 
giant patch, which I figured to be unreadable.

Cheers,
Andre

