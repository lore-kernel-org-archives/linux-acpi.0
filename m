Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315CF47AF67;
	Tue, 21 Jul 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645464; cv=none; b=phCmWv9TyX7uCvhYkysPa8GpLVORG7gGqoUJcsFvoTe8Vm8LnD7eXS0aj1kqez1fjRNEDGtymmeiiVHuO/9e+wxgxk76LjxDEWjCU3wRi3ESG0LsafOORr5D6EGQW9FemfrftPtYZI6zL8AU8++4niS23p9J5yJ4RzQE7HWlQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645464; c=relaxed/simple;
	bh=Vcis6t4xUy77hTPy7uY299+DZ2Az+Lpqnoisp68jgOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNrSUJsApGbj8g1pddokSu08TXQEBYXp6x9GxtsEVhxD2a9lxJeZJV5jWRryCAUi2t9/kXSl1ThGL9RWF9vRYnB8+Jmpv4rJmfYY86nI0dJtuOnn9uFgjDhz8urOUtbvjtTsZT4jlIDzGxS2RJpWKxkMewlF/rshhnpmwXPQWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QlXCWJTc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QlXCWJTc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B3D152B;
	Tue, 21 Jul 2026 07:50:58 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0A1B3F86F;
	Tue, 21 Jul 2026 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784645462; bh=Vcis6t4xUy77hTPy7uY299+DZ2Az+Lpqnoisp68jgOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QlXCWJTcqmg3GqQSmuLEHqq2bzT2gP4nc2CFnk0xn1Bxa18KQC7cbCKux+aQFLPZQ
	 6Z+tZYD8xDpeLtXK/DnyZi5BWXWGsSNeQAVdrYPRk5qLtGp8UgYwJrMs5d9yQ3fZ6B
	 ajSZ0TBYDiiBZjFIoH66E0UVyUJQmUXoHPwcnW3Q=
Message-ID: <f287f45c-4eaa-44bc-9c2a-07767bd5085a@arm.com>
Date: Tue, 21 Jul 2026 16:51:00 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] arm_mpam: detect and enable MPAM-Fb PCC support
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
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-17-andre.przywara@arm.com>
 <52dc486f-2ef2-4c57-b3fb-fb4c240a9198@trager.us_quarantine>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <52dc486f-2ef2-4c57-b3fb-fb4c240a9198@trager.us_quarantine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lee,

On 7/15/26 18:08, Lee Trager wrote:
> On 7/10/26 7:45 AM, Andre Przywara wrote:
> 
>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> index 84963a20c3e7..64bc84bb2029 100644
>> --- a/drivers/acpi/arm64/mpam.c
>> +++ b/drivers/acpi/arm64/mpam.c
>> @@ -256,6 +256,8 @@ static struct platform_device * __init 
>> acpi_mpam_parse_msc(struct acpi_mpam_msc_
>>       } else if (iface == MPAM_IFACE_PCC) {
>>           props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>>                               tbl_msc->base_address);
>> +        props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
>> +                            tbl_msc->identifier);
>>       }
> 
> props is defined above as:
> 
> /* pcc, nrdy, affinity, and a sentinel */
> 
> struct property_entry props[4] = { 0 };
> 
> With the addition of the new property the array size needs to be 
> increased to 5 and the comment updated

Ouch, that's right. For now we are saved by the fact that the affinity 
value is not used, so there is a free slot now. And there are checks in 
place to avoid writing over the sentinel. But indeed the size needs to 
be increased. Thanks for catching this!

Cheers,
Andre


