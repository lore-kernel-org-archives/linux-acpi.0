Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC73DA7CA;
	Fri, 24 Jul 2026 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891966; cv=none; b=LMSAP2W0ioNTNOLuPDS9Zks61qv1yib2W/mJPQq4zycDVe1MnXT3bY2g2cYLSz2DZ9igVL0gXeC0ZQfc+DSbpbmcx+QFMXOtVR8+uRQQDA8lNSRhljNFIYWamEjmm4ZlFV19dEgI8Bu0fS23d/HgQQTAD9026ZsFetskMHPd/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891966; c=relaxed/simple;
	bh=6DmPCA8NJHL/ZnEaVWd3asm4aMXes0MHBhltqBYPzUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzPmsMGuW7gx/zGQ9/U/aDYK4W2NvlKQUrfiZzZGD45Zl0jAepWn8ZNPz615PE5xI7wdDYQnb48nBZS2Cjs9/h3GguNKV0qXnBSdTDs8nUty3RqTgUAFUBjbEX687NJu1rFnxRFj6aRJdlMb57REMYeXNOMYZwpOSW5gQ9BKF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rt8qOQDU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rt8qOQDU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04AF31477;
	Fri, 24 Jul 2026 04:19:17 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD6543F59E;
	Fri, 24 Jul 2026 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784891961; bh=6DmPCA8NJHL/ZnEaVWd3asm4aMXes0MHBhltqBYPzUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rt8qOQDUCbtSI1jimM0mrdL+fE4d2WYXQ0SO9UgDHn+T4tx7DW6bqmzbBBifj/dxV
	 4RxZlqG4EdGj9kRiYhgQUeu+0CAH0+se3xveU5a34dmf0LOZBG/mRD9qu9shMX0sRb
	 mPsuEhchgGPJesQC0IwJ7alze55pAHkDENU8Ce4c=
Message-ID: <e182f2ac-6fd9-4a25-9409-9617012584ed@arm.com>
Date: Fri, 24 Jul 2026 13:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] arm_mpam: propagate MSC access errors for state
 saving function
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
 <20260723155454.1760823-7-andre.przywara@arm.com>
 <20260724-important-curassow-of-support-ce4777@sudeepholla>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260724-important-curassow-of-support-ce4777@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/24/26 12:07, Sudeep Holla wrote:
> On Thu, Jul 23, 2026 at 05:54:50PM +0200, Andre Przywara wrote:
>> Allow the mpam_save_mbwu_state() function to return an error, and
>> propagate read and write errors from the lower level up.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
>>   1 file changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index bcff53477133..6329443c451f 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1833,22 +1833,37 @@ static int mpam_save_mbwu_state(void *arg)
>>   
>>   		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
>>   			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>> -		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
>> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
>> -		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>> +		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>> +		if (ret)
>> +			return ret;
>> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
>> +		if (ret)
>> +			return ret;
>> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
>> +		if (ret)
>> +			return ret;
> 
> How does it work in general with PCC. Now that you can fail at any point,
> what happens to the write that occurs before a failed read like above one.
> Who will take care of erasing those new writes or it doesn't matter ?
> Just checking as I don't have much knowledge on MPAM intrinsics.

TBH I don't know, but I think we consider MPAM botched at this point, 
and just stop the driver, similar to an error IRQ? But I am not sure 
this is properly implemented at this point. The focus of these first six 
patches was merely to lay the dirty groundwork for *being able* to 
handle errors, and do this now rather than in the future.

Cheers,
Andre
