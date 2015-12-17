From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V2 06/23] XEN / PCI: Remove the dependence on arch x86
 when PCI_MMCONFIG=y
Date: Thu, 17 Dec 2015 11:40:00 +0100
Message-ID: <56729100.6080606@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-7-git-send-email-tn@semihalf.com>
 <56728DB0.2080800@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36005 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbLQKlx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2015 05:41:53 -0500
Received: by mail-wm0-f52.google.com with SMTP id p187so14875209wmp.1
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2015 02:41:53 -0800 (PST)
In-Reply-To: <56728DB0.2080800@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefano.Stabellini@eu.citrix.com
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 17.12.2015 11:25, Tomasz Nowicki wrote:
> On 16.12.2015 16:16, Tomasz Nowicki wrote:
>> In drivers/xen/pci.c, there are arch x86 dependent codes when
>> CONFIG_PCI_MMCONFIG is enabled, since CONFIG_PCI_MMCONFIG
>> depends on ACPI, so this will prevent XEN PCI running on other
>> architectures using ACPI with PCI_MMCONFIG enabled (such as ARM64).
>>
>> Fortunatly, it can be sloved in a simple way. In drivers/xen/pci.c,
>> the only x86 dependent code is if ((pci_probe & PCI_PROBE_MMCONF) == 0),
>> and it's defined in asm/pci_x86.h, the code means that
>> if the PCI resource is not probed in PCI_PROBE_MMCONF way, just
>> ingnore the xen mcfg init. Actually this is duplicate, because
>> if PCI resource is not probed in PCI_PROBE_MMCONF way, the
>> pci_mmconfig_list will be empty, and the if (list_empty())
>> after it will do the same job.
>>
>> So just remove the arch related code and the head file, this
>> will be no functional change for x86, and also makes xen/pci.c
>> usable for other architectures.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> ---
>>   drivers/xen/pci.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
>> index 6785ebb..9a8dbe3 100644
>> --- a/drivers/xen/pci.c
>> +++ b/drivers/xen/pci.c
>> @@ -28,9 +28,6 @@
>>   #include <asm/xen/hypervisor.h>
>>   #include <asm/xen/hypercall.h>
>>   #include "../pci/pci.h"
>> -#ifdef CONFIG_PCI_MMCONFIG
>> -#include <asm/pci_x86.h>
>> -#endif
>
> I noticed that I forgot about:
> +#include <linux/ecam.h>
>

I did not forget, I added it in patch [PATCH V2 02/23]. Sorry for noise.

Tomasz
