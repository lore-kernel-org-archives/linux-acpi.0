From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v3 05/12] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
Date: Mon, 1 Feb 2016 19:09:44 +0100
Message-ID: <20160201180944.GV24726@rric.localdomain>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-6-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453541967-3744-6-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Shannon Zhao <shannon.zhao@linaro.org>, Steve Capper <steve.capper@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 23.01.16 17:39:20, Hanjun Guo wrote:

> @@ -385,10 +386,8 @@ void __init arm64_numa_init(void)
>  {
>  	int ret = -ENODEV;
>  
> -#ifdef CONFIG_OF_NUMA
>  	if (!numa_off)
> -		ret = numa_init(arm64_of_numa_init);
> -#endif
> +		ret = numa_init(acpi_disabled ? arm64_of_numa_init : arm64_acpi_numa_init);
>  
>  	if (ret)
>  		numa_init(dummy_numa_init);

Ok, this style is mostly flavor, some people want #ifdefs (my
preference), some not. In any case it must build with or without the
config option set. But first some words why I like #ifdefs:

 * Code is easier to understand as you don't need to look at any other
   location whether it is enabled or not.

 * You can't break the build if the options are not set. Thus, you
   also don't need to check if the function is implemented for the
   unset case (valid for the coder and also the reviewer). This makes
   things a lot easier.

 * Total number of lines of code that needs to be implement is
   smaller.

However, if we don't ifdef the code, we need empty functions stubs in
the header file for them.

Also, the conditional assignment does not reduce the complexity of the
paths. It just concentrates everything in a single line.

How about the following (similar to x86)?

----
	if (!numa_off) {
#ifdef CONFIG_ACPI_NUMA
		if (!numa_init(acpi_numa_init))
			return 0;
#endif
#ifdef CONFIG_OF_NUMA
		if (!numa_init(of_numa_init))
			return 0;
#endif
	}

	return numa_init(dummy_numa_init);
----

Pretty straight and nice.

Note: The !acpi_disabled check needs to be moved to the beginning of
acpi_numa_init(). Variable ret can be removed.

-Robert
