Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE433E63AE;
	Tue,  4 Aug 2026 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834955; cv=none; b=prG9cnJgfOpNUT1olmU64I3cx8xMLA+orSrXn+/pN5PmwsWFRClarvRB4MQjmjasgDelA9TeSOgZVoxkdfcVpqhAmZxg1w9WfKPcBQ2+RFterXpSlURctJRBAyd1Nexp71odMArpo6Wc6U/NjvS/NgU6lFQ3t/3GZpXIq+hcboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834955; c=relaxed/simple;
	bh=ypKVoyxUQha04oEuezCrJ1jrJPm6kYyRBpLg4CeoxKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpYqwBZrkhj3fGOAiQzA43q8YEaI0e7QH2Bad0RxqapEOAltQqxghpzrhEBe+IvVyPsrY7U3qsIyoqCuoP+Vd2d6KT0DPCj+cr6hhkgtKrVmdjTW2l5DSNDWLOWUz47FkGi9X6qRltBar0p3BNIEBNIfpB5ZE5czVTj8phgZ9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=de21VQQd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="de21VQQd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A74481476;
	Tue,  4 Aug 2026 02:15:48 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392623F66F;
	Tue,  4 Aug 2026 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785834952; bh=ypKVoyxUQha04oEuezCrJ1jrJPm6kYyRBpLg4CeoxKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=de21VQQdeG+0BiF4L8HN3BwKpSEowJslOMvEY6Ahyj3qySm0/+6+8MiCzwCYly5YO
	 xkV4OvOFoDtBXBTncAj2ro2HczGbro3K4HT3e7jv7L657/Q5/pg+2fy4qg4cgZEh4L
	 icfDxofz3a5g77yw6ZauJnZvjrSdUT+ZwkMazhGE=
Message-ID: <0e73b685-da3a-411a-bbb7-d4369fc30d1d@arm.com>
Date: Tue, 4 Aug 2026 11:15:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] arm_mpam: propagate MSC access errors for
 mpam_reprogram_ris_partid()
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
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <20260731170324.2927758-8-andre.przywara@arm.com>
 <20260803152859.00006590@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260803152859.00006590@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 8/4/26 00:28, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 19:03:20 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> Allow the mpam_reprogram_ris_partid() function check for and return
> 
> function to check
> 
>> errors, and propagate MSC read and write errors from the lower level up.
>> This also covers the callers of this function: mpam_reset_ris() and
>> apply_config().
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> One thing below to perhaps modify if you are respinning
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks!

>> ---
>>   drivers/resctrl/mpam_devices.c | 136 ++++++++++++++++++++++-----------
>>   1 file changed, 93 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 38450c55e45e..32088ad1d67e 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1601,7 +1601,7 @@ void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
>>   	}
>>   }
>>   
>> -static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>> +static int mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>>   {
>>   	u32 num_words, msb;
>>   	u32 bm = ~0;
>> @@ -1610,15 +1610,19 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>>   	lockdep_assert_held(&msc->part_sel_lock);
>>   
>>   	if (wd == 0)
>> -		return;
>> +		return 0;
>>   
>>   	/*
>>   	 * Write all ~0 to all but the last 32bit-word, which may
>>   	 * have fewer bits...
>>   	 */
>>   	num_words = DIV_ROUND_UP(wd, 32);
>> -	for (i = 0; i < num_words - 1; i++, reg += sizeof(bm))
>> -		__mpam_write_reg(msc, reg, bm);
>> +	for (i = 0; i < num_words - 1; i++, reg += sizeof(bm)) {
> 
> Not really related to what you are doing here, but if you like you could
> reduce the scope of i via
> 
> 	for (int i = 0;...
> 
> as it isn't used outside of this loop.

Yeah, true, but I'd rather keep it, otherwise I might get comments about 
unrelated changes ;-)

> 
>> +		int ret = __mpam_write_reg(msc, reg, bm);
>> +
>> +		if (ret)
>> +			return ret;
> Personally I don't like this style but feel free to ignore as this is

I know what you mean, I am always in conflict about the on-the-spot 
initialisation and the empty line requirement, tearing apart the error 
check here. Changed to what you suggested.

Thanks,
Andre.


> very much a personal taste thing. I'd do
> 		int ret;
> 
> 		ret = __mpam_write_reg(msc, reg, bm);
> 		if (ret)
> 			return ret;
> 	}
> just to keep the source of error and check for error next to each other.
> 
>> +	}
> 
> 

