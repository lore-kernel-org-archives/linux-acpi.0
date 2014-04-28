From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 part1 07/11] ARM64 / ACPI: Introduce arch_fix_phys_package_id()
 for cpu topology
Date: Mon, 28 Apr 2014 11:00:01 +0800
Message-ID: <535DC431.4000900@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org> <1398432017-8506-8-git-send-email-hanjun.guo@linaro.org> <20140425145249.GP12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:52582 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbaD1DAU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Apr 2014 23:00:20 -0400
Received: by mail-pa0-f45.google.com with SMTP id kq14so4608427pab.18
        for <linux-acpi@vger.kernel.org>; Sun, 27 Apr 2014 20:00:19 -0700 (PDT)
In-Reply-To: <20140425145249.GP12304@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Charles.Garcia-Tobin@arm.com

Hi Mark,

On 2014-4-25 22:52, Mark Brown wrote:
> On Fri, Apr 25, 2014 at 09:20:13PM +0800, Hanjun Guo wrote:
> 
>> +/*
>> + * Use the CPU slot number provided by ACPI to update the physical
>> + * package id, then we can get the right value in the "physical id"
>> + * field of /proc/cpuinfo.
>> + */
>> +void arch_fix_phys_package_id(int num, u32 slot)
>> +{
>> +	struct cpu_topology *cpuid_topo = &cpu_topology[num];
>> +
>> +	if (cpuid_topo->cluster_id == -1)
>> +		cpuid_topo->cluster_id = slot;
>> +}
>> +EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);
> 
> This isn't going to work once we parse the MPIDR - we will always have a
> cluster ID from MPIDR unless the system is uniprocessor (which doesn't
> seem like it's going to be a common or useful case).  We'll either need
> to have something in the topology parsing path which goes out and
> queries ACPI before we try to parse MPIDR or this will need to just set
> whatever it's told to set unconditionally.

I prefer the latter way.

Since platform software (firmware) knows the topology of the system, if
ACPI describes a slot number for this CPU, I think we can use it
unconditionally.

Thanks
Hanjun
