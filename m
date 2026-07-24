Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825154446F0;
	Fri, 24 Jul 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911405; cv=none; b=QbULPJOAR0NKwxgVNCwwGUSQ3Nf7dqZYuVFyzCAR0D3iQdkHVhXbFVk8Co9n87vhoPD/w4/go4lnoi1eErT6E5l2r5BysYcByIUZG2wtJaerwb9Lz3/Fi2gmakfjMPwwM22BOzLbfGm9+vvx+Nnq2yI8tCAONFt08/cDiVZAUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911405; c=relaxed/simple;
	bh=xg3oqIbjSE4M3l+OIN0CvX6y9JbVpfwuWJCKOcCKSwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoYNC+atWfHCG6cTPPNtOh9/QP80si1acYDJ4qLm5u2IvyFizNj9kKvCIYvb2vMh23lxSP4Zbt+9GmgNgBRc0b4Qa4QtEhvPnsOB/7HTyiyWecgG99FvsTHQz36W2bc3loei4GB6pEBChcl2lruBUdLvokEMP6j701v2JBztxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SKBjrr57; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SKBjrr57"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D11EE1476;
	Fri, 24 Jul 2026 09:43:14 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5D23F66F;
	Fri, 24 Jul 2026 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784911398; bh=xg3oqIbjSE4M3l+OIN0CvX6y9JbVpfwuWJCKOcCKSwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SKBjrr57keO2j25CeVl2oqwhT6NLRMtpd2QC2pSw9IeT52fuKNPaFDsFLqwOMlO/I
	 IhcOKDvkEZyQfpMzfWMf0J1IBUoIHGJGk2jx6vpyrlfTJDtFB4K9j2LbFcielbi0hk
	 94w/8+rz3DbRDxJ++11T76OcKfOlXAMoSPkwjmDs=
Message-ID: <83336f0e-85ac-4711-9594-5edcb27eecdd@arm.com>
Date: Fri, 24 Jul 2026 17:43:12 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v4 06/10] arm_mpam: propagate MSC access errors for state
 saving function
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-7-andre.przywara@arm.com>
 <20260724-important-curassow-of-support-ce4777@sudeepholla>
 <e182f2ac-6fd9-4a25-9409-9617012584ed@arm.com>
 <20260724-perfect-pygmy-chinchilla-447ce0@sudeepholla>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260724-perfect-pygmy-chinchilla-447ce0@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sudeep, Andre,

On 7/24/26 13:27, Sudeep Holla wrote:
> On Fri, Jul 24, 2026 at 01:19:14PM +0200, Andre Przywara wrote:
>> Hi,
>>
>> On 7/24/26 12:07, Sudeep Holla wrote:
>>> On Thu, Jul 23, 2026 at 05:54:50PM +0200, Andre Przywara wrote:
>>>> Allow the mpam_save_mbwu_state() function to return an error, and
>>>> propagate read and write errors from the lower level up.
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>>   drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
>>>>   1 file changed, 22 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>>>> index bcff53477133..6329443c451f 100644
>>>> --- a/drivers/resctrl/mpam_devices.c
>>>> +++ b/drivers/resctrl/mpam_devices.c
>>>> @@ -1833,22 +1833,37 @@ static int mpam_save_mbwu_state(void *arg)
>>>>   		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
>>>>   			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>>>> -		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>>>> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
>>>> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
>>>> -		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>>>> +		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
>>>> +		if (ret)
>>>> +			return ret;
>>>
>>> How does it work in general with PCC. Now that you can fail at any point,
>>> what happens to the write that occurs before a failed read like above one.
>>> Who will take care of erasing those new writes or it doesn't matter ?

At least in this particular case it doesn't matter. The MON_SEL just configures which instance of
the monitor we are reading or writing from and we'll just write MON_SEL again next time we want to
interact with a monitor.

>>> Just checking as I don't have much knowledge on MPAM intrinsics.
>>
>> TBH I don't know, but I think we consider MPAM botched at this point, and
>> just stop the driver, similar to an error IRQ? But I am not sure this is
>> properly implemented at this point. The focus of these first six patches was
>> merely to lay the dirty groundwork for *being able* to handle errors, and do
>> this now rather than in the future.
>>

I've just been discussing the error handling with James and trying to work out what we can do
without limiting our options going forward. Ideally, if there are transient errors we'd like to
retry in the kernel if it's not taking "too long" and otherwise report the error back to user space.
For catastrophic errors, such as when the scp doesn't reply at all or that no MPAM commands are
going to work again we should disable MPAM. As resctrl does not anticipate errors willy nilly from
arch code it ends up reporting the info/last_cmd_status as "ok" even in situations when the MSC
accesses have failed. I notice this in at least rdtgroup_schemata_write(). Before we can report
proper failure information from resctrl and update last_cmd_status based on the error status from
the architecture code it doesn't make sense to report the errors to user space. We would likely want
resctrl to understand -ETIMEDOUT as well. As such, this leaves us the option of just nuking MPAM on
any error reported from the MPAM firmware interface. For now, we needn't do any retries and just
error out on the first error. It should be possible to just schedule mpam_broken_work from mpam_fb.c
on error.

Sorry for prompting the writing of these error handling patches but they will likely come in useful
in the future.

Thanks,

Ben

> 
> Well, I agree to some extent, but PCC adds that failure case before which
> it wasn't there. So, it is hard to claim that it was botched up before so
> let it be. I will let James/Ben to decide if it was already botched up or
> PCC addition makes it fragile in terms of error handling.



