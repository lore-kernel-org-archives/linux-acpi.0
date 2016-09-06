From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH V5 3/5] PCI: Check platform specific ECAM quirks
Date: Tue, 06 Sep 2016 21:14:27 +0200
Message-ID: <6146693.UZIeGQtNL9@wuerfel>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com> <20160905022529.GD30488@localhost> <34416dae-31e6-93b6-2ba8-f42ba61ede4f@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:62276 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbcIFTOu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Sep 2016 15:14:50 -0400
In-Reply-To: <34416dae-31e6-93b6-2ba8-f42ba61ede4f@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <helgaas@kernel.org>, gabriele.paoloni@huawei.com, rafael@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com, andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com, jhugo@codeaurora.org, linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, liudongdong3@huawei.com, linux-pci@vger.kernel.org, Liviu.Dudau@arm.com, jcm@redhat.com, msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com, jchandra@broadcom.com, ard.biesheuvel@linaro.org, dhdang@apm.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com, hanjun.guo@linaro.org

On Tuesday, September 6, 2016 7:49:49 PM CEST Tomasz Nowicki wrote:
> On 05.09.2016 04:25, Bjorn Helgaas wrote:
> > On Mon, Aug 08, 2016 at 03:05:39PM +0200, Tomasz Nowicki wrote:
> >> Some platforms may not be fully compliant with generic set of PCI config
> >> accessors. For these cases we implement the way to overwrite accessors
> >> set. Algorithm traverses available quirk list (static array),
> >> matches against <oem_id, oem_table_id, rev, domain, bus number range> and
> >> returns pci_config_window structure with fancy PCI config ops.
> >> oem_id, oem_table_id and rev come from MCFG table standard header.
> >>
> >> It is possible to define custom init call which is responsible for
> >> setting up PCI configuration access accordingly to quirk requirements.
> >> If custom init call is not defined, use standard pci_acpi_setup_ecam_mapping().
> >>
> >> pci_generic_ecam_ops will be used for platforms free from quirks.
> >>
> >> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> >> ---
> >>  drivers/pci/host/Makefile      |  1 +
> >>  drivers/pci/host/mcfg-quirks.c | 86 ++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/pci/host/mcfg-quirks.h | 20 ++++++++++
> >>  include/linux/pci-acpi.h       |  2 +
> >>  4 files changed, 109 insertions(+)
> >>  create mode 100644 drivers/pci/host/mcfg-quirks.c
> >>  create mode 100644 drivers/pci/host/mcfg-quirks.h
> >
> > If the object is to work around defects in the ACPI MCFG table, I
> > think I'd put the quirks closer to drivers/acpi/pci_mcfg.c, where we
> > parse that table.  What if we actually put them directly *in*
> > drivers/acpi/pci_mcfg.c?
> 
> Then we need to export quirk init calls or ecam ops from 
> drivers/pci/host/* directory.
> 
> Currently we keep mcfg quirk handling code and related drivers in one 
> place drivers/pci/host/

I think that's the wrong place to have it, it just leads to people
trying to share code with the host drivers in that directory, which
hasn't really worked out so far, it just adds complexity.

	Arnd
