From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Thu, 5 Mar 2015 10:57:01 -0800
Message-ID: <20150305185701.GH4932@quad.lixom.net>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:38600 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbbCES4z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2015 13:56:55 -0500
Received: by pdbfl12 with SMTP id fl12so37291895pdb.5
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2015 10:56:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

Hi,

On Wed, Feb 25, 2015 at 04:39:40PM +0800, Hanjun Guo wrote:
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

I've looked at most of the arch code besides GIC and some of the timer stuff,
which I might revisit later, but the pieces I've seen seem reasonable. I've
acked individual patches.

There are some cleanups to be made, but that can be done incrementally on top,
it's all internal implementation details.

I also haven't looked closely at the documentation patches yet, so I might have
some comments on those showing up.


-Olof
