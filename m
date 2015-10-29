From: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH V3 0/6] gicv2m: acpi: Add ACPI support for GICv2m MSI
Date: Thu, 29 Oct 2015 14:25:32 -0700
Message-ID: <CADaLNDnhn+Lax6aMseA4kPsAfKHG=L0buO6Tf-U8sxfUzn38BA@mail.gmail.com>
References: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33315 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965133AbbJ2V0C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2015 17:26:02 -0400
Received: by oiad129 with SMTP id d129so48589368oia.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2015 14:26:01 -0700 (PDT)
In-Reply-To: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, linux-arm <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hi Suravee,
On Wed, Oct 21, 2015 at 11:47 AM, Suravee Suthikulpanit
<Suravee.Suthikulpanit@amd.com> wrote:
> This patch series has been forked from the following patch series since
> it no longer depends on the rest of the patches.
>
>   [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
>   https://lkml.org/lkml/2015/7/29/234
>
> It has been ported to use the newly introduced device fwnode_handle
> for ACPI irqdmain introduced by Marc in the following patch series:
>
>   [PATCH v2 00/17] Divorcing irqdomain and device_node
>   http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git irq/irq-domain-fwnode-v2
>
> The following git branch contains the submitted patches along with
> the pre-requsite patches (mainly for ARM64 PCI support for ACPI).
>
>   https://github.com/ssuthiku/linux.git v2m-multiframe-v3

I tried to clone your tree to test on my X-Gene platform but I didn't
see branch v2m-multiframe-v3.
I see similar patch set in origin/irq-domain-fwnode-v2-v2m-multiframe.
Can you please check?

>
> This has been tested on AMD Seattle (Overdrive) RevB system.
>
> NOTE: I have not tested ACPI GICv2m multiframe support since
> I don't have access to such system. Any helps are appreciated.
>
> Thanks,
> Suravee
>
> Changes from V2: (https://lkml.org/lkml/2015/10/14/1010)
>   - Minor clean up from Tomasz review comment in patch 6/6.
>
> Changes from V1: (https://lkml.org/lkml/2015/10/13/859)
>   - Rebase on top of Marc's patch to addng support for multiple MSI frames
>     (https://lkml.org/lkml/2015/10/14/271)
>   - Adding fwnode convenient functions (patch 3 and 4)
>
>
> Suravee Suthikulpanit (6):
>   pci: msi: Add support to query MSI domain for pci device
>   acpi: pci: Setup MSI domain for ACPI based pci devices
>   irqdomain: introduce is_fwnode_irqchip helper
>   irqdomain: Introduce irq_domain_get_irqchip_fwnode_name helper
>     function
>   gicv2m: Refactor to prepare for ACPI support
>   gicv2m: acpi: Introducing GICv2m ACPI support
>
>  drivers/irqchip/irq-gic-v2m.c   | 152 ++++++++++++++++++++++++++++++++++------
>  drivers/irqchip/irq-gic.c       |   5 +-
>  drivers/pci/msi.c               |  30 ++++++++
>  drivers/pci/pci-acpi.c          |  13 ++++
>  drivers/pci/probe.c             |   2 +
>  include/linux/irqchip/arm-gic.h |   4 ++
>  include/linux/irqdomain.h       |   6 ++
>  include/linux/msi.h             |   7 ++
>  include/linux/pci.h             |   7 ++
>  kernel/irq/irqdomain.c          |  20 +++++-
>  10 files changed, 223 insertions(+), 23 deletions(-)
>
> --
> 2.1.0
>

Regards,
Duc Dang.
