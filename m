From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PCI: Add information about describing PCI in ACPI
Date: Thu, 01 Dec 2016 23:37:39 +0100
Message-ID: <47776378.8X3TnsHd3Q@aspire.rjw.lan>
References: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com> <20161201223604.GC15867@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58567 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752648AbcLAWlO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2016 17:41:14 -0500
In-Reply-To: <20161201223604.GC15867@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Lv Zheng <lv.zheng@intel.com>, linux-arm-kernel@lists.infradead.org

On Thursday, December 01, 2016 04:36:04 PM Bjorn Helgaas wrote:
> On Tue, Nov 29, 2016 at 03:39:48PM -0600, Bjorn Helgaas wrote:
> > Here's another stab at this writeup.  I'd appreciate any comments!
> > 
> > Changes from v1 to v2:
> >   - Consumer/Producer is defined for Extended Address Space descriptors;
> >     should be ignored for QWord/DWord/Word Address Space descriptors
> >   - New arches may use Extended Address Space descriptors in PNP0A03 for
> >     bridge registers, including ECAM (if the arch adds support for this)
> >   - Add more details about MCFG and _CBA (Lv's suggestion)
> >   - Incorporate Rafael's suggestions
> > 
> > ---
> > 
> > Bjorn Helgaas (1):
> >       PCI: Add information about describing PCI in ACPI
> > 
> > 
> >  Documentation/PCI/00-INDEX      |    2 
> >  Documentation/PCI/acpi-info.txt |  180 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 182 insertions(+)
> >  create mode 100644 Documentation/PCI/acpi-info.txt
> 
> It's very late in the cycle, but I'm considering trying to squeeze
> this into v4.9 on the grounds that:
> 
>   - It's only a documentation change and can't break anything, and
> 
>   - Distributing it more widely may help the arm64 firmware ecosystem
> 
> But I don't want to disseminate misleading or incorrect information,
> so if it needs clarification or wordsmithing, or even just maturation,
> I'll wait until v4.10.
> 
> The Consumer/Producer stuff, in particular, doesn't seem 100% settled
> yet.  Your thoughts, and especially your improvements, are welcome!

Well, what's the drawback if it doesn't go into 4.9?

Thanks,
Rafael

