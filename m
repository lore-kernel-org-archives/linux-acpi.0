Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757374;
	b=esijeR9dcpZzWF49DitJQJWt3FJmpBufJWIv+aDhKFDZzUF+XQ0jGDF6bU2ez09K/8/c
	 onwWq0uJbVDvqT81VEj3CECd8gH2V9e0DieVfziC3HcBxHZNUxaWBsKpwU3kitll/yu1r
	 HItnJqmrR2gPoLZZ/aZtxkpGnCeZ51n8xXzwo5v8cFz4R4aNIrCAr6IBWx3VjHS6UOwyy
	 MuwkkSj+TLFRDKmZwZTBChP2A0zkwmjN56ykOpX8s4G7rDP9v1S1E1kGB+ZVt8gTruGvb
	 qEL/C5v8dNiZNMCVtl1bgwPLp6PZfMLIds3DuJtdwvsFelezTL4pT5eE6zaTuTlc+Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757374;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FfNDu2MufhqcFnIpc0s4LixzLKeopjshJLXr4fBuq00=;
	b=M2MYFoal+S1fQSLiaT3pTjzuhOvYcmENHBghZtdtg8nRHtIFYzt4lnWerG4RO7HXZYZo
	 KY5QlaHECfjZTVh1Vs/0IJOYXg1sQ8kUGnIB8zaCDp2GzFyA9wveo4/naeI8wIxe3qO71
	 rlAmKyyoe0HKdBU0Li+h6CorwCYpukVM0F5qo5b/tyh3Ab78QU98fYxcIL9vPP0pgS1tL
	 OBkFLcLJ0aebwhpV1ToeLdTdrLwdo+N2bvQUj6t8QMOBduv6VYNtAhdCpcRBzSPB2rMVs
	 VECkp4fnfv9slW280gujPEei+2psjtfQMjiuSkrdZT3nfP3/AjbTwzhlZ2Pmzghd/Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="XR/dnDfh";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847AB606A31B;
	Fri, 23 Oct 2026 12:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 847AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XR/dnDfh
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B2201691;
	Fri, 23 Oct 2026 05:09:29 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5603F7B4;
	Fri, 23 Oct 2026 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792757372; bh=SN3o/iL4eW4PQ8inEqf1iSxxRY1YEBE8Xs4TQqQSkEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XR/dnDfhsetlYyRysR/TdIp7hgR49MPNIN0c61NBGGFqcnoT7qDagReEFlpg9etD4
	 WMBEPsWUbbYuQPKKN3qmV4zuVYjMm6cV2DwZ6HcjphHDKxudDCkExWOAd/82c3WuFw
	 oene2hPPyVAV8LBnaFLjJ8mnWpnhkZsZQZ+H6e4M=
Message-ID: <e267c3d5-a52a-4b55-9eb3-cf42160c3af0@arm.com>
Date: Fri, 23 Oct 2026 13:09:27 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/16] arm64: ras: Add probe/remove for arm64_ras
 driver
To: Umang Chheda <umang.chheda@oss.qualcomm.com>,
 Ruidong Tian <tianruidong@linux.alibaba.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 zhuo.song@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
 <20260602071540.3711528-3-tianruidong@linux.alibaba.com>
 <01b1b1bd-2848-482e-af8b-8fab037c7a04@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <01b1b1bd-2848-482e-af8b-8fab037c7a04@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2026 10:59 am, Umang Chheda wrote:
> Hello Ruidong,
> 
> On 6/2/2026 12:45 PM, Ruidong Tian wrote:
>> Introduce the back-end platform driver that binds to the devices
>> created by the AEST front-end. Driver input is taken exclusively from
>> fwnode properties, so the same probe path serves any future front-end
>> (DT, hand-rolled) without conditional code.
>>
>> The probe builds two layers of state:
>>
>>    - struct ras_node:   one AEST error source
>>    - struct ras_record: one error record inside a node
>>
>> This split mirrors the hardware: a node owns the shared MMIO/ERRGSR
>> window and policy, while records are the unit at which errors are
>> reported, masked and polled. Later patches plug interrupts, decoding,
>> storm mitigation and userspace ABI onto these two objects without
>> touching the front-end.
>>
>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
>> ---
> [...]
> 
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +obj-$(CONFIG_ARM64_RAS_DRIVER) 	+= arm64_ras.o
>> +
>> +arm64_ras-y		:= ras-core.o
>> diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
>> new file mode 100644
>> index 000000000000..b5448f4a841f
>> --- /dev/null
>> +++ b/drivers/ras/arm64/ras-core.c
>> @@ -0,0 +1,266 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ARM Error Source Table Support
>> + *
>> + * Copyright (c) 2025, Alibaba Group.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/ras.h>
>> +
>> +#include "ras.h"
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "arm64_ras: " fmt
>> +
>> +static const char *const ras_node_name[] = {
>> +	[ACPI_AEST_PROCESSOR_ERROR_NODE] = "processor",
>> +	[ACPI_AEST_MEMORY_ERROR_NODE] = "memory",
>> +	[ACPI_AEST_SMMU_ERROR_NODE] = "smmu",
>> +	[ACPI_AEST_VENDOR_ERROR_NODE] = "vendor",
>> +	[ACPI_AEST_GIC_ERROR_NODE] = "gic",
>> +	[ACPI_AEST_PCIE_ERROR_NODE] = "pcie",
>> +	[ACPI_AEST_PROXY_ERROR_NODE] = "proxy",
>> +};
> 
> Now that the ARM RAS core framework is shared by both ACPI and DT
> platforms, should we consider dropping the "ACPI_AEST" naming in the
> common code and replacing it with a more generic prefix maybe something
> like "ARM_RAS" ?

But these names and values _are_ defined by AEST (literally "AEST node 
type", see table 4 in DEN0085) - they are not part of the RAS 
architecture itself. Even if you exactly copy all the AEST concepts into 
a DT binding, it doesn't really make them "common", it just means you've 
defined a DT binding in terms of what are still AEST definitions.

Thanks,
Robin.

> [...]
>> +
>> +const struct ras_group ras_group_config[] = {
>> +	[ACPI_AEST_NODE_GROUP_FORMAT_4K] = {
>> +		.errgsr_num = ERXGROUP_4K_ERRGSR_NUM,
>> +		.size = ERXGROUP_4K_SIZE,
>> +		.errgsr_offset = ERXGROUP_4K_OFFSET,
>> +	},
>> +	[ACPI_AEST_NODE_GROUP_FORMAT_16K] = {
>> +		.errgsr_num = ERXGROUP_16K_ERRGSR_NUM,
>> +		.size = ERXGROUP_16K_SIZE,
>> +		.errgsr_offset = ERXGROUP_16K_OFFSET,
>> +	},
>> +	[ACPI_AEST_NODE_GROUP_FORMAT_64K] = {
>> +		.errgsr_num = ERXGROUP_64K_ERRGSR_NUM,
>> +		.size = ERXGROUP_64K_SIZE,
>> +		.errgsr_offset = ERXGROUP_64K_OFFSET,
>> +	},
>> +};
>> +
> Thanks,
> Umang

