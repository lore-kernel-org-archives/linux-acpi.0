From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v2 0/5] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
Date: Fri, 27 May 2016 16:46:42 +0300
Message-ID: <c20f022c-af3e-74be-d78e-e219f14c27a3@linaro.org>
References: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
 <CAJZ5v0is7c833aQkRm-D+TwLM+eUYeKEAdLOOdrEdT-hrC_M1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33338 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbcE0Nsl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2016 09:48:41 -0400
Received: by mail-lf0-f48.google.com with SMTP id s64so22212015lfe.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2016 06:48:40 -0700 (PDT)
In-Reply-To: <CAJZ5v0is7c833aQkRm-D+TwLM+eUYeKEAdLOOdrEdT-hrC_M1A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King <linux@arm.linux.org.uk>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Rutland <mark.rutland@arm.com>



On 05/20/2016 12:22 AM, Rafael J. Wysocki wrote:
> On Thu, May 19, 2016 at 6:15 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> This patchset adds support for ACPI_TABLE_UPGRADE for ARM64

Hi Catalin, Will,

Can you review these patches and consider ACKing the ARM64 part [5/5]
please?

Thank you
Aleksey Makarov

>>
>> These patches help with:
>>
>> 1). During development of a platform, it is much easier to debug
>> problems with tables if you can test replacement ones without having to
>> respin the firmware. In the server world, you usually don't have the
>> firmware source code, so to get it respun could be days-weeks even if
>> you are working with the authors closely. We have practically used this
>> feature on a number of platforms already and it will continue.
>>
>> 2). They empower (advanced) users and developers to work around problems
>> that they find on platforms. Sure, we want firmware to always be fixed
>> and working well, but it is better if folks have the tools.
>>
>> It's also required for parity with x86 functionality on servers as Redhat
>> use that method in their tooling.
>>
>> The patchset refactors the code introduced by the patches by Lv Zheng [1],
>> fixes access to the destination of new ACPI tables as suggested
>> by Mark Rutland [2] and enables the feature for ARM64
>>
>> It was first sent by Jon Masters [3] to linaro-acpi in December 2015
>>
>> Tested on QEMU (arm64 and x86) and ThunderX
>> Should be applied to next-20160519
>>
>> v2:
>> - add Acked-by: Lv Zheng <lv.zheng@intel.com>
>> - replace the original patch "ACPI: table upgrade: move early_initrd_acpi_init()
>>   to header file" with the patch "ACPI: table upgrade: refactor function
>>   definitions".  This new patch is just the original one rewritten following the
>>   suggestion by Lv Zheng to use initrd_start, inird_end directly in
>>   acpi_table_initrd_init().  It simplifies things noticeably.
>> - add Jon's explanations to the cover of the patchset and my explanations
>>   to "ACPI: ARM64: support for ACPI_TABLE_UPGRADE"
>> - introduce ARCH_HAS_ACPI_TABLE_UPGRADE in a separate patch (Mark Rutland)
>> - move arch-specific definition to an arch-specific header in a separate patch
>>   (Mark Rutland)
>>
>> v1:
>> https://lkml.kernel.org/g/1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org
>>
>> [1] https://lkml.kernel.org/g/cover.1460340514.git.lv.zheng@intel.com
>> [2] https://lists.linaro.org/pipermail/linaro-acpi/2015-December/006101.html
>> [3] https://lists.linaro.org/pipermail/linaro-acpi/2015-December/006099.html
>>
>> Aleksey Makarov (4):
>>   ACPI: table upgrade: use cacheable map for tables
>>   ACPI: table upgrade: refactor function definitions
>>   ACPI: table upgrade: move arch-specific symbol to asm/acpi.h
>>   ACPI: table upgrade: introduce ARCH_HAS_ACPI_TABLE_UPGRADE
>>
>> Jon Masters (1):
>>   ACPI: ARM64: support for ACPI_TABLE_UPGRADE
>>
>>  arch/arm64/Kconfig            |  1 +
>>  arch/arm64/include/asm/acpi.h |  2 ++
>>  arch/arm64/kernel/setup.c     |  6 ++++--
>>  arch/x86/Kconfig              |  1 +
>>  arch/x86/include/asm/acpi.h   |  2 ++
>>  arch/x86/kernel/setup.c       |  9 +--------
>>  drivers/acpi/Kconfig          |  5 ++++-
>>  drivers/acpi/tables.c         | 23 +++++++++--------------
>>  include/linux/acpi.h          |  8 ++++++--
>>  9 files changed, 30 insertions(+), 27 deletions(-)
> 
> I'm fine with the series.
> 
> I can queue up patches [1-4/5] for 4.8, but I'll need an ACK from the
> ARM64 maintainers for the [5/5].
> 
> Thanks,
> Rafael
> 
