Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEB648CFC;
	Fri, 26 Jun 2026 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438929; cv=none; b=kskrp1WuAs+IMOdmiy6TTkjOMMDgjFvOrE7kFoRDnFsNgACZHDl6ljbbzOqVfziPiqpsWU6oxrSR48kI3DZDC0FVouRjreGs6UjVLhcP0VEWkDrIqh4H5ICgN2CrdZurJi9Gk13YoGct5ORt0sjBKiQbw1kXGSzBdSqRyaokqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438929; c=relaxed/simple;
	bh=YgBD4WRa4AnYLdYytGHPKGVjEOa3JHglsmoTkI02+Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmI/3LyGmMtM41eDbnLn5OYBh7VR/ns5VnRGe93draeyC8fzYtuep3oOO9vwck0K/ubY/dcTEkxYKtWcDp6XaN8yeWPCc2A5A/bnPj+h9goB9/aBbGH0Gbm6Y76bHPvj2jHVK1bGaYVsVDj1IpGA+Ou/czOtVNdfLKJ+19xfNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 167634d8710211f1aa26b74ffac11d73-20260626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9c9653c2-96d6-4a31-8a6e-5fc2d3a26971,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:e7bac3a,CLOUDID:d89af0c5808b4f65f03b3c06f107fd71,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 167634d8710211f1aa26b74ffac11d73-20260626
X-User: pengyu@kylinos.cn
Received: from [192.168.31.66] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 156880850; Fri, 26 Jun 2026 09:55:20 +0800
Message-ID: <08fd96fa-ee3a-4904-bd11-bb08bd90436f@kylinos.cn>
Date: Fri, 26 Jun 2026 09:55:20 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] arm64: early_ioremap fails to map ACPI MADT on 64K pages
To: Will Deacon <will@kernel.org>
Cc: lpieralisi@kernel.org, akpm@linux-foundation.org,
 catalin.marinas@arm.com, guohanjun@huawei.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rafael@kernel.org,
 sudeep.holla@kernel.org
References: <ajkFE6TmwW6B/huP@lpieralisi>
 <20260623024712.3480399-1-pengyu@kylinos.cn>
 <ajp25MIQJWWE1ziY@willie-the-truck>
From: Yu Peng <pengyu@kylinos.cn>
In-Reply-To: <ajp25MIQJWWE1ziY@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/2026 8:07 PM, Will Deacon wrote:
> On Tue, Jun 23, 2026 at 10:47:12AM +0800, Yu Peng wrote:
>> Hi Lorenzo, Hanjun, Will,
>>
>> Thanks for confirming.
>>
>> I will send a proper patch for this. The change I plan to post is along
>> these lines:
>>
>> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
>> index ... .. ...
>> --- a/arch/arm64/include/asm/fixmap.h
>> +++ b/arch/arm64/include/asm/fixmap.h
>> @@ -79,7 +79,11 @@ enum fixed_addresses {
>>   	 * Temporary boot-time mappings, used by early_ioremap(),
>>   	 * before ioremap() is functional.
>>   	 */
>> +#ifdef CONFIG_ARM64_64K_PAGES
>> +#define NR_FIX_BTMAPS		(SZ_512K / PAGE_SIZE)
>> +#else
>>   #define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
>> +#endif
>>   #define FIX_BTMAPS_SLOTS	7
>>   #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> 
> I still don't understand why this issue is specific to 64k pages, though.
> 
> In the example you gave, the thing wasn't even 4k aligned.
> 
> Will

You're right, this is not specific to 64K pages.

I looked at 64K first because the current slot is only 4 pages there,
compared with 64 pages on 4K. Any initial offset therefore leaves much
less room in the page-aligned span.

A blanket SZ_512K slot does not look right either. On 4K pages it would
make the boot-ioremap area 512K * 7 = 3.5M, while arm64 requires it to
stay within one PMD:

   /*
    * The boot-ioremap range spans multiple pmds, for which
    * we are not prepared:
    */
   BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
	       != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));

So I think the better fix is to preserve the 256K payload budget and add
one page for the possible initial offset:

#define NR_FIX_BTMAPS		((SZ_256K / PAGE_SIZE) + 1)

That should allow any table up to 256K to be mapped regardless of its
initial offset, without exceeding the single-PMD constraint.

Does this direction sound reasonable?

Thanks,
Yu Peng
