Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBE2045AD;
	Fri, 17 Jul 2026 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784251484; cv=none; b=HjKiC4xHJ6hKlez2QJg7hsYSicGi2TlUZujLGEi52kiC40bGGzuX4VuvGs70pJbxSOgab4nbxhjux012MRSL4M727aFJGnoF4sj+3OZtwP6bHiSduVZOqfALLP8yYiXPh+lp+AwMHZVSUoUErj2leVM0xuysZD+e1AbEdMnBavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784251484; c=relaxed/simple;
	bh=pHXNTKbXJTBG/BABfTPnzc62yMveXx2geBRWMXkLfsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pPvRpuID8JkVaHaRyMSDaEISzNWl8RlPZDWTqP9I1BKK3ZC7EPou/Ei86yiFLx/jjwgf69yV7Mu5dSA0GyfShjsk7tuSKAqLPAcOI7gGQSwK25L3pChJfnD+3mW4t2Fww5Qafx5u6/YLW92UGFAALWXkulIPhc0cWdoUaASsnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kxGSgzcA; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kxGSgzcA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SXoeLzz0joNDaurArO4fsXPyADL0JdoAhkTv0ebLgpA=;
	b=kxGSgzcAVEnTkZ+VJacFArpr5p48N0MwJrODTo7eCHO5onknMoIdiCpZMUJWcU9qEQPcFzM5Y
	Y7GN6f8J9bQDIP1QPthCGJDk5Q9vsKoyHBRxYELelNm14X8cNdPVHbRQHF4rZHKGlEOnI2oC9et
	utTFBzxExpve7QfWkUCyH6c=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h1X5T2dChz1prQs;
	Fri, 17 Jul 2026 09:15:09 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id BD1CB40577;
	Fri, 17 Jul 2026 09:24:30 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Jul
 2026 09:24:29 +0800
Message-ID: <4d235a1b-41e1-4797-ad56-467d8d840b03@huawei.com>
Date: Fri, 17 Jul 2026 09:24:29 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] CPPC: reduce FFH feedback-counter sampling skew on
 arm64
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <saket.dumbre@intel.com>, <zhenglifeng1@huawei.com>,
	<sumitg@nvidia.com>, <zhanjie9@hisilicon.com>, <geert+renesas@glider.be>,
	<cuiyunhui@bytedance.com>, <vanshikonda@os.amperecomputing.com>,
	<ionela.voinescu@arm.com>, <jeremy.linton@arm.com>,
	<viresh.kumar@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <wangzhi12@huawei.com>, Beata
 Michalska <beata.michalska@arm.com>
References: <20260708082818.808041-1-zhangpengjie2@huawei.com>
 <alD2qU4FNoGvP7SN@arm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <alD2qU4FNoGvP7SN@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Hi Rafael,

Just a gentle ping on this patch. It has been a week and Beata has taken
a look at it. Could you please let me know if you have any comments or
concerns regarding this change?

Thanks,
     Pengjie

On 7/10/2026 9:42 PM, Beata Michalska wrote:
> Looks good to me, though I guess you might need an ack from Rafael (?)
>
> Thank you for the patches.
>
> ---
> BR
> Beata
> On Wed, Jul 08, 2026 at 04:28:16PM +0800, Pengjie Zhang wrote:
>> The legacy CPPC feedback-counter path reads the delivered and reference
>> performance counters separately.
>>
>> On arm64 systems using AMU-backed CPPC FFH counters, each FFH read is
>> served through a cross-CPU counter read helper. Reading the counters
>> separately therefore widens the sampling window between them and can
>> skew the delivered/reference ratio used by cpuinfo_cur_freq. Under heavy
>> load, the skew is observable as transient values that may exceed the
>> platform maximum, as discussed in [1] and [2].
>>
>> This series adds a small generic hook for architectures that can obtain
>> both FFH feedback counters in one operation, while preserving the
>> existing per-register read path as the fallback.
>>
>> Patch 1 adds the generic CPPC hook and uses it from cppc_get_perf_ctrs().
>> Patch 2 implements the hook on arm64 by sampling both AMU counters in a
>> single operation on the target CPU.
>>
>> For detailed test results and data demonstrating the observable skew and
>> the improvements brought by this series, please refer to [3] and [4].
>>
>> [1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
>> [2] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
>> [3] https://lore.kernel.org/all/443104e2-ba6e-454e-8469-909f35817a99@huawei.com/
>> [4] https://lore.kernel.org/all/317d33d5-8279-4aa8-84b7-6ae1976636ac@huawei.com/
>>
>> Tested-by: Sumit Gupta <sumitg@nvidia.com>
>> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
>> Tested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>> Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>> ---
>> Changes in v2:
>> - Simplified the CPPC generic layer fallback logic to prevent pointless single-read retries.
>> - Added upfront register validation in the arm64 hook to avoid unnecessary IPI overhead.
>> - Explicitly flipped the -EOPNOTSUPP error to -ENODEV in the arm64 hook when AMU is unsupported, cleanly bypassing redundant CPPC generic fallbacks.
>> - Addressed other kernel-doc and naming feedbacks from Beata.
>> - Added Reviewed-by and Tested-by tags from Vanshidhar and Sumit
>> - Link to v1: https://lore.kernel.org/all/20260410094145.4132082-1-zhangpengjie2@huawei.com/
>>
>> Pengjie Zhang (2):
>>    ACPI: CPPC: add paired FFH feedback-counter read hook
>>    arm64: topology: read CPPC FFH feedback counters in one operation
>>
>>   arch/arm64/kernel/topology.c | 92 ++++++++++++++++++++++++++++++++----
>>   drivers/acpi/cppc_acpi.c     | 50 ++++++++++++++++++--
>>   include/acpi/cppc_acpi.h     |  7 +++
>>   3 files changed, 136 insertions(+), 13 deletions(-)
>>
>> -- 
>> 2.33.0
>>
