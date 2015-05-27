From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 11/11] ARM64 / PCI / ACPI: support for ACPI based PCI
 hostbridge init
Date: Wed, 27 May 2015 15:31:51 +0800
Message-ID: <556572E7.1090802@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1432644564-24746-12-git-send-email-hanjun.guo@linaro.org> <55648D52.4000809@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35210 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbbE0HcC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2015 03:32:02 -0400
Received: by pdea3 with SMTP id a3so2831166pde.2
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2015 00:32:01 -0700 (PDT)
In-Reply-To: <55648D52.4000809@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Yijing Wang <wangyijing@huawei.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2015=E5=B9=B405=E6=9C=8826=E6=97=A5 23:12, Tomasz Nowicki wrote:
> On 26.05.2015 14:49, Hanjun Guo wrote:
>> Based on Jiang Liu's common interface to support PCI host bridge
>> init and refactoring of MMCONFIG, this patch using information
>> from ACPI MCFG table and IO/irq resources from _CRS to init
>> ARM64 PCI hostbridge, then PCI will work on ARM64.
>>
>> This patch is based on Mark Salter and Tomasz Nowicki's work.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> ---
>>   arch/arm64/Kconfig      |   7 ++
>>   arch/arm64/kernel/pci.c | 245
>> +++++++++++++++++++++++++++++++++++++++++++++---
>>   drivers/pci/pci.c       |  26 +++--
>>   3 files changed, 257 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 9b80428..8e4b789 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -276,6 +276,13 @@ config PCI_DOMAINS_GENERIC
>>   config PCI_SYSCALL
>>       def_bool PCI
>>
>> +config PCI_MMCONFIG
>> +    def_bool y
>> +    select PCI_ECAM
>> +    select HAVE_PCI_ECAM
>> +    select GENERIC_PCI_ECAM
> HAVE_PCI_ECAM and GENERIC_PCI_ECAM should be selected by platform.

OK.

>
>> +    depends on ACPI
> I think we should depend on PCI too.

Since ACPI depends on PCI, denpends on
PCI is duplicate I think.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
