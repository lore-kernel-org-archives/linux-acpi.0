Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946D2E736F;
	Tue, 30 Jun 2026 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805054; cv=none; b=ZB+hTfMGN2tQ6rLXsAgjP7KK9DkmQ3Wf+IGGr84STAL3Grcc+fkqN5MH45LTGyMVY8TOotHY9gUE6XiqlpUd7mmx9BmIc+kmebgvEKl/ZobClmNUkmFuf618Fqb4tiKytBOhtmBenLtZkeABXhFUbl6rpgtTn4u4q8HmJxHlrkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805054; c=relaxed/simple;
	bh=BN8eiYGkiyP6NpiAY3OQR1hcH4Jl3rwH7rluJn1WxMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vELH2iPkQXxT+z3hTk7zTousPGOLJqott4eSTt/+n6tByLrJSuAKPsp+w4SSsQHnu3ecQpFcBR5ET++55DbD97nGp7IGO/GNhUJ8+7dXHZF+HsaWptexyshaCWbO0Xj9b/+kU28suekrV9KrGMhAdIbG0N4blL/MYhXmxUG3ISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pBy091Hn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pBy091Hn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78FA522D9;
	Tue, 30 Jun 2026 00:37:27 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 520DC3F836;
	Tue, 30 Jun 2026 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782805051; bh=BN8eiYGkiyP6NpiAY3OQR1hcH4Jl3rwH7rluJn1WxMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBy091Hnfvv9l9mGlh0rKR/O/KLHwrySnnYrWgsKBCmu8d5WQ7YnVf/ly4RhFOTs6
	 asY+FaAV4h5C7VgAuTJf64k4sKcr4SbVGTDF8zkxqpWR+owxJxbNrIUh/qDjocXf6x
	 nDMmvgtjP4i3CXUyFvpqW7e06TVNLLaA7Yl15CxE=
Date: Tue, 30 Jun 2026 09:37:24 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
	lenb@kernel.org, robert.moore@intel.com, zhenglifeng1@huawei.com,
	zhanjie9@hisilicon.com, sumitg@nvidia.com, cuiyunhui@bytedance.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com,
	xuwei5@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com,
	wangzhi12@huawei.com
Subject: Re: [PATCH 1/2] ACPI: CPPC: add paired FFH feedback-counter read hook
Message-ID: <akNyNKSGf5yKwtwN@arm.com>
References: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
 <20260410094145.4132082-2-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410094145.4132082-2-zhangpengjie2@huawei.com>

Gonna be a bit picky with wording so do bear with me ...

On Fri, Apr 10, 2026 at 05:41:44PM +0800, Pengjie Zhang wrote:
> cppc_get_perf_ctrs() reads the delivered and reference performance
> counters one at a time.
> 
> Allow architectures to provide both FFH feedback counters in one
> operation when that either narrows the sampling window or avoids extra
> cross-CPU reads. Add a small FFH-specific hook for that case and fall
> back to the existing per-register reads when unsupported.
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 58 ++++++++++++++++++++++++++++++++++++----
>  include/acpi/cppc_acpi.h |  7 +++++
>  2 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 2e91c5a97761..7b3e8b0597dc 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -988,6 +988,23 @@ int __weak cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
>  	return -ENOTSUPP;
>  }
>  
> +/**
> + * cpc_read_ffh_fb_ctrs() - Read FFH feedback counters together
> + * @cpunum:	CPU number to read
This reads bit awkward. Target CPU maybe ?
> + * @reg1:	first CPPC register information
> + * @val1:	place holder for first return value
> + * @reg2:	second CPPC register information
> + * @val2:	place holder for second return value
> + *
> + * Return: 0 for success and error code
0 on success, error code otherwise ?
> + */
> +int __weak cpc_read_ffh_fb_ctrs(int cpunum, struct cpc_reg *reg1,
> +				u64 *val1, struct cpc_reg *reg2, u64 *val2)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +
>  /**
>   * cpc_write_ffh() - Write FFH register
>   * @cpunum:	CPU number to write
> @@ -1504,6 +1521,40 @@ bool cppc_perf_ctrs_in_pcc(void)
>  }
>  EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>  
> +static int cppc_read_perf_fb_ctrs(int cpunum,
> +				  struct cpc_register_resource *delivered_reg,
> +				  struct cpc_register_resource *reference_reg,
> +				  u64 *delivered, u64 *reference)
The signature here differs from cpc_read_ffh_fb_ctrs.
It's not an issue but it might be good idea to stay consistent maybe ?
Also ... was about to suggest to stick to either perf_ctrs or feedback_ctrs
in naming but it seems the is no clear pattern  withint the file
...
> +{
> +	int ret;
> +
> +	/*
> +	 * For FFH feedback counters, try a paired read first to reduce
> +	 * sampling skew between delivered and reference counters. Fall
> +	 * back to the existing per-register reads if unsupported.
> +	 */
> +	if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
> +		ret = cpc_read_ffh_fb_ctrs(cpunum,
> +					&delivered_reg->cpc_entry.reg, delivered,
> +					&reference_reg->cpc_entry.reg, reference);
> +		if (!ret)
> +			return 0;
> +
> +		if (ret != -EOPNOTSUPP)
> +			return ret;
Shouldn't this one be enough ? Don't think you need the first condition.
> +	}
> +
> +	ret = cpc_read(cpunum, delivered_reg, delivered);
> +	if (ret)
> +		return ret;
> +
> +	ret = cpc_read(cpunum, reference_reg, reference);
> +	if (ret)
> +		return ret;
As you are not doing anything with 'ret' this could just be:
	ret = cpc_read(cpunum, delivered_reg, delivered);
	if (ret) return ret;
	return cpc_read(cpunum, reference_reg, reference);

Though that's minor.

---
BR
Beata
> +
> +	return 0;
> +}
> +
>  /**
>   * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>   * @cpunum: CPU from which to read counters.
> @@ -1547,11 +1598,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  		}
>  	}
>  
> -	ret = cpc_read(cpunum, delivered_reg, &delivered);
> -	if (ret)
> -		goto out_err;
> -
> -	ret = cpc_read(cpunum, reference_reg, &reference);
> +	ret = cppc_read_perf_fb_ctrs(cpunum, delivered_reg, reference_reg,
> +				     &delivered, &reference);
>  	if (ret)
>  		goto out_err;
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index d1f02ceec4f9..006b42dbbd4b 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -172,6 +172,8 @@ extern int cppc_get_transition_latency(int cpu);
>  extern bool cpc_ffh_supported(void);
>  extern bool cpc_supported_by_cpu(void);
>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> +extern int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
> +				struct cpc_reg *reg2, u64 *val2);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
> @@ -246,6 +248,11 @@ static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
> +				       struct cpc_reg *reg2, u64 *val2)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>  {
>  	return -EOPNOTSUPP;
> -- 
> 2.33.0
> 
