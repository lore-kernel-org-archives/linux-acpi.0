From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 3/4] ACPI: Introduce DMA ranges parsing
Date: Tue, 25 Jul 2017 10:06:15 +0100
Message-ID: <20170725090615.GA17133@red-moon>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
 <20170720144517.32529-4-lorenzo.pieralisi@arm.com>
 <37547189.Yunjf1Ri5r@aspire.rjw.lan>
 <20170724104048.GD13145@red-moon>
 <CAJZ5v0h_ySMbtGfs5_E+PCJko+3_aDo=1joDaA1_2wCT5tZe=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbdGYJE2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jul 2017 05:04:28 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h_ySMbtGfs5_E+PCJko+3_aDo=1joDaA1_2wCT5tZe=Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Robert Moore <robert.moore@intel.com>, Hanjun Guo <hanjun.guo@linaro.org>, Feng Kan <fkan@apm.com>, Jon Masters <jcm@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Nate Watterson <nwatters@codeaurora.org>

On Mon, Jul 24, 2017 at 08:42:15PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 24, 2017 at 12:40 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Sat, Jul 22, 2017 at 12:15:42AM +0200, Rafael J. Wysocki wrote:
> >
> 
> [cut]
> 
> >
> >> > +           return -EINVAL;
> >> > +   }
> >> > +
> >> > +   ret = acpi_dev_get_dma_resources(adev, &list);
> >> > +   if (ret > 0) {
> >> > +           list_for_each_entry(rentry, &list, node) {
> >> > +                   if (dma_offset && rentry->offset != dma_offset) {
> >> > +                           ret = -EINVAL;
> >> > +                           pr_warn("Can't handle multiple windows with different offsets\n");
> >> > +                           goto out;
> >> > +                   }
> >> > +                   dma_offset = rentry->offset;
> >> > +
> >> > +                   /* Take lower and upper limits */
> >> > +                   if (rentry->res->start < dma_start)
> >> > +                           dma_start = rentry->res->start;
> >> > +                   if (rentry->res->end > dma_end)
> >> > +                           dma_end = rentry->res->end;
> >> > +           }
> >> > +
> >> > +           if (dma_start >= dma_end) {
> >> > +                   ret = -EINVAL;
> >> > +                   pr_warn("Invalid DMA regions configuration\n");
> >>
> >> dev_warn()?
> >>
> >> And why _warn() and not _info()?
> >
> > Mmm..ok for the dev_ prefix - basically this would be a FW_BUG (I think
> > this specific error condition is overkill TBH, the ACPI resource
> > validation code should catch it before we even get here) not sure
> > about downgrading it to _info() though, I would leave it at this
> > loglevel - in particular in the offset check above:
> >
> >         if (dma_offset && rentry->offset != dma_offset) {
> >                 ret = -EINVAL;
> >                 pr_warn("Can't handle multiple windows with different offsets\n");
> >                 goto out;
> >         }
> 
> Well, so the "why" question above still has no answer ...

It is a firmware misconfiguration, we end up dismissing firmware
information and use the device with default/possibly misconfigured
DMA windows (ie offset == 0) for that platform, that's the reason
why I thought it would deserve a _warn rather than _info loglevel.

Thanks,
Lorenzo
