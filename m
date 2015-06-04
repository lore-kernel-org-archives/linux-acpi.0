From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
Date: Thu, 04 Jun 2015 20:28:45 +0800
Message-ID: <5570447D.3020705@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1432644564-24746-6-git-send-email-hanjun.guo@linaro.org> <20150526170817.GU1565@arm.com> <55657B02.5090805@linaro.org> <20150602133215.GC23650@red-moon> <55701A31.808@linaro.org> <20150604102253.GA31773@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33410 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbbFDM27 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2015 08:28:59 -0400
Received: by pdbqa5 with SMTP id qa5so30156983pdb.0
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jun 2015 05:28:58 -0700 (PDT)
In-Reply-To: <20150604102253.GA31773@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiang Liu <jiang.liu@linux.intel.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Yijing Wang <wangyijing@huawei.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "msalter@redhat.com" <msalter@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 2015=E5=B9=B406=E6=9C=8804=E6=97=A5 18:22, Lorenzo Pieralisi wrote:
> Hi Hanjun,
>
> On Thu, Jun 04, 2015 at 10:28:17AM +0100, Hanjun Guo wrote:
>> Hi Lorenzo,
>>
>> On 2015???06???02??? 21:32, Lorenzo Pieralisi wrote:
>>> On Wed, May 27, 2015 at 09:06:26AM +0100, Tomasz Nowicki wrote:
>>>> On 26.05.2015 19:08, Will Deacon wrote:
>>>>> On Tue, May 26, 2015 at 01:49:18PM +0100, Hanjun Guo wrote:
>>>>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>>>>
>>>>>> ECAM standard and MCFG table are architecture independent and it=
 makes
>>>>>> sense to share common code across all architectures. Both are go=
ing to
>>>>>> corresponding files - ecam.c and mcfg.c
>>>>>>
>>>>>> While we are here, rename pci_parse_mcfg to acpi_parse_mcfg.
>>>>>> We already have acpi_parse_mcfg prototype which is used nowhere.
>>>>>> At the same time, we need pci_parse_mcfg been global so acpi_par=
se_mcfg
>>>>>> can be used perfectly here.
>>>>>>
>>>>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>>>>> ---
>>>>>>     arch/x86/Kconfig               |   3 +
>>>>>>     arch/x86/include/asm/pci_x86.h |  33 ------
>>>>>>     arch/x86/pci/acpi.c            |   1 +
>>>>>>     arch/x86/pci/mmconfig-shared.c | 244 +----------------------=
-----------------
>>>>>>     arch/x86/pci/mmconfig_32.c     |   1 +
>>>>>>     arch/x86/pci/mmconfig_64.c     |   1 +
>>>>>>     arch/x86/pci/numachip.c        |   1 +
>>>>>>     drivers/acpi/Makefile          |   1 +
>>>>>>     drivers/acpi/mcfg.c            |  57 ++++++++++
>>>>>>     drivers/pci/Kconfig            |   7 ++
>>>>>>     drivers/pci/Makefile           |   5 +
>>>>>>     drivers/pci/ecam.c             | 245 +++++++++++++++++++++++=
++++++++++++++++++
>>>>>
>>>>> Why can't we make use of the ECAM implementation used by pci-host=
-generic
>>>>> and drivers/pci/access.c?
>>>>
>>>> We had that question when I had posted MMCFG patch set separately,
>>>> please see:
>>>> https://lkml.org/lkml/2015/3/11/492
>>>
>>> Yes, but the real question is, why do we need to have PCI config sp=
ace
>>> up and running before a bus struct is even created ? I think the re=
ason is
>>> the PCI configuration address space format (ACPI 6.0, Table 5-27, p=
age
>>> 108):
>>>
>>> "PCI Configuration space addresses must be confined to devices on
>>> PCI Segment Group 0, bus 0. This restriction exists to accommodate
>>> access to fixed hardware prior to PCI bus enumeration".
>>>
>>> On HW reduced platforms I do not even think this is required at all=
,
>>> we have to look into this to avoid code duplication that might well
>>> turn out useless.
>>
>> This is only for the fixed hardware, which will be not available for
>> ARM64 (reduced hardware mode), but in Generic Hardware Programming
>> Model, we using OEM-provided ACPI Machine Language (AML) code to acc=
ess
>> generic hardware registers, this will be available for reduced hardw=
are
>> too.
>>
>> So in ACPI spec, it says: (ACPI 6.0 page 66, last paragraph)
>>
>> ACPI defines eight address spaces that may be accessed by generic
>> hardware implementations. These include:
>> * System I/O space
>> * System memory space
>> * PCI configuration space
>> * Embedded controller space
>> * System Management Bus (SMBus) space
>> * CMOS
>> * PCI BAR Target
>> * IPMI space
>>
>> So if any device using the PCI address space for control, such
>> as a system reset control device, its address space can be reside
>> in PCI configuration space (who can prevent a OEM do that crazy
>> thing? :) ), and it should be accessible before the PCI bus is
>> created.
>
> Us, by changing attitude and questioning features whose usefulness
> is questionable. I will look into this and raise the point, I am not
> thrilled by the idea of adding another set of PCI accessor functions
> and drivers because we have to access a register through PCI before
> enumerating the bus (and on arm64 this is totally useless since
> we are not meant to support fixed HW anyway). Maybe we can make acpic=
a
> code use a "special" stub (ACPI specific, PCI configuration space add=
ress
> space has restrictions anyway), I have to review this set in its
> entirety to see how to do that (and I would kindly ask you to do
> it too, before saying it is not possible to implement it).

I'm willing to do that, actually, if we don't need a mechanism to
access PCI config space before the bus is created, the code can be
simplified a lot.

Thanks for your help and patient.

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
