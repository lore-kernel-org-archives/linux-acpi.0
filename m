Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C523BCF7;
	Tue,  4 Aug 2026 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814865; cv=none; b=WOqIDDME/ATxHmnKZvIcPGZzLEWG79IbhQjRR/pHj5/n7E3Qkfpz0gnE5UQ5+BWTXr2tsEuhdKNUWLn3j+ZT/S8iLHLuoUGDwk7+dxLB4gi35ZlU14wSlctjGzOsnmzDcpTfPbDRp+FI5K9vApspSYY94Dp5/GfhFs6TLWUkljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814865; c=relaxed/simple;
	bh=vzJ41jPN/u8HMKStZ+4Pzn55nzgnPNZq6nYcM4vT/Gs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oUs3AziBI27pWvjj5BW8sE9RFDx5YkW46Ed3dd3pZojSTVO/fgtf+9ax0IiHiJmhjB4CjWxYq+iYtTAFSAQAviqM9yR8Oc8F3iEKRtR1xiVqqG+L283bzkMSleLrBg6QHtQazgjjQVT4tz+3BGfyHTGMFOiCwGq5235wxWnLzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5AFyl/oA; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5AFyl/oA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0gNsJ/Pwgz+co6YvHtsUIL0nYmGfCdnKlrHydmems0k=;
	b=5AFyl/oARe5n9mThMmRQ0qS66Gx3BTYeRvTaj/ql4ppuYW4fYTf/xa+H4y2/Du+kXCfkaCkG9
	WCmROvBwp1QVGAQJwzMCzxLuF/gHKdA6i801W7ncGzr4Gf44huAOtSdJM8o5oQGVpGqyxxRLTAc
	RJPSNjAtLY4oiS87Nc6hDZw=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hDfGP1bjczpSvB;
	Tue,  4 Aug 2026 11:31:25 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B61A34057D;
	Tue,  4 Aug 2026 11:40:52 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Aug 2026 11:40:51 +0800
Subject: Re: [PATCH] ACPI: IORT: validate RMR node array bounds
To: Will Deacon <will@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260706094300.82618-1-pengpeng@iscas.ac.cn>
 <amzCci9-3kMZbSI4@google.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <65d0a7d6-c71b-d779-4b95-85fcd3495195@huawei.com>
Date: Tue, 4 Aug 2026 11:40:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <amzCci9-3kMZbSI4@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Will,

On 2026/7/31 23:42, Will Deacon wrote:
> On Mon, Jul 06, 2026 at 05:43:00PM +0800, Pengpeng Hou wrote:
>> IORT RMR nodes describe reserved-memory ranges through firmware
>> offset and count fields inside the current IORT node.
>>
>> Validate the generic IORT node length before dispatching it, and
>> check both the RMR descriptor array and the ID mapping array before
>> walking them.  This binds each array walk to the current node length
>> instead of only trusting the firmware-provided count.
>>
>> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> ---
>>   drivers/acpi/arm64/iort.c | 83 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 79 insertions(+), 4 deletions(-)
> 
> Hanjun, Lorenzo, any thoughts on this one?

Thanks for reminding.

In my personal opinion, this is not a real issue because if something
wrong with the IORT, the IORT will not work at booting, for example
the device will map to a wrong ITS or SMMU, the device will not work
at all, so those issues will be fixed at the pre-production stage,
correct me if I'm wrong.

But to the patch itself, it's no harm, I will comment on this patch.

Thanks
Hanjun




