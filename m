Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9243D515;
	Wed, 22 Jul 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756445; cv=none; b=e3R3XgCkQRcTF9JppCN+8oUNDppUMCx3k1cFR7E+HhpnPLWaFBVd9lzPobzcCE6qKzFZZe9ckmKHVhFu/o1HlXzFxFv8p8WZx4ETGF8PEHsIPa8fvd7JbKpq9O3EIj9wzXTLqGDLSBxvYS2gipHBaTnoePxvED/24fFAJNE/1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756445; c=relaxed/simple;
	bh=xwr8LUCnrdENnKchnDT7SVKwsu61EN5Dq44EaIgFyFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQ8pOgHArdkEJA9pa6vXfGIN6skmHDJZBDNiQEuCg5yhsN3cD/SZI6w4m8+Zssea8ibAUjecobpQKoK3/PAyla6uiTtj2/Wrxkcorr4damhnc6nkWbotU0DDDt2HewAZSURz95gOuAzNFQ3jvKMR4mTFCb1Ajt17o21LCK5B9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEJuj4js; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEJuj4js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5D11F000E9;
	Wed, 22 Jul 2026 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756444;
	bh=WyMySADOfkdNBmTgBv+BFxJNFcV8ar22rjFpLcVIsQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEJuj4js+JtTJv0NsZkWb23cfLqGJ4yOfUWB6+wNiXLXql714QOzMzTSTAVbaFiUp
	 idzif4ciWotZpzFvCh7+k05v5RaQ7F2MQq6OUN7g45CC0qa5T/27dYV+NcUSLuPkHu
	 x2NHvFm6NHrqrOe4B0BpZYEBDMr0JWkH3pU+kOeKU+uCjTN0omjH12vBTKeyXrCXuh
	 RjIF9SpTcWbx3/FUyWFOj+XfXT01MlkO/az5dTx9lMpnkhnDIuDv9c0pKGS/p4jmpz
	 5U4Ao3XjEGNWMfZ7P67MjsUNWSCRgOWWuLaREbcyD+1BqfUmgGQIRJrMeoDOUMUV1v
	 N+6igEw9pgRMQ==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	rafael@kernel.org,
	lenb@kernel.org,
	saket.dumbre@intel.com,
	beata.michalska@arm.com,
	zhenglifeng1@huawei.com,
	sumitg@nvidia.com,
	zhanjie9@hisilicon.com,
	geert+renesas@glider.be,
	cuiyunhui@bytedance.com,
	vanshikonda@os.amperecomputing.com,
	ionela.voinescu@arm.com,
	jeremy.linton@arm.com,
	viresh.kumar@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linuxarm@huawei.com,
	Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	prime.zeng@hisilicon.com,
	wanghuiqiang@huawei.com,
	xuwei5@huawei.com,
	lihuisong@huawei.com,
	yubowen8@huawei.com,
	wangzhi12@huawei.com
Subject: Re: [PATCH v2 0/2] CPPC: reduce FFH feedback-counter sampling skew on arm64
Date: Wed, 22 Jul 2026 22:39:35 +0100
Message-ID: <178475048433.1329854.7282103675861242164.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708082818.808041-1-zhangpengjie2@huawei.com>
References: <20260708082818.808041-1-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 16:28:16 +0800, Pengjie Zhang wrote:
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
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/2] ACPI: CPPC: add paired FFH feedback-counter read hook
      https://git.kernel.org/arm64/c/9aa7df520523
[2/2] arm64: topology: read CPPC FFH feedback counters in one operation
      https://git.kernel.org/arm64/c/42971d5329d9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
