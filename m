From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 10/19] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
Date: Wed, 30 Jul 2014 23:54:26 -0700
Message-ID: <20140731065426.GA876@quad.lixom.net>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@linaro.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi-private@linaro.or
List-Id: linux-acpi@vger.kernel.org

Hi,

On Thu, Jul 24, 2014 at 09:00:16PM +0800, Hanjun Guo wrote:
> +/*
> + * In ACPI mode, the cpu possible map was enumerated before SMP
> + * initialization when MADT table was parsed, so we can get the
> + * possible map here to initialize CPUs.
> + */

The DT smp init will warn if the kernel has been build with too low NR_CPUS.
Does the ACPI core already warn, or did that go missing with this separate code
path?

> +static void __init acpi_smp_init_cpus(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cpu_acpi_read_ops(cpu) != 0)
> +			continue;
> +
> +		cpu_ops[cpu]->cpu_init(NULL, cpu);
> +	}
> +}
> +
> +void __init smp_init_cpus(void)
> +{
> +	if (acpi_disabled)
> +		of_smp_init_cpus();
> +	else
> +		acpi_smp_init_cpus();

I'm liking these deeply split code paths less and less every time I see
them. :(

I would prefer to set up shared state in separate functions, but keep the
control flow the same. Right now you're splitting it completely.

I.e. split data setup between the two, but do the loop calling cpu_init()
the same way. (Yes, that will require you to refactor the DT code path
a bit too...)


-Olof
