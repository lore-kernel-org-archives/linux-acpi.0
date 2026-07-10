Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34DB1E0E14;
	Fri, 10 Jul 2026 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690933; cv=none; b=sZSblNYJWZHZgeH5bSZx/hITH/gG8lXNkJcP9CG/pJJ8g+4uhY0yDGvGLlxsvBO6nK27slVlUBqBmHNnRI/cgheaM+gnZtrwdf4B2BrXEsh57UtHBj7qIxxylda17k/uf05KeJpnJgZTFQgCcyQYZfyCg9/mfRaGfv/8pFdKEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690933; c=relaxed/simple;
	bh=8H5ByFfTRvXUXT/9aX7bZ3Ahq+SupbteOjZbiE/Kh7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i13CaNN6eRdRiL/y7VQQzmIhMkKASeliPFAsB+QDgaNX00r59OkjFz8R/YJVw07LXIpVRwDzOyBAOdBCg7kjUbM8A0XQIHtAfwUAM8wLEFD7XXwwiRdoYgIZ2eiwaUHagGTj3vY9af/FXzYxwPnPFZU3/WSrjI+m3DIEHbZeuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FWxckjJq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FWxckjJq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B59A4176A;
	Fri, 10 Jul 2026 06:42:06 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EFC83F66F;
	Fri, 10 Jul 2026 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783690931; bh=8H5ByFfTRvXUXT/9aX7bZ3Ahq+SupbteOjZbiE/Kh7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWxckjJqRXLQXo0phZBNuTL410ZFitFuyUj3LjvnhNru64zxYeVLL+J3W+BqcCRVY
	 ioIZP7EfXsnUd4EYMDQBIQmkeKt7KfHjxumv910CfTIeyX3koMEHr/OQ5L6kuC4Tia
	 FmQtNyVkB9BiUiAXHUooSTey4QCTW8Hwd+xyRk44=
Date: Fri, 10 Jul 2026 15:42:01 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
	lenb@kernel.org, saket.dumbre@intel.com, zhenglifeng1@huawei.com,
	sumitg@nvidia.com, zhanjie9@hisilicon.com, geert+renesas@glider.be,
	cuiyunhui@bytedance.com, vanshikonda@os.amperecomputing.com,
	ionela.voinescu@arm.com, jeremy.linton@arm.com,
	viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com,
	xuwei5@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com,
	wangzhi12@huawei.com
Subject: Re: [PATCH v2 0/2] CPPC: reduce FFH feedback-counter sampling skew
 on arm64
Message-ID: <alD2qU4FNoGvP7SN@arm.com>
References: <20260708082818.808041-1-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708082818.808041-1-zhangpengjie2@huawei.com>

Looks good to me, though I guess you might need an ack from Rafael (?)

Thank you for the patches.

---
BR
Beata
On Wed, Jul 08, 2026 at 04:28:16PM +0800, Pengjie Zhang wrote:
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
>   ACPI: CPPC: add paired FFH feedback-counter read hook
>   arm64: topology: read CPPC FFH feedback counters in one operation
> 
>  arch/arm64/kernel/topology.c | 92 ++++++++++++++++++++++++++++++++----
>  drivers/acpi/cppc_acpi.c     | 50 ++++++++++++++++++--
>  include/acpi/cppc_acpi.h     |  7 +++
>  3 files changed, 136 insertions(+), 13 deletions(-)
> 
> -- 
> 2.33.0
> 
