From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 04/23] ARM64 / ACPI: Get RSDP and ACPI boot-time
 tables
Date: Wed, 25 Mar 2015 16:44:53 +0000
Message-ID: <20150325164453.GC14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-5-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:34449 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752018AbbCZBEK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Mar 2015 21:04:10 -0400
In-Reply-To: <1427205776-5060-5-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Graeme Gregory <graeme.gregory@linaro.org>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Al Stone <al.stone@linaro.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-arm-kernel@lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:37PM +0800, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> As we want to get ACPI tables to parse and then use the information
> for system initialization, we should get the RSDP (Root System
> Description Pointer) first, it then locates Extended Root Description
> Table (XSDT) which contains all the 64-bit physical address that
> pointer to other boot-time tables.
> 
> Introduce acpi.c and its related head file in this patch to provide
> fundamental needs of extern variables and functions for ACPI core,
> and then get boot-time tables as needed.
>   - asm/acenv.h for arch specific ACPICA environments and
>     implementation, It is needed unconditionally by ACPI core;
>   - asm/acpi.h for arch specific variables and functions needed by
>     ACPI driver core;
>   - acpi.c for ARM64 related ACPI implementation for ACPI driver
>     core;
> 
> acpi_boot_table_init() is introduced to get RSDP and boot-time tables,
> it will be called in setup_arch() before paging_init(), so we should
> use eary_memremap() mechanism here to get the RSDP and all the table
> pointers.
> 
> FADT Major.Minor version was introduced in ACPI 5.1, it is the same
> as ACPI version.
> 
> In ACPI 5.1, some major gaps are fixed for ARM, such as updates in
> MADT table for GIC and SMP init, without those updates, we can not
> get the MPIDR for SMP init, and GICv2/3 related init information, so
> we can't boot arm64 ACPI properly with table versions predating 5.1.
> 
> If firmware provides ACPI tables with ACPI version less than 5.1,
> OS has no way to retrieve the configuration data that is necessary
> to init SMP boot protocol and the GIC properly, so disable ACPI if
> we get an FADT table with version less that 5.1 when acpi_boot_table_init()
> called.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

