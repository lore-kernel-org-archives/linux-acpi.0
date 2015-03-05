From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
Date: Thu, 5 Mar 2015 11:27:08 +0000
Message-ID: <20150305112707.GB7712@e104818-lin.cambridge.arm.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-15-git-send-email-hanjun.guo@linaro.org>
 <2411054.s4TkmAUKjT@vostro.rjw.lan>
 <54F80DC9.3090808@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56710 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932491AbbCEL1P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Mar 2015 06:27:15 -0500
Content-Disposition: inline
In-Reply-To: <54F80DC9.3090808@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Timur Tabi <timur@codeaurora.org>, linaro-acpi@lists.linaro.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, suravee.suthikulpanit@amd.com, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Jon Masters <jcm@redhat.com>

On Thu, Mar 05, 2015 at 04:03:21PM +0800, Hanjun Guo wrote:
> On 2015/3/5 6:46, Rafael J. Wysocki wrote:
> > IMO, you really need to define phys_cpuid_t in a common place or people will
> > forget that it may be 64-bit, because they'll only be looking at their arch.
> 
> Since x86 and ARM64 are using different types for phys_cpuid_t, we need to
> introduce something like following if define it in common place:
> 
> in linux/acpi.h,
> 
> #if defined(CONFIG_X86) || defined(CONFIG_IA64)
> typedef u32 phys_cpuid_t;
> #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> #else if defined(CONFIG_ARM64)
> typedef u64 phys_cpuid_t;
> #define PHYS_CPUID_INVALID INVALID_HWID
> #endif
> 
> I think it's awful, did I miss something?

I also think that's awful. I'm rather in favour of a per-arch
phys_cpuid_t.

-- 
Catalin
