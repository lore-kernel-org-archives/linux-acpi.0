From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Wed, 04 Mar 2015 23:56:27 +0100
Message-ID: <12535711.Yi1RhU69kM@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52416 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753136AbbCDWcw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2015 17:32:52 -0500
In-Reply-To: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On Wednesday, February 25, 2015 04:39:40 PM Hanjun Guo wrote:
> Changes since v8:
>   - remove MPIDR packing things by introducing phys_cpuid_t;
> 
>   - update patch acpi: fix acpi_os_ioremap for arm64 to follow
>     Rafael's suggestion;
> 
>   - Squash patch (disable ACPI if ACPI less than 5.1) to patch
>     (Get RSDP and ACPI boot-time table);
> 
>   - Move sleep_arm.c to arch/arm64/ and rename it as acpi_sleep.c 
> 
>   - Rework the uefi generated empty dtb to enable acpi when no dtb
>     is available, thanks Ard for the updated patch.
> 
>   - rework the function of register cpu for kexec case
> 
>   - use pr_debug() instead of pr_info() when scanning MADT.
> 
>   - rebase on top of 4.0-rc1
> 
> Thanks
> Hanjun
> 
> Al Stone (4):
>   ARM64 / ACPI: Get RSDP and ACPI boot-time tables
>   ARM64 / ACPI: Introduce early_param "acpi=" to enable/disable ACPI
>   ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on
>     ARM64
>   ARM64 / ACPI: additions of ACPI documentation for arm64
> 
> Graeme Gregory (6):
>   ACPI: add arm64 to the platforms that use ioremap
>   ACPI / sleep: Introduce arm64 specific acpi_sleep.c
>   ARM64 / ACPI: If we chose to boot from acpi then disable FDT
>   ARM64 / ACPI: Get PSCI flags in FADT for PSCI init
>   ARM64 / ACPI: Enable ARM64 in Kconfig
>   Documentation: ACPI for ARM64
> 
> Hanjun Guo (8):
>   ACPI / table: Use pr_debug() instead of pr_info() for MADT table
>     scanning
>   ACPI / processor: Introduce phys_cpuid_t for CPU hardware ID
>   ARM64 / ACPI: Introduce PCI stub functions for ACPI
>   ACPI / table: Print GIC information when MADT is parsed
>   ARM64 / ACPI: Parse MADT for SMP initialization
>   ACPI / processor: Make it possible to get CPU hardware ID via GICC
>   ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and register device's gsi
>   clocksource / arch_timer: Parse GTDT to initialize arch timer
> 
> Mark Salter (2):
>   ARM64: allow late use of early_ioremap
>   ACPI: fix acpi_os_ioremap for arm64
> 
> Tomasz Nowicki (1):
>   irqchip: Add GICv2 specific ACPI boot support

I've ACKed or commented the ones relevant for me.  As for the ARM64-specific
code, I don't think I can give any meaningful input.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
