From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Thu, 15 Jan 2015 15:33:00 -0600
Message-ID: <54B8320C.5090201@amd.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1bon0134.outbound.protection.outlook.com ([157.56.111.134]:46496
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932157AbbAOVdS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jan 2015 16:33:18 -0500
In-Reply-To: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 1/14/2015 9:04 AM, Hanjun Guo wrote:
> Hi,
>
> This is the v7 of ACPI core patches for ARM64 based on ACPI 5.1
>
> updates from v6:
>    - Rebased on top of 3.19-rc4, add Mack Salter's patch to use
>      the early_ioremap after paging_init() for ACPI table mappings;
>
>    - Two patches about converting apic_id to phys_id to make it arch
>      agnostic were already merged into RC4 by Rafael.
>
>    - Split patch "Parse FADT table to get PSCI flags for PSCI init"
>      into two as Lorenzo's suggestion, also fix typo and lack of __init
>      for psci_0_2_set_functions() which is spotted by Lorenzo.
>
>    - Add Tested-by from Yijing Wang.
>
> previous version is here:
> v6: https://lkml.org/lkml/2015/1/4/40
>
> 1. Why we need ACPI on ARM64?
>
>    - Grant already posted a blog about this, and stated clearly
>      why we need ACPI on ARM64:
>
>      http://www.secretlab.ca/archives/151
>
>
> 2. What we need to do before the arm64 ACPI core patches
>     could be merged into the kernel?
>
>    - Al Stone posted a TODO list and updates v2 for the
>      progress we made:
>      http://www.spinics.net/lists/arm-kernel/msg390069.html
>
>    - so from the progress we can see that we already finished
>      most of the items, and _OSI we got a plan to fix it, RFC
>      patch is on the way.
>
>
> This patch set was tested on FVP by Fuwei, and booted ok as expected.
> (No functional change since last version)
>
> Thanks
> Hanjun
>

The V7 patch series has also been re-tested on AMD Seattle server 
platform along with the "Introduce ACPI support for ahci_platform 
driver" patch series here (https://lkml.org/lkml/2015/1/5/662).

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Thanks,

Suravee

