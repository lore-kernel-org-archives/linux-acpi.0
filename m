Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032F718C332;
	Wed, 24 Jun 2026 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782298276; cv=none; b=n0W9EGhU8KKlFJCfmIQNK9jEfuY2zo5dBLWJrIRGD98GZ0XeqmlLGUJ9e9BjOtCEt+GiZZSsrLEGkI1hG6RaJ57vIsKUp0ZB20Tqy7WTh5qEE7j+pjebn65ziSv98Ri802EvqHeuDc4C45TZ7fv8aFwVGp03XPSNC3tAWi6XNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782298276; c=relaxed/simple;
	bh=Vxbl+8d2dZu7By/7j3gmZfNsyU67n8jQ5SXbplRIN68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRZJn1jKoNrGRXvUMHjhjRKLUIkujgqad92bKuK/Cdv/TyFCeTLX8k7B4McvG/47pSpo5nyR4vhMyvqsKg9bxyEIKROUEHxS5zxgVAR9w/jHTYjmyBKpaGZ+bu5qJxCwY099LaVYR0XRQCPzeg66926fplZfs+L0dU50tD7DraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tx8vEeSA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tx8vEeSA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0D8C2008;
	Wed, 24 Jun 2026 03:51:08 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 019113F62B;
	Wed, 24 Jun 2026 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782298273; bh=Vxbl+8d2dZu7By/7j3gmZfNsyU67n8jQ5SXbplRIN68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tx8vEeSA8U3NbamPN3QZUlJ7JLqNBQZ2TGZftsruuPP9mLSVYkpZLqJ7xjLOlsrUT
	 lY8pZLyo4RXM8vd17slBrPiYkqFvs2ZwxJu8QUk+C2CnmOQp0zAdwGzdJSgnPssOTI
	 n9AU05vYj0O7lixsQOzui3lbUkacSw8lxWJdz6Jg=
Date: Wed, 24 Jun 2026 12:51:00 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
	rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, sumitg@nvidia.com,
	cuiyunhui@bytedance.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	wanghuiqiang@huawei.com, xuwei5@huawei.com, lihuisong@huawei.com,
	yubowen8@huawei.com, wangzhi12@huawei.com, ionela.voinescu@arm.com,
	jeremy.linton@arm.com
Subject: Re: [PATCH 0/2] CPPC: reduce FFH feedback-counter sampling skew on
 arm64
Message-ID: <aju2lAJsEpErbf0s@arm.com>
References: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
 <aa1284c1-ea26-48ca-a7d7-022027c8228a@huawei.com>
 <agw_1IYaY4zeobZE@willie-the-truck>
 <443104e2-ba6e-454e-8469-909f35817a99@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <443104e2-ba6e-454e-8469-909f35817a99@huawei.com>

Apologies but this one completely skipped my radar.
Will have a look in the next few days.

---
BR
Beata
On Wed, May 20, 2026 at 10:55:54AM +0800, Pengjie Zhang wrote:
> 
> On 5/19/2026 6:47 PM, Will Deacon wrote:
> > On Thu, Apr 30, 2026 at 06:00:44PM +0800, zhangpengjie (A) wrote:
> > > Hi all,
> > > 
> > > Gentle ping on this thread. It has been a while since I posted it.
> > > 
> > > Could someone please take a look when you have time? If there is anything
> > > I should revise or any additional information needed, I'd be happy to
> > > update it.
> > It's hard to find active folks who have contributed meaningfully to the
> > cppc_acpi driver... I've added Ionella and Jeremy, in case they can take
> > a look.
> > 
> > Will
> Thanks Will, and thanks for adding Ionela and Jeremy.
> 
> While waiting for further comments, I would like to add some
> test data to make the effect of this series clearer.
> 
> On the test platform, the maximum frequency reported by the platform
> is 2300000. I sampled cpuinfo_cur_freq before and after applying this
> series.
> 
> Before applying the series, the samples showed visible transient outliers.
>  The minimum value was 2154583 and the maximum value was 2491071.
> There were 8 samples above 2400000 and 8 samples below 2200000.
> The largest value exceeded the platform maximum by about 8.3%.
> 
> After applying the series, the samples became much more stable.
> The minimum value was 2290243 and the maximum value was 2306310.
> There were no samples above 2400000 and no samples below 2200000.
> The largest value exceeded the platform maximum by only about 0.27%.
> 
> A summary of the 96 samples is:
> 
>                     before          after
> min              2154583         2290243
> max              2491071         2306310
> range             336488           16067
> average          2298436.4       2298479.4
> stddev             55184.1          2868.2
> samples > 2300000  26 / 96         16 / 96
> samples > 2400000   8 / 96          0 / 96
> samples < 2200000   8 / 96          0 / 96
> 
> So this series does not try to clamp the value to the platform maximum.
>  Instead, it reduces the sampling skew between the delivered and reference
> feedback counters. The remaining small deviation around 2300000 is
>  much smaller than the previous transient spikes.
> 
> One concern that may come up is that an FFH read may cause an idle
> target CPU to be woken, depending on the platform/vendor implementation.
> However, that behavior is not introduced by this series. It is already part
> of how FFH counter reads are implemented on such platforms. This series
> only changes the sampling form for the FFH feedback counters: when both
> delivered and reference counters are FFH counters, read them together
> instead of issuing two separate FFH reads.
> 
> If the target CPU has to be involved for an FFH read, doing one paired
> read should be no worse than doing two separate reads, and it also
> narrows the sampling window between the two counters.
> 
> If there is any concern about the generic hook or the arm64 implementation,
> I would be happy to revise it.
> 
> The raw data is as follows:
> before:
> 2303809 2294827 2300000 2293643 2290740 2300000 2297228 2296082
> 2301707 2295354 2296601 2303163 2296766 2296543 2295412 2298394
> 2297387 2300000 2308274 2301882 2297752 2418568 2491071 2300000
> 2183264 2296238 2434731 2296721 2439777 2302159 2301773 2298226
> 2300000 2305936 2301133 2297511 2300000 2300000 2294408 2298494
> 2295011 2302721 2295955 2301505 2298064 2297419 2298933 2189595
> 2298058 2296046 2300000 2301449 2414908 2296559 2305251 2166666
> 2296626 2173303 2300000 2298806 2411389 2301822 2297291 2300000
> 2423831 2297902 2300000 2435730 2302433 2295353 2298898 2296043
> 2321868 2294907 2300000 2157841 2296052 2206530 2300000 2297811
> 2297920 2294382 2297767 2157230 2302564 2298504 2296822 2300000
> 2296868 2294866 2154583 2290888 2302542 2292549 2300000 2184259
> 
> after:
> 2303738 2296153 2298087 2295607 2301373 2298076 2300000 2295081
> 2297788 2300000 2300000 2295238 2301449 2300000 2298488 2297911
> 2301477 2298507 2294976 2296852 2293689 2294077 2293887 2292619
> 2300000 2300000 2298072 2300000 2291943 2300000 2295370 2300000
> 2301873 2304645 2300000 2296766 2300000 2300000 2290243 2297954
> 2297183 2306310 2300000 2296889 2300000 2303800 2301970 2296888
> 2300000 2301354 2300000 2298405 2298202 2296767 2298663 2302522
> 2297821 2302471 2300000 2303233 2298226 2298698 2300000 2297291
> 2296470 2300000 2298398 2300000 2295681 2300000 2300000 2296344
> 2300000 2296008 2302375 2297977 2298447 2296519 2295565 2294866
> 2297945 2300000 2294978 2303595 2300000 2300000 2294930 2301096
> 2296271 2296086 2294482 2300000 2294843 2300000 2296803 2295708
> > > On 4/10/2026 5:41 PM, Pengjie Zhang wrote:
> > > > The legacy CPPC feedback-counter path reads the delivered and reference
> > > > performance counters separately.
> > > > 
> > > > On arm64 systems using AMU-backed CPPC FFH counters, each FFH read is
> > > > served through a cross-CPU counter read helper. Reading the counters
> > > > separately therefore widens the sampling window between them and can
> > > > skew the delivered/reference ratio used by cpuinfo_cur_freq. Under heavy
> > > > load, the skew is observable as transient values that may exceed the
> > > > platform maximum, as discussed in [1] and [2].
> > > > 
> > > > This series adds a small generic hook for architectures that can obtain
> > > > both FFH feedback counters in one operation, while preserving the
> > > > existing per-register read path as the fallback.
> > > > 
> > > > Patch 1 adds the generic CPPC hook and uses it from cppc_get_perf_ctrs().
> > > > Patch 2 implements the hook on arm64 by sampling both AMU counters in a
> > > > single operation on the target CPU.
> > > > 
> > > > [1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
> > > > [2] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
> > > > 
> > > > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > > > 
> > > > Pengjie Zhang (2):
> > > >     ACPI: CPPC: add paired FFH feedback-counter read hook
> > > >     arm64: topology: read CPPC FFH feedback counters in one operation
> > > > 
> > > >    arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++----
> > > >    drivers/acpi/cppc_acpi.c     | 58 +++++++++++++++++++++++++---
> > > >    include/acpi/cppc_acpi.h     |  7 ++++
> > > >    3 files changed, 127 insertions(+), 13 deletions(-)
> > > > 
