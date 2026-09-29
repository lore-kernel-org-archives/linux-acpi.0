Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B954FDA44;
	Tue, 29 Sep 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677834; cv=none; b=dIoknO0JSuKKEu8MlsIPLdATKr69uqlQIblSP4J6StC1N/YrUb+KyP9W4YlTcM7yTuHWeSqNGhJymbS4CiPxVUTlguy4+n2EDD6S3DQrzhIpy+1mD0Sc0j1N6lu8A7p1G2/hGSuWz/Knk/WXUlnBzGMRkM8bNargcv0OmN09C0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677834; c=relaxed/simple;
	bh=Tpveh4XNU6D/ngwovmJo5878W7WdVBobXm56TA+n/Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LrqR4VID9EGdoBeKrs0aOKNfF/RMMpwa/TJP9qByLyoC4zbZ1uiEiNAT3VZft2tLgo4EDwpfr4buIU4Fp12/ko7bsP/cli+mxtl4PiuT31pA7rtEkt/aWtQn9Izbz1SIly+w9pM0KlLJt8L+cStBSLclPy+DMb04rIRpzAtbswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rZyfygmT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rZyfygmT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B72CD1516;
	Tue, 29 Sep 2026 03:30:03 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.52.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 423703F86F;
	Tue, 29 Sep 2026 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790677807; bh=Tpveh4XNU6D/ngwovmJo5878W7WdVBobXm56TA+n/Bo=;
	h=From:To:Cc:Subject:Date:From;
	b=rZyfygmTRgWWSHwMAJpjZSZbToSmZ5vlhLIkvgdoWWwwRW/Qs2i9L14hx7MyJERan
	 xOlu6yHQ1Q1zJi9q2BBUosTZDEx2/rxfsWXK12sVwtbbcHFWmMNB9lypSWwJgrEn31
	 fN0GAs3sa/5INS7FtjROdytVPpdS4OMh21g9j/Qs=
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org
Cc: zhenglifeng1@huawei.com,
	zhongqiu.han@oss.qualcomm.com,
	viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Shubhang Kaushik <sh@gentwo.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jonathanh@nvidia.com,
	zhanjie9@hisilicon.com,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/3] cpufreq: Resolve CPPC frequencies to performance levels
Date: Tue, 29 Sep 2026 11:29:54 +0100
Message-Id: <20260929102957.2591657-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For table-based cpufreq drivers, the core resolves requests to supported
frequency-table entries before governors such as schedutil compare them
with their cached target. Different kHz requests selecting the same entry
therefore need not reach the driver again.

Table-less cppc-cpufreq lacks this resolution: the core returns the requested
kHz value even if firmware exposes only a few CPPC performance levels.
Different requests can miss the governor's cache yet program the same
Desired Performance value. The tested ARM AGI CPU exposes only 61 levels,
with bounds visible at:

  /sys/devices/system/cpu/cpuX/acpi_cppc/{lowest,highest}_perf

Add ->resolve_freq() so table-less ->target() drivers can canonicalize
requests without constructing a frequency table. CPPC resolves requests
before sugov_update_next_freq(), allowing its existing cache to skip
equivalent requests. Raw limit notifications still trigger
reconsideration, but only changed resolved limits force a driver update.
Failed limit writes remain pending for retry.

Testing on an ARM AGI CPU (61 distinct CPPC levels) with schedutil gives
the following end-to-end results across 16 iterations:

  schbench -m 2 -t 31 -F 256 -n 5 -R 18000 -r 60 -w 20 -i 60

  metric                         baseline       resolve-freq      change
  median p99                    3364 us          3280 us          -2.5%
  mean of run p99s              3664.2 us        3299.0 us       -10.0%
  worst run p99                 4360 us          3500 us         -19.7%
  median throughput             16431.08 RPS     16460.69 RPS     +0.2%

In an instrumented run of the same workload, cppc_set_perf() calls fell
from 1,136,868 to 866,703, a 23.8% reduction.

Christian Loehle (3):
  cpufreq: Add a driver frequency resolution callback
  cpufreq: CPPC: Resolve frequencies to performance levels
  cpufreq: Skip updates for unchanged resolved limits

 Documentation/admin-guide/pm/cpufreq.rst |   4 +
 Documentation/cpu-freq/cpu-drivers.rst   |  19 ++
 drivers/cpufreq/cppc_cpufreq.c           | 257 +++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c                |  99 +++++++--
 include/linux/cpufreq.h                  |  11 +
 kernel/sched/cpufreq_schedutil.c         |  19 +-
 6 files changed, 359 insertions(+), 50 deletions(-)


base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
