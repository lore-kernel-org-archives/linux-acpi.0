From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 07/13] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
Date: Thu, 8 Mar 2018 17:20:14 +0000
Message-ID: <20180308172014.GB2780@e107981-ln.cambridge.arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-8-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180228220619.6992-8-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 28, 2018 at 04:06:13PM -0600, Jeremy Linton wrote:

[...]

> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 0c6f658054d2..1446d3f053a2 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -97,6 +97,15 @@ int func(unsigned int cpu)					\
>  struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
>  int init_cache_level(unsigned int cpu);
>  int populate_cache_leaves(unsigned int cpu);
> +int cache_setup_acpi(unsigned int cpu);
> +int acpi_find_last_cache_level(unsigned int cpu);
> +#ifndef CONFIG_ACPI
> +int acpi_find_last_cache_level(unsigned int cpu)

This has got to be a static inline function declaration (see kbot report).

Lorenzo

> +{
> +	/* ACPI kernels should be built with PPTT support */
> +	return 0;
> +}
> +#endif
>  
>  const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
>  
> -- 
> 2.13.6
> 
