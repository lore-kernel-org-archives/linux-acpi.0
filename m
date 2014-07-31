From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 10/19] ARM64 / ACPI: Get the enable method for SMP initialization
 in ACPI way
Date: Thu, 31 Jul 2014 18:57:20 +0800
Message-ID: <53DA2110.8060000@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org> <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org> <20140731065426.GA876@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:42777 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaGaK6j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jul 2014 06:58:39 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so3259692pdi.6
        for <linux-acpi@vger.kernel.org>; Thu, 31 Jul 2014 03:58:39 -0700 (PDT)
In-Reply-To: <20140731065426.GA876@quad.lixom.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@linaro.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi-private@linaro.or

On 2014-7-31 14:54, Olof Johansson wrote:
> Hi,
> 
> On Thu, Jul 24, 2014 at 09:00:16PM +0800, Hanjun Guo wrote:
>> +/*
>> + * In ACPI mode, the cpu possible map was enumerated before SMP
>> + * initialization when MADT table was parsed, so we can get the
>> + * possible map here to initialize CPUs.
>> + */
> 
> The DT smp init will warn if the kernel has been build with too low NR_CPUS.
> Does the ACPI core already warn, or did that go missing with this separate code
> path?

ACPI code will warn, it is in PATCH 07/19,

+	if (enabled_cpus >=  NR_CPUS) {
+		pr_warn("NR_CPUS limit of %d reached, Processor %d/0x%llx ignored.\n",
+			NR_CPUS, total_cpus, mpidr);
+		return -EINVAL;
+	}

> 
>> +static void __init acpi_smp_init_cpus(void)
>> +{
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		if (cpu_acpi_read_ops(cpu) != 0)
>> +			continue;
>> +
>> +		cpu_ops[cpu]->cpu_init(NULL, cpu);
>> +	}
>> +}
>> +
>> +void __init smp_init_cpus(void)
>> +{
>> +	if (acpi_disabled)
>> +		of_smp_init_cpus();
>> +	else
>> +		acpi_smp_init_cpus();
> 
> I'm liking these deeply split code paths less and less every time I see
> them. :(
> 
> I would prefer to set up shared state in separate functions, but keep the
> control flow the same. Right now you're splitting it completely.
> 
> I.e. split data setup between the two, but do the loop calling cpu_init()
> the same way. (Yes, that will require you to refactor the DT code path
> a bit too...)

OK, I will dive into the code and figure out if I can fix that as you
suggested, thanks for your comments :)

Best Regards
Hanjun
