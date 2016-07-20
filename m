From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH 0/3] ECAM quirks handling for ARM64 platforms
Date: Wed, 20 Jul 2016 07:05:00 +0200
Message-ID: <578F067C.7080509@semihalf.com>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
 <20160719211753.GA17840@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34203 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbcGTFFG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2016 01:05:06 -0400
Received: by mail-lf0-f50.google.com with SMTP id l69so29230232lfg.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jul 2016 22:05:05 -0700 (PDT)
In-Reply-To: <20160719211753.GA17840@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jchandra@broadcom.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org

On 19.07.2016 23:17, Bjorn Helgaas wrote:
> On Thu, Jun 02, 2016 at 10:41:00AM +0200, Tomasz Nowicki wrote:
>> This series bases on pending ACPI PCI support for ARM64:
>> https://lkml.org/lkml/2016/5/30/468
>>
>> Quirk handling relies on an idea of matching MCFG OEM ID and OEM revision
>> (the ones from standard header of MCFG table). Linker section is used
>> so that quirks can be registered using special macro (see patches) and
>> kept self contained.
>>
>> As an example, last patch presents above mechanism usage for ThunderX PEM driver.
>>
>> Tomasz Nowicki (3):
>>    pci, acpi: Match PCI config space accessors against platfrom specific
>>      ECAM quirks.
>>    arm64, pci: Start using quirks handling for ACPI based PCI host
>>      controller.
>>    pci, pci-thunder-pem: Add ACPI support for ThunderX PEM.
>>
>>   arch/arm64/kernel/pci.c            |   7 +-
>>   drivers/acpi/pci_mcfg.c            |  32 +++++++++
>>   drivers/pci/host/pci-thunder-pem.c | 132 +++++++++++++++++++++++++++++++++----
>>   include/asm-generic/vmlinux.lds.h  |   7 ++
>>   include/linux/pci-acpi.h           |  19 ++++++
>>   5 files changed, 181 insertions(+), 16 deletions(-)
>
> Is this series superceded by Dongdong's series of 6/13 ("[RFC,V2,1/2]
> ACPI/PCI: Match PCI config space accessors against platfrom specific ECAM
> quirks")?
>

Yes this series had two another versions (v2,v3) posted by someone else. 
However, I posted another v4 which is the latest one:
[RFC PATCH v4 0/5] ECAM quirks handling for ARM64 platforms
https://lkml.org/lkml/2016/6/28/165

In v4 there is one minor thing to be fixed. Do you want me to resend it 
as v5 including mentioned fix ?

Thanks,
Tomasz
