Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A9B39F160;
	Thu, 30 Apr 2026 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540856; cv=none; b=QDiYeqgPTnaqQO/bWjFFmwRUmb71WHoduJyLw0RWAB0OpKFBC9gqdqniiU3E6QM6rDfmN5+4lBPUuOpragxHegSTKrtERJ6DjyHsTcQOQXUWURRBkT4ui617ETan8dakOm4UcV/8ukMtDc1VQm1JI5A3p4is+Fq5VRYNfbE6dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540856; c=relaxed/simple;
	bh=rEuYE3BOp0rZUoRuwFkMAOix88kidy9F1/N55h8chlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQXWUbI+wc6A5dW0CxXOV9ukICdCzceYSf5fnzi9mKjCKz9iFHaqvFyPHHdjAQCG0KYIvTq6AT/0thm29t7vVqZRUfX7Qf54V6+nfJPjPvQCnwXaTbziFffzmPjjTuEMTfm2BnW/6exbS2FDzgWlSB2gvCsDRZHTv2EQIEMidjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=te8cLsXc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="te8cLsXc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 619F41A9A;
	Thu, 30 Apr 2026 02:20:41 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A06173F7B4;
	Thu, 30 Apr 2026 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777540846; bh=rEuYE3BOp0rZUoRuwFkMAOix88kidy9F1/N55h8chlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=te8cLsXc/9padMNn1HNRnZmVeeS4irCJgGQmkQUJx4a0oAGiUezq/YFx/bt1hZWB+
	 POTepneGGzzLeDhIG4eJ7QNqLdMl+Fim4jSGEYfDdhhOMh7KsHE6bFLb79b30UpwCB
	 Eka39O2o43ZkyU0GGXm69bd6Sp8vsAt7UpJDuVVM=
Message-ID: <fc96c088-f767-4bf2-b58b-d4e91b0acde4@arm.com>
Date: Thu, 30 Apr 2026 11:20:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm_mpam: detect and enable MPAM-Fb PCC support
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260429141339.3171205-1-andre.przywara@arm.com>
 <20260429141339.3171205-6-andre.przywara@arm.com>
 <20260430-brave-hoatzin-of-fascination-e7d4ad@sudeepholla>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260430-brave-hoatzin-of-fascination-e7d4ad@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sudeep,

thanks for having a look!

On 4/30/26 10:35, Sudeep Holla wrote:
> On Wed, Apr 29, 2026 at 04:13:39PM +0200, Andre Przywara wrote:
>> The Arm MPAM-Fb specification [1] describes a protocol to access MSC
>> registers through a firmware interface. This requires a shared memory
>> region to hold the message, and a mailbox to trigger the access.
>> For ACPI this is wrapped as a PCC channel, described using existing
>> ACPI abstractions.
>>
>> Add code to parse those PCC table descriptions associated with an MSC,
>> and store the parsed information in the MSC struct.
>> This will be used by the MPAM-Fb access wrapper code.
>>
>> [1] https://developer.arm.com/documentation/den0144/latest
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/acpi/arm64/mpam.c      |  2 ++
>>   drivers/resctrl/mpam_devices.c | 46 +++++++++++++++++++++++++++++++---
>>   2 files changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> index 99c2bdbb3314..edb4d10e8dc3 100644
>> --- a/drivers/acpi/arm64/mpam.c
>> +++ b/drivers/acpi/arm64/mpam.c
>> @@ -341,6 +341,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>>   	} else if (iface == MPAM_IFACE_PCC) {
>>   		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>>   							tbl_msc->base_address);
>> +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
>> +							tbl_msc->identifier);
> 
> I may be looking at the wrong documents, but neither DEN0065 nor DEN0144 carry
> any definitions of pcc-channel and msc-id for the device with HID
> "“ARMHAA5C". Since "pcc-channel" is already merged, I think I am looking at
> wrong documents, please point me to the right one.

Please excuse my ignorance, but I was under the assumption that the 
strings used here are just unique identifiers that need to match the 
property_get calls in the MPAM code. Is there any requirement to match 
those property_entry.name fields with the names given in some spec? And 
those strings are kernel-internal only, right? But for DT would match 
exactly the property names?

Those properties correspond to fields in table 4 in DEN0065, as also 
described in struct acpi_mpam_msc_node in include/acpi/actbl2.h:
- There is "Identifier", that uses distinct IDs for PCC and native MSCs. 
I named it msc-id, because I'd assume that to be a good name for any 
(yet to be defined) DT property.
- Then there is "Base address", which doubles as the "subspace ID of the 
PCC channel", when MPAM-Fb is used. As you mentioned, this is already 
in, and the original spec name would be very misleading, I think.

So shall those strings be renamed to match the struct names? Or shall I 
keep the more readable names as of now, and add comments linking them to 
the spec/struct?

Cheers,
Andre
