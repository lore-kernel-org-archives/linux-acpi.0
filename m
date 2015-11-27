From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Date: Fri, 27 Nov 2015 07:59:22 +0100
Message-ID: <5657FF4A.2080804@semihalf.com>
References: <564185B6.8040006@linux.intel.com>
 <20151111174647.GA30051@red-moon> <56445117.8090307@linux.intel.com>
 <56449246.2010308@semihalf.com> <56449C55.2090001@linux.intel.com>
 <5644A613.2010304@semihalf.com> <5644AAB9.6010700@linux.intel.com>
 <5645DE3A.7040406@semihalf.com> <20151113170316.GB15253@red-moon>
 <56462294.3060701@linux.intel.com> <20151120101840.GD15819@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34108 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbbK0HBJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2015 02:01:09 -0500
Received: by lffu14 with SMTP id u14so119108237lff.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2015 23:01:07 -0800 (PST)
In-Reply-To: <20151120101840.GD15819@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

On 20.11.2015 11:18, Lorenzo Pieralisi wrote:
> Hi Jiang,
>
> On Sat, Nov 14, 2015 at 01:49:08AM +0800, Jiang Liu wrote:
>
> [...]
>
>>> Not really. My concern is that there might be platforms out there with
>>> an offset between the CPU and PCI physical address spaces, and if we
>>> remove the offset value in acpi_decode_space we can break them,
>>> because in the kernel struct resource data we have to have CPU physical
>>> addresses, not PCI ones. If offset == 0, we are home and dry, I do not
>>> understand why that's a given, which is what we would assume if Jiang's
>>> patch is merged as-is unless I am mistaken.
>> We try to exclude offset from struct resource in generic ACPI code,
>> and it's the arch's responsibility to decide how to manipulate struct
>> resource object if offset is not zero.
>>
>> Currently offset is always zero for x86, and IA64 has arch specific
>> code to handle non-zero offset. So we should be safe without breaking
>> existing code. For ARM64, it's a little different from IA64 so it's
>> hard to share code between IA64 and ARM64.
>
> Can you drop the patch on the mailing lists please, we actually need it
> to get ACPI ARM64 PCIe support in the kernel, please let me know how
> you want to handle this and if you need any help.
>

Kindly reminder.

Regards,
Tomasz
