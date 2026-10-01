Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC03C196B;
	Thu,  1 Oct 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850918; cv=none; b=lqoJr+HSK+/IHHNfFpcsNs9+YyFEbTaIWbJh2GlpbCSuttPE2ggzNuqJw+2/dvFU4slFPChBUh3HlRWtZDw1e+kWZBHbxKacK4Olbu040EaUxkMjK0T4Q+f6I5d8UgqhPk74RP1XiA3u7+AmOiwoCjQwwyjalcPmOvTWCtpSiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850918; c=relaxed/simple;
	bh=wyY4uqF8oVkqJJ4SU1baP5QoiyjE4zdP/Pl/JeO4cp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMYi/flz0czgg6LxeOz0depq9H5jLYDixhCL1d8FtoIPIrlDTzNgZMcyPdN5aPFJifmyNPmQrnDQOZserXdSE6M7CEr1TRMYVGtXOXzhNa3EU4S6z1t4Wdqux3Ilv7mPKtCwKGwFuHgCl38y/zAX1R+wOyB8EKe2sfvArT8Of74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oPjEY3kJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oPjEY3kJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xbJhgquatt87upvJf0Ak4lxdnZtpIeSb+aDtxb1CtgI=; b=oPjEY3kJQ4HBOpowg0quk/3xk2
	74VjW7/qKOuV51Z2N4Xm67I+IYiudxcplzOcQ2MxYPrU0hIQVib0HqYSQGlKUE50MyldkVXDz66r3
	WCObSwGLljzoDs9jRbVWEDa2bm08+LmAG27Ff2EUlCydIo5a6mV0Pi50lL0JnDiNkoniOfyHENxoK
	s2Fs4nUvuRETCwm1YJfnvMZPbeA0FwuSVQDB7kYziJNhLiqKfGFwwyFz0iXYfqAD2NFhdeUPUTwqB
	k71/r34eUL5HHZ4nPBmrLMfejkYUAceiku7ubqqoK3laOZXNEUhD65XiuNw220gcN7vsPhnLkRrik
	fK9B0FqQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xCE7i-00000004qdd-30Wm;
	Thu, 01 Oct 2026 10:34:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5CE9300446; Thu, 01 Oct 2026 12:34:44 +0200 (CEST)
Date: Thu, 1 Oct 2026 12:34:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, zhenglifeng1@huawei.com,
	zhongqiu.han@oss.qualcomm.com, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Shubhang Kaushik <sh@gentwo.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>, jonathanh@nvidia.com,
	zhanjie9@hisilicon.com,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/3] cpufreq: Resolve CPPC frequencies to performance
 levels
Message-ID: <20261001103444.GU4120091@noisy.programming.kicks-ass.net>
References: <20260929102957.2591657-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929102957.2591657-1-christian.loehle@arm.com>

On Tue, Sep 29, 2026 at 11:29:54AM +0100, Christian Loehle wrote:
> For table-based cpufreq drivers, the core resolves requests to supported
> frequency-table entries before governors such as schedutil compare them
> with their cached target. Different kHz requests selecting the same entry
> therefore need not reach the driver again.
> 
> Table-less cppc-cpufreq lacks this resolution: the core returns the requested
> kHz value even if firmware exposes only a few CPPC performance levels.
> Different requests can miss the governor's cache yet program the same
> Desired Performance value. The tested ARM AGI CPU exposes only 61 levels,
> with bounds visible at:
> 
>   /sys/devices/system/cpu/cpuX/acpi_cppc/{lowest,highest}_perf
> 
> Add ->resolve_freq() so table-less ->target() drivers can canonicalize
> requests without constructing a frequency table. CPPC resolves requests
> before sugov_update_next_freq(), allowing its existing cache to skip
> equivalent requests. Raw limit notifications still trigger
> reconsideration, but only changed resolved limits force a driver update.
> Failed limit writes remain pending for retry.
> 
> Testing on an ARM AGI CPU (61 distinct CPPC levels) with schedutil gives
> the following end-to-end results across 16 iterations:
> 
>   schbench -m 2 -t 31 -F 256 -n 5 -R 18000 -r 60 -w 20 -i 60
> 
>   metric                         baseline       resolve-freq      change
>   median p99                    3364 us          3280 us          -2.5%
>   mean of run p99s              3664.2 us        3299.0 us       -10.0%
>   worst run p99                 4360 us          3500 us         -19.7%
>   median throughput             16431.08 RPS     16460.69 RPS     +0.2%
> 
> In an instrumented run of the same workload, cppc_set_perf() calls fell
> from 1,136,868 to 866,703, a 23.8% reduction.
> 
> Christian Loehle (3):
>   cpufreq: Add a driver frequency resolution callback
>   cpufreq: CPPC: Resolve frequencies to performance levels
>   cpufreq: Skip updates for unchanged resolved limits
> 
>  Documentation/admin-guide/pm/cpufreq.rst |   4 +
>  Documentation/cpu-freq/cpu-drivers.rst   |  19 ++
>  drivers/cpufreq/cppc_cpufreq.c           | 257 +++++++++++++++++++++--
>  drivers/cpufreq/cpufreq.c                |  99 +++++++--
>  include/linux/cpufreq.h                  |  11 +
>  kernel/sched/cpufreq_schedutil.c         |  19 +-
>  6 files changed, 359 insertions(+), 50 deletions(-)

No objection to the kernel/sched/ change. I'm assuming rjw or other
cpufreq maintainer will take this?
