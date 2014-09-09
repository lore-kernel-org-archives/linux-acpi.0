From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Tue, 09 Sep 2014 00:23:25 -0400
Message-ID: <540E80BD.20801@redhat.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>linux
List-Id: linux-acpi@vger.kernel.org

On 09/01/2014 10:57 AM, Hanjun Guo wrote:
> MADT contains the information for MPIDR which is essential for
> SMP initialization, parse the GIC cpu interface structures to
> get the MPIDR value and map it to cpu_logical_map(), and add
> enabled cpu with valid MPIDR into cpu_possible_map.
> 
> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
> Parking protocol, but the Parking protocol is only specified for
> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
> before some updates for the ACPI spec or the Parking protocol spec.

> +	/* CPU 0 was already initialized */
> +	if (cpu) {
> +		if (cpu_ops[cpu]->cpu_init(NULL, cpu))
> +			return -EOPNOTSUPP;
> +
> +		/* map the logical cpu id to cpu MPIDR */
> +		cpu_logical_map(cpu) = mpidr;

I'm not sure it's worth noting in a comment or just in the dialogue that
none of these MPIDR values is literally the value in the MPIDR. Linux
doesn't store that anyway (even in the cpu_logical_map), since it is
pre-filtered against MPIDR_HWID_BITMASK to remove the non-affinity level
bits. And since the ACPI5.1 specification requires that non-affinity
bits be zero everything works. But it relies upon this assumption so it
might be worth explicitly masking out the bits when making the call into:

       acpi_map_gic_cpu_interface(processor->arm_mpidr,
               processor->flags & ACPI_MADT_ENABLED);

During the parsing of the processor object's MPIDR value.

Jon.
