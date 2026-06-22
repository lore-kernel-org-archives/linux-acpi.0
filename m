Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D5394794;
	Mon, 22 Jun 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118549; cv=none; b=n5oYcdXrvbnh6fnsbM5HqZekDmsiIFOxJc2RkTrY8j1XsyySYnRFOhj4+AgUNLrmGiGJiSsHL9O7TvPEOj2qF7clSmES6NXTA+gi/zkMbJgZzXkTNup/tv+Tqn3soxirWDi8jfTr4GRd0v3xmhw4Z/31leRUk1WZ3tTtzJa3J6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118549; c=relaxed/simple;
	bh=5MDFAA5/4+/nVXF1qjGMY/Td3SFGOE02LQ+jUhi4TBU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gz+cC0UBDKBsXl+cu9u8yjdgkDYTCVvnF4il35M3h0wk/f2xqOXwASZWuXg7BxXfVLCtJTHcAZbXRTJnDEk7Y1fLh53kEwnjwwQKtREvssAG7h6fFd6x6iqDzIOxmsIvCjmS0al0aIlfMDvl5cwnacTnHABRoIcwR9QIfoPFnjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=voOQsZgR; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="voOQsZgR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2/k27yuvvAcrSuI7nc2KFV7Xg5goqifRJQoC4fuhhzo=;
	b=voOQsZgRzlKYfqyFauHA+3HtskSas5ruL50C+YKIm2HyfbZEt9c0235+CQwD+tly1r9dN5DOB
	az64d8RQg5S21lQjYO9MI1N5n7V5JVw4JsJdq1eZg90rgxjElk2jBu9/OZQEP8ttXF2JuxkyfA0
	jtxqNrTBWJYk320CaJA63sQ=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gkMJ63pQ8znTVR;
	Mon, 22 Jun 2026 16:46:46 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9591240562;
	Mon, 22 Jun 2026 16:55:31 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jun 2026 16:55:30 +0800
Subject: Re: [RFC] arm64: early_ioremap fails to map ACPI MADT on 64K pages
To: Will Deacon <will@kernel.org>, Yu Peng <pengyu@kylinos.cn>
CC: Catalin Marinas <catalin.marinas@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <sudeep.holla@kernel.org>
References: <20260617060110.2846851-1-pengyu@kylinos.cn>
 <ajVVfnGIq_6zt2jC@willie-the-truck>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3cceb66d-4496-1a46-60ab-f43b0669fb71@huawei.com>
Date: Mon, 22 Jun 2026 16:55:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ajVVfnGIq_6zt2jC@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/6/19 22:43, Will Deacon wrote:
> +arm64 ACPI maintainers
> 
> On Wed, Jun 17, 2026 at 02:01:10PM +0800, Yu Peng wrote:
>> I hit an early boot failure on an arm64 system built with 64K pages while
>> parsing the ACPI MADT.
>>
>> The failing system reports:
>>
>>    PAGE_SIZE: 64K
>>    MADT physical address: 0x5a7ae018
>>    MADT length: 0x32094
> 
> The MADT isn't even 4k aligned, so why does the page size matter in this
> case?
> 
>> The failure happens when acpi_table_parse_madt() calls into early_memremap()
>> via __acpi_map_table(). The MADT itself is smaller than 256K, but its
>> placement causes the early mapping to require 5 64K pages:
>>
>>    offset within 64K page = 0x5a7ae018 & 0xffff = 0xe018
>>    mapped range           = PAGE_ALIGN(0xe018 + 0x32094)
>>                           = PAGE_ALIGN(0x400ac)
>>                           = 0x50000
>>    nrpages                = 0x50000 / 0x10000 = 5
>>
>> On arm64, NR_FIX_BTMAPS is currently derived from a 256K per-slot budget:
>>
>>    #define NR_FIX_BTMAPS        (SZ_256K / PAGE_SIZE)
>>
>> So for 64K pages, NR_FIX_BTMAPS is 4. The mapping therefore fails the
>> early_ioremap() check:
>>
>>    if (WARN_ON(nrpages > NR_FIX_BTMAPS))
>>            return NULL;
>>
>> After that, MADT parsing fails and the boot continues with symptoms such as:
>>
>>    ACPI: APIC not present
>>    missing boot CPU MPIDR, not enabling secondaries
>>    Kernel panic - not syncing: No interrupt controller found.
>>
>> A firmware change can avoid this by placing MADT so that:
>>
>>    (madt_phys & 0xffff) + madt_length <= SZ_256K
>>
>> However, I do not think ACPI requires such placement, so this looks like a
>> kernel-side robustness issue as well, especially on large arm64 systems where
>> MADT can grow with CPU topology.
>>
>> One possible kernel-side change is to increase the boot-time mapping budget for
>> CONFIG_ARM64_64K_PAGES, for example using a 512K per-slot budget only in that
>> configuration. I do not think this should be applied unconditionally to all
>> page sizes, since the arm64 early fixmap code expects the boot-ioremap range
>> to stay within one PMD.
>>
>> Has anyone seen similar failures on arm64 64K systems?
>>
>> Would maintainers prefer treating this as a firmware layout issue, or would
>> increasing the early_ioremap budget for 64K pages be acceptable?
> 
> It think it boils down to what ACPI says about the alignment of the MADT.

I checked the ACPI spec and it didn't require the alignment for ACPI
tables, but in UEFI spec, it says (for aarch64):

ACPI Tables loaded at boot time can be contained in memory of type
EfiACPIReclaimMemory (recommended) or EfiACPIMemoryNVS.

EFI memory descriptors of type EfiACPIReclaimMemory and EfiACPIMemoryNVS
must be aligned on a 4 KiB boundary and must be a multiple of 4 KiB in
size.

It only requires EfiACPIReclaimMemory type to be 4K aligned, not
for each ACPI table, because ACPI tables can be packed into the
allocated EfiACPIReclaimMemory type, correct me if I'm wrong!

Thanks
Hanjun
