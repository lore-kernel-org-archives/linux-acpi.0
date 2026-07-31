Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F7413230;
	Fri, 31 Jul 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494934; cv=none; b=JeRAC88JNjyIdczfhh5RFMxlf0Oh2ec2ZqAEhp66D8da/2qM5dKvQZiVLGArqR1miwFcRHe+v2rID4R+/SVAZIZbkmOti+aIipwXXrwuuZVO7+dGI/529Yo1Po33IvuXT3pgFPt07/D9mnE5+DghEKV5sE8J+YlKvqOQGCd0fE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494934; c=relaxed/simple;
	bh=ratjVqBu7p3JZWZjD/O28L5zEMWQLUbFrNGlwxKGTdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qo+M6ZLQZTxwFLZmho27lT6MOI6CjXHiogMVN4S4Tzjj3RP1AQSUTEiFaa85dKziLAVS47qpj3ZGh5RFKSVfVSg4+7hZ28uNOQIuimqlLF38Lhr6eWOvETNtXDbup6RLKrst557Duq6ZPMeqojdFUXOqrkcSc7wbhIxLuBAQ30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kYDLuAQe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kYDLuAQe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3199165C;
	Fri, 31 Jul 2026 03:48:29 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35B813F86F;
	Fri, 31 Jul 2026 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785494914; bh=ratjVqBu7p3JZWZjD/O28L5zEMWQLUbFrNGlwxKGTdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kYDLuAQe7elelYPkJMrRzshoXDSkqWcXGcM4W6epQJB4vjPITlDdO3dayC1yBlYkE
	 TJRnDlLfGeUEw7ViWWKFhpfJOOa6KiuY4d4qYpVkBnUDo3ZRMOCy8D9eJm5jOgLKqS
	 4AAWXpf6HpI1Yzk0GVx57z5XH4UIoQyDXYZPjMNU=
Message-ID: <fa401c52-b9f2-4e48-87d1-9ddfca330ed0@arm.com>
Date: Fri, 31 Jul 2026 12:48:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] arm_mpam: prepare mon_sel locking for MPAM-Fb
To: Lee Trager <lee@trager.us>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Ritwick Sharma <ritwick.sharma@arm.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260730152539.2712312-1-andre.przywara@arm.com>
 <20260730152539.2712312-8-andre.przywara@arm.com>
 <b9d57d9f-61c7-4e62-a120-7631bdb7069b@trager.us>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <b9d57d9f-61c7-4e62-a120-7631bdb7069b@trager.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lee,

On 7/30/26 23:46, Lee Trager wrote:
> On 7/30/26 8:25 AM, Andre Przywara wrote:
> 
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/ 
>> mpam_devices.c
>> index 38450c55e45e..d175d1d50030 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -2230,7 +2230,10 @@ static struct mpam_msc 
>> *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>       if (err)
>>           return ERR_PTR(err);
>> -    mpam_mon_sel_lock_init(msc);
>> +    err = mpam_mon_sel_lock_init(dev, msc);
>> +    if (err)
>> +        return ERR_PTR(err);
>> +
>>       msc->id = pdev->id;
>>       msc->pdev = pdev;
>>       INIT_LIST_HEAD_RCU(&msc->all_msc_list);
>>
> msc->iface is set below, it needs to be set before calling 
> mpam_mon_sel_lock_init() so PCC devices initalize mon_sel_mtex, while 
> MMIO initialize the spinlock.

Ouch, that's a good one. This worked before, because we initialised 
both, but indeed now breaks.

Thanks for noticing, just moved the initialisation down now.

Cheers,
Andre


