Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D995036A009;
	Thu, 30 Jul 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399659; cv=none; b=KYWI+8HWLDoXBjZCZsu0clCoXnxquc0oqHcxqA7KGIDfWaChCc5mCqiOfjBAjVRU0UVWIMOg79B/yOAUKm8EWYVAcM2DO5iL8NG1q+6TkqLzv4KWKYCQyjeO33g68R9ZuH+kTMcGM1JeRcBlfv83BAUkjKMa9w+mQwatpkoIt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399659; c=relaxed/simple;
	bh=gjMRVfef1r4KhAEKV+k1umJxEPmgMMO1pW4mplg8FBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQYwSMBJNaXK3NnPPvjcBCZtPMsrrMmuOs+lR7gZZkqeIQl9b41aZnoubQhbag3KzO9oOJxDpHkdCbDX+kcAZeY49MPDayksNP5i89HirO2v1ddX0jP98QWjvKLQDKV48XiGog2gAYrBhdVBUivQxEDFbre5a+KdI+BHSXUqEAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AiYTkj1T; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AiYTkj1T"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 073551684;
	Thu, 30 Jul 2026 01:20:51 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C96CB3F86F;
	Thu, 30 Jul 2026 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785399655; bh=gjMRVfef1r4KhAEKV+k1umJxEPmgMMO1pW4mplg8FBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AiYTkj1T3SFCOBI7G0897c9RQPdqjZKJfYQXsp0rMC8Qn6/0oZz9bPc/O4Hsd+MNn
	 qCaFLu1feAyj1qenpNSEfBBUBVUk92IvMRjAWrt+SpumIKsWgckK44zZdXm/fCQwUJ
	 fs+jq04f3Fqgsx3BXzZqT9XPshEX/hyx+pjl6X2w=
Message-ID: <1d600f7c-4654-4b93-b4a3-8e76730d8151@arm.com>
Date: Thu, 30 Jul 2026 09:20:51 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v5 03/10] arm_mpam: propagate MSC access errors for MBWU
 counters
To: Lee Trager <lee@trager.us>, Andre Przywara <andre.przywara@arm.com>,
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
References: <20260729134124.2506269-1-andre.przywara@arm.com>
 <20260729134124.2506269-4-andre.przywara@arm.com>
 <2228a2be-96b1-4c8a-9786-6ba07fd302c0@trager.us>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <2228a2be-96b1-4c8a-9786-6ba07fd302c0@trager.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Lee,

On 7/30/26 02:33, Lee Trager wrote:
> On 7/29/26 6:41 AM, Andre Przywara wrote:
> 
>> @@ -1767,6 +1781,7 @@ static int mpam_save_mbwu_state(void *arg)
>>   {
>>       int i;
>>       u64 val;
>> +    int ret;
>>       struct mon_cfg *cfg;
>>       u32 cur_flt, cur_ctl, mon_sel;
>>       struct mpam_msc_ris *ris = arg;
>> @@ -1777,7 +1792,8 @@ static int mpam_save_mbwu_state(void *arg)
>>           mbwu_state = &ris->mbwu_state[i];
>>           cfg = &mbwu_state->cfg;
>>   -        if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
>> +        ACQUIRE(mon_sel_lock, guard)(msc);
>> +        if (ACQUIRE_ERR(mon_sel_lock, &guard))
>>               return -EIO;
>>             mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
>> @@ -1788,7 +1804,9 @@ static int mpam_save_mbwu_state(void *arg)
>>           mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>>             if (mpam_ris_has_mbwu_long_counter(ris)) {
>> -            val = mpam_msc_read_mbwu_l(msc);
>> +            ret = mpam_msc_read_mbwu_l(msc, &val);
>> +            if (ret)
>> +                return ret;
>>               mpam_msc_zero_mbwu_l(msc);
>>           } else {
>>               u32 val32;
> I think checking for (val & MSMON____L_NRDRY) is still required before updating the saved state.
> mpam_msc_read_mbw_l() can return 0 while setting val to MSMON___L_NRDY when it cannot obtain a
> stable value. The state saving path later adds val to mbwu_state->correction, so the sentinel would
> corrupt the saved correction. Additionally, as Ben noted during the v3 review, hardware may also set
> the NRDY bit.

This is an existing issue which I address in this patch:
https://lore.kernel.org/linux-arm-kernel/20260710115546.29644-7-ben.horgan@arm.com/

Please can you check and see if that looks good to you.

Thanks,

Ben

>> @@ -1804,7 +1822,6 @@ static int mpam_save_mbwu_state(void *arg)
>>           cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
>>           mbwu_state->correction += val;
>>           mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
>> -        mpam_mon_sel_unlock(msc);
>>       }
>>         return 0;

