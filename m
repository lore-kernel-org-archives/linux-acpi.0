Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115A3ACF15;
	Thu,  9 Jul 2026 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577279; cv=none; b=qgetmkBwcvz6h9l9dRWy3QhZkTirz8kUeyjZqxn72PX+vZYvU3RT2Szi4c5rWx7m59uz1KK6HzmV3iH8Ehhv0gx+TIs1/z3VlbPFBvzXE6lDSyOUVeEfKrd374ij7QLtKhymjZkued2+0qddeWPeDu8DYZpYQR9B1sbU6WbEvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577279; c=relaxed/simple;
	bh=5TwAOLITC1YXoDg2mMcYupgv1n+wMrm66cLoo63ucz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2aRi5c9RxWo/xAYBMVz3GRxfpv3kG+esqbhejrsRK3qcoaDyzx2sXSVDeUfkK8CSuY3TNRvbqN3W1cdhK6FXHUi/j+oJDvdWZBpK60ahowdMq+wSDZod8XHpIgM8Qt1ti4hKwkhVrGTMpuuwjnQ7u+A1QT/PvqgWm6EhD5GsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ca0NrPS7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ca0NrPS7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96D9A24C0;
	Wed,  8 Jul 2026 23:07:51 -0700 (PDT)
Received: from [192.168.20.93] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 395FA3F7B4;
	Wed,  8 Jul 2026 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783577275; bh=5TwAOLITC1YXoDg2mMcYupgv1n+wMrm66cLoo63ucz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ca0NrPS7WhWjH0EbrkfJ9CcgmZLP+Ci/Ix90jXf6EcrUjae7YWOHfzmh8TLgWybZL
	 mDy49MvgdKaIAQ+/FGWqal/giD0eUa2auN8dnkFFt6ShdzlIe/aWHzlXJ9xeZX7eHM
	 nA2t+0KITyq8j4vxmk0rTr15Zzt6ycKUNrq4h78w=
Message-ID: <29947b61-d2f3-4161-ac65-197cfe00a99d@arm.com>
Date: Thu, 9 Jul 2026 01:07:43 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] CPPC: reduce FFH feedback-counter sampling skew on
 arm64
To: Pengjie Zhang <zhangpengjie2@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, rafael@kernel.org, lenb@kernel.org, saket.dumbre@intel.com,
 beata.michalska@arm.com, zhenglifeng1@huawei.com, sumitg@nvidia.com,
 zhanjie9@hisilicon.com, geert+renesas@glider.be, cuiyunhui@bytedance.com,
 vanshikonda@os.amperecomputing.com, ionela.voinescu@arm.com,
 viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linuxarm@huawei.com
Cc: prime.zeng@hisilicon.com, wanghuiqiang@huawei.com, xuwei5@huawei.com,
 lihuisong@huawei.com, yubowen8@huawei.com, wangzhi12@huawei.com
References: <20260708082818.808041-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20260708082818.808041-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/8/26 3:28 AM, Pengjie Zhang wrote:
> The legacy CPPC feedback-counter path reads the delivered and reference
> performance counters separately.
> 
> On arm64 systems using AMU-backed CPPC FFH counters, each FFH read is
> served through a cross-CPU counter read helper. Reading the counters
> separately therefore widens the sampling window between them and can
> skew the delivered/reference ratio used by cpuinfo_cur_freq. Under heavy
> load, the skew is observable as transient values that may exceed the
> platform maximum, as discussed in [1] and [2].
> 
> This series adds a small generic hook for architectures that can obtain
> both FFH feedback counters in one operation, while preserving the
> existing per-register read path as the fallback.
> 
> Patch 1 adds the generic CPPC hook and uses it from cppc_get_perf_ctrs().
> Patch 2 implements the hook on arm64 by sampling both AMU counters in a
> single operation on the target CPU.
> 
> For detailed test results and data demonstrating the observable skew and
> the improvements brought by this series, please refer to [3] and [4].

So, this set appears to help considerably, I have a small script which 
after setting a fixed CPU frequency proceeds to sample cpuinfo_cur_freq 
and builds the mean/stddev/stderr and worst case error percentage. Its 
really the latter that I've been focusing on. When run under varying 
workloads, local vs cross cpu, t builds what I think is a somewhat 
reasonable picture of the machine behaviors.

Given a machine that at a baseline, has an error percentage that can 
exceed 100% (ex the actual frequency is 2.4Ghz, and it can report > 
5Ghz), this patch appears to bring the worst case down to approximately 
~20%, but usually its somewhere around 5%. This is similar to the v1 of 
the jitter patch I posted, but worse than than the best sample version 
of the jitter patch I've been promising, which does a better job 
selecting the initial sample.

But combining them is magic, the tweaked version reduces that to less 
than a percent.

The combination appears good enough to consistently detect small 
variations between the requested frequencies and the rate the delivered 
clock is claiming (ex request 2600 Mhz, consistently get 2630 Mhz +- 2Mhz).


With that:

Tested-by: Jeremy Linton <jeremy.linton@arm.com>

I have a small nitpik for review, that should only be considered if for 
some reason this gets respun, but otherwise.

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>




> 
> [1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
> [2] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
> [3] https://lore.kernel.org/all/443104e2-ba6e-454e-8469-909f35817a99@huawei.com/
> [4] https://lore.kernel.org/all/317d33d5-8279-4aa8-84b7-6ae1976636ac@huawei.com/
> 
> Tested-by: Sumit Gupta <sumitg@nvidia.com>
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
> Tested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
> Changes in v2:
> - Simplified the CPPC generic layer fallback logic to prevent pointless single-read retries.
> - Added upfront register validation in the arm64 hook to avoid unnecessary IPI overhead.
> - Explicitly flipped the -EOPNOTSUPP error to -ENODEV in the arm64 hook when AMU is unsupported, cleanly bypassing redundant CPPC generic fallbacks.
> - Addressed other kernel-doc and naming feedbacks from Beata.
> - Added Reviewed-by and Tested-by tags from Vanshidhar and Sumit
> - Link to v1: https://lore.kernel.org/all/20260410094145.4132082-1-zhangpengjie2@huawei.com/
> 
> Pengjie Zhang (2):
>    ACPI: CPPC: add paired FFH feedback-counter read hook
>    arm64: topology: read CPPC FFH feedback counters in one operation
> 
>   arch/arm64/kernel/topology.c | 92 ++++++++++++++++++++++++++++++++----
>   drivers/acpi/cppc_acpi.c     | 50 ++++++++++++++++++--
>   include/acpi/cppc_acpi.h     |  7 +++
>   3 files changed, 136 insertions(+), 13 deletions(-)
> 

