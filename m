From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH V2 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
Date: Fri, 02 Sep 2016 01:38:04 +0200
Message-ID: <2811400.eXt00oZUV7@vostro.rjw.lan>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <2194589.LrAdKSkzcT@vostro.rjw.lan> <57C79F3E.4050405@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54875 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752372AbcIAXcP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Sep 2016 19:32:15 -0400
In-Reply-To: <57C79F3E.4050405@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, arnd@arndb.de, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com

On Thursday, September 01, 2016 11:23:42 AM Dongdong Liu wrote:
> 
> 在 2016/9/1 6:56, Rafael J. Wysocki 写道:
> > On Wednesday, August 31, 2016 07:48:14 PM Dongdong Liu wrote:
> >> Add specific quirks for PCI config space accessors.This involves:
> >> 1. New initialization call hisi_pcie_acpi_init() to get RC config resource
> >> with hardcoded range address and setup ecam mapping.
> >> 2. New entry in common quirk array.
> >>
> >> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >
> > Well, what exactly is the ACPI support you're adding?  Is it the ECAM part only
> > or is there anything more to it?
> >
> 
> Hi Rafael, thanks for replying.
> 
> Our host bridge is non ECAM only for the RC bus config space;
> for any other bus underneath the root bus we support ECAM access.
> 
> In our case we cannot use the standard MCFG object to pass the RC itself config space addresses.
> The more discuss information can be found:
> https://lkml.org/lkml/2016/2/22/1087
> [...]
> I have looked into this and in our case we cannot use the
> standard MCFG object to pass the RC config space addresses.
> 
> The reason is that in our HW we have the config base addresses of the
> root complex ports that are less than 0x100000 byte distant one from
> the other as we only map the first 0x10000 bytes.
> Now the MCFG acpi framework always fix the MCFG resource size to 0x100000
> for each bus; therefore if we pass our RC addresses through MCFG we end
> up with a resource conflict.
> To give you a practical example we are in a situation where we have:
> 
> port0: [0x00000000b0080000 - 0x00000000b0080000 + 0x10000]
> port1: [0x00000000b0090000 - 0x00000000b0090000 + 0x10000]
> port2: [0x00000000b00A0000 - 0x00000000b00A0000 + 0x10000]
> port3: [0x00000000b00B0000 - 0x00000000b00B0000 + 0x10000]
> So if we pass the base addresses through MCFG the resources
> will overlap as MCFG will consider 0x100000 size for each base
> address of the root complex (only the RC bus uses that address)
> So far I do not see many option other than using _DSD to pass
> these RC config base addresses.

It still is not entirely clear to me what the "ACPI support" is here.

Do you read any configuration information from the ACPI tables or similar?

If so, where is the format of it documented?

Thanks,
Rafael

