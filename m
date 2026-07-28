Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D841D65A;
	Tue, 28 Jul 2026 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234272; cv=none; b=rnUjg5wsJrogU/JHx6esuSQoStsOEOZ3OwL/yU0socaqjFojohy3j4tk++pZ0l45u9Uu2aetZ4rk/98S9L5Kq+Kol1jvYMuxJzIuQFjek952E93Ra3qncGpSllZHqZHQqCIjw0h+8AUqYmF/grjuEy/K4Hqvi3I6y0D7f5Yb+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234272; c=relaxed/simple;
	bh=Qmp+S4jeEmSrfkFAfQ5zyR7lzd8T38ptAobQNxd/cuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gh0wKSODcnLrBwiLEVkEus3XgsZa9lrVwkXGcakePts+cD51gDYmIIkomr/S/tQKHDb1cYZKcpy99HY5o/qE4/QqJ2ZaFJZ22Sh0VkrWXDT7LUIdZRUInj0iwJ6BKRlRdsEGXhV7f4XKgLrUM+voFgLtMM1LpX51upS9Ort8A1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SJoNAdeg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SJoNAdeg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE7D1A9A;
	Tue, 28 Jul 2026 03:24:26 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88F8A3F66F;
	Tue, 28 Jul 2026 03:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785234270; bh=Qmp+S4jeEmSrfkFAfQ5zyR7lzd8T38ptAobQNxd/cuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SJoNAdegQ7YKgun3wquk6jCn/mdv9DajGXn+1hdsfPdT+pcXBg9qEg2yzQ6VpNyta
	 yRKeNFrrELThJLda9OTQ2THOOTS49n5hTEam30QxUHBoHnctkdaAXmieiaC4TgUmV7
	 XmLOIkBrKGhWFoiXy/YoqSi8OyRf3fcUqsNrb8FY=
Message-ID: <22434d15-7e7c-457d-8431-b77db9448cf0@arm.com>
Date: Tue, 28 Jul 2026 12:24:25 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Ritwick Sharma <ritwick.sharma@arm.com>
Cc: ben.horgan@arm.com, catalin.marinas@arm.com, fenghuay@nvidia.com,
 ganapatrao.kulkarni@oss.qualcomm.com, guohanjun@huawei.com,
 james.morse@arm.com, jic23@kernel.org, lee@trager.us, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, rafael@kernel.org,
 reinette.chatre@intel.com, sramana@qti.qualcomm.com,
 srivathsa.rao@oss.qualcomm.com, sudeep.holla@kernel.org, tsoni@quicinc.com,
 will@kernel.org
References: <20260723155454.1760823-9-andre.przywara@arm.com>
 <20260728100421.4047928-1-ritwick.sharma@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260728100421.4047928-1-ritwick.sharma@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ritwick,

On 7/28/26 12:04, Ritwick Sharma wrote:
> On Thu, Jul 23, 2026 at 05:54:52PM +0200, Andre Przywara wrote:
> 
>> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>> +	if (msc->iface == MPAM_IFACE_MMIO)
>> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> 
> I tested the MPAM-Fb series on an Arm AGI CPU.

Many thanks for that, and for reporting on the list!

> I think a similar MPAM_IFACE_MMIO check is needed in
> mpam_msc_zero_mbwu_l(). Without this check, the mapped_hwpage_sz bounds
> check is also performed for an MPAM-Fb MSC, which does not have an MMIO
> mapping. I observed the following warning during testing:
> 
> [   50.638246] WARNING: drivers/resctrl/mpam_devices.c:1266 at mpam_msc_zero_mbwu_l+0x98/0xa8

Ouch, you are right, I missed that one. It seems my very limited testing 
didn't touch that code path.

> There also appears to be an off-by-one issue in the calculation of
> mapped_hwpage_sz:
> 
> 	msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
> 
> The current calculation records a size that is one byte smaller than
> the actual resource. I think this should use resource_size() instead:
> 
> 	msc->mapped_hwpage_sz = resource_size(msc_res);

Well spotted, I can make a separate patch for that, unless you beat me 
to it!

Many thanks,
Andre

> 
> Thanks,
> Ritwick

