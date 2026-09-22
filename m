Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519E3769FD;
	Tue, 22 Sep 2026 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041759; cv=none; b=RJLzeCc5pYSP5S3gC8QxZyR/pp5WFQXz57ffm9zYntjX8q/NE9EVmFQ+hQo+wJ/RAJ6d23YosZtlq2hN1UwwguMZAspHKl0m0itqeI3MYwOxzhQrBBbzKOCUrTGczCnYgd2XBViU5CEowCDGImZagfpBDbdphWkTOh3rRd7UHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041759; c=relaxed/simple;
	bh=l8D2tVzmXwVbuyLciTw9IU0TOLnoooEh/a9AyO+wwxI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SXjH1J2Fb1Alk3iPGB9VIKtKy4XtZ+eRro+KJFFExoQ9VxTgxjQTAAXdHob1Cv4uzxI2R9ick06N6CtRnQu1awgedZNntvz4ttmAVOPnq6P9gzK0diHlglBdxyJdfA5t7/Kezcyw7betllT4YZhkV/iGv+ADYTmCF4qM3X0e8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XEF5Aifi; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XEF5Aifi"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=u4OeW3luyIICrk7TMlGAc08jfnsvhFPtK/vh0dt3e8U=;
	b=XEF5AifigFLHzC6vPt7jWVXHWqO7TWWcV78nB/QcHJKH+wQYNSJ4PBgCX/HuDvg+1I0z2IrXa
	jThMnLDdz1DVJ7xjwM1N2r4i+3rTj7noDOt9HSYkB4YMxcNdPt4j9ZVsyzkGZJjNigM7EHNfuEe
	W5AohBmvbW1es3JjuhpjoMw=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hpjR63t71zLlXD;
	Tue, 22 Sep 2026 09:38:10 +0800 (CST)
Received: from whupemk200014.china.huawei.com (unknown [7.152.185.79])
	by mail.maildlp.com (Postfix) with ESMTPS id B3C0F4048B;
	Tue, 22 Sep 2026 09:49:12 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 whupemk200014.china.huawei.com (7.152.185.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 22 Sep 2026 09:49:11 +0800
Subject: Re: [PATCH v2 1/3] firmware: arm_ffa: Split the response out of
 ffa_msg_send_direct_req2()
To: Jamie Nguyen <jamien@nvidia.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Dat Mach <dmach@nvidia.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260901192906.133670-1-jamien@nvidia.com>
 <20260901192906.133670-2-jamien@nvidia.com>
 <348dfed7-6aa2-77a2-a0a9-3aeed22f46b8@huawei.com>
 <20260921174941.2406319-1-jamien@nvidia.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bd33caf3-76d0-eff8-23e2-a9e51136d5e3@huawei.com>
Date: Tue, 22 Sep 2026 09:49:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260921174941.2406319-1-jamien@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk200014.china.huawei.com (7.152.185.79)

On 2026/9/22 1:49, Jamie Nguyen wrote:
>> The kernel document was updated for this, please update the
>> rest of two patches as well.
> 
> I'll update all three patches to use:
> 
>      Assisted-by: LLM
> 
>> As you noted in the cover letter, the AML thread will stall here if no
>> response, block the ACPI interpreter and the ACPI global lock when
>> the field is Lock-flagged, so do we have some warnings if that happened?
> 
> There's no warning today. Would a rate-limited warning after a prolonged
> wait be useful here? I'm hesitant because that would also affect non-ACPI
> callers of this helper, and I don't believe FF-A defines a threshold after
> which the wait is abnormal.

Let's keep the code as it is.

> 
>> resp_regs[1] is confusing, comment here it links to X1 register
>> is better.
> 
> I'll clarify that resp_regs[1] is X2; resp_regs[0] is X1.

Sorry, but it was confusing me :)

Thanks
Hanjun
