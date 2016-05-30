From: Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH V8 9/9] pci, acpi: ARM64 support for ACPI based generic
 PCI host controller
Date: Mon, 30 May 2016 21:43:58 +0530
Message-ID: <CAKc_7PW3Hdk9zTZ53yhGVdeeFVGFaFExZEvp456s16DnnMMjWg@mail.gmail.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-10-git-send-email-tn@semihalf.com> <8385994.W7ve9PrvHG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34629 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161651AbcE3QOj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 May 2016 12:14:39 -0400
Received: by mail-yw0-f170.google.com with SMTP id c127so166034796ywb.1
        for <linux-acpi@vger.kernel.org>; Mon, 30 May 2016 09:14:39 -0700 (PDT)
In-Reply-To: <8385994.W7ve9PrvHG@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <helgaas@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Rafael Wysocki <rafael@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sinan Kaya <okaya@codeaurora.org>, robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>, Wangyijing <wangyijing@huawei.com>, Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>, Andrea Gallo <andrea.gallo@linaro.org>, Duc Dang <dhdang@apm.com>, jeremy

On Mon, May 30, 2016 at 9:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, May 30, 2016 5:14:22 PM CEST Tomasz Nowicki wrote:
>> +       bsz = 1 << pci_generic_ecam_ops.bus_shift;
>> +       cfgres.start = root->mcfg_addr + bus_res->start * bsz;
>> +       cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
>> +       cfgres.flags = IORESOURCE_MEM;
>> +       cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
>> +                             &pci_generic_ecam_ops);
>> +       if (IS_ERR(cfg)) {
>> +               pr_err("%04x:%pR error %ld mapping CAM\n", seg, bus_res,
>> +                      PTR_ERR(cfg));
>> +               return PTR_ERR(cfg);
>> +       }
>> +
>> +       ri->cfg = cfg;
>> +       return 0;
>> +}
>
> I wonder if we could do this a little simpler and just put a pointer
> to the mmconfig space into struct pci_host_bridge, and then have a trivial
> map_bus function alongside pci_generic_config_read/pci_generic_config_write.
>
> As this code is specific to arch/arm64, we don't need any of the complexity
> of drivers/pci/ecam.c, which basically only exists to work around the
> limited virtual address space of 32-bit machines.

The map_bus provided by pci-ecam.h is already trivial in 64bit case,
it was written so that it could be optimized at compile time. The
pci_ecam_create is a useful to have here instead of redoing the
request_resource/ioremap sequence.

The struct pci_config_window can be moved into struct
pci_host_bridge (or a wrapper of pci_host_bridge) when we have
the setup to point bus->sysdata to something like that. The ECAM
API can be fixed up to handle that case as well. I did not make
any changes since the pci_host_bridge discussion is still going on.

JC.
