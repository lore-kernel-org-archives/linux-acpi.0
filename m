From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 15/15] irqchip: mbigen: Add ACPI support
Date: Mon, 16 Jan 2017 11:38:04 +0000
Message-ID: <20170116113804.GB23703@red-moon>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-16-git-send-email-hanjun.guo@linaro.org>
 <20170113102104.GB20837@red-moon>
 <58799376.6040302@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbdAPLgQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Jan 2017 06:36:16 -0500
Content-Disposition: inline
In-Reply-To: <58799376.6040302@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, huxinwei@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>, yimin@huawei.com, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Matthias Brugger <mbrugger@suse.com>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>

On Sat, Jan 14, 2017 at 10:56:54AM +0800, Hanjun Guo wrote:
> Hi Lorenzo,
> 
> On 2017/1/13 18:21, Lorenzo Pieralisi wrote:
> > On Wed, Jan 11, 2017 at 11:06:39PM +0800, Hanjun Guo wrote:
> >> With the preparation of platform msi support and interrupt producer
> >> in DSDT, we can add mbigen ACPI support now.
> >>
> >> We are using _PRS methd to indicate number of irq pins instead
> >> of num_pins in DT to avoid _DSD usage in this case.
> >>
> >> For mbi-gen,
> >>     Device(MBI0) {
> >>           Name(_HID, "HISI0152")
> >>           Name(_UID, Zero)
> >>           Name(_CRS, ResourceTemplate() {
> >>                   Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
> >>           })
> >>
> >>           Name (_PRS, ResourceTemplate() {
> >> 		  Interrupt(ResourceProducer,...) {12,14,....}
> > I still do not understand why you are using _PRS for this, I think
> > the MBIgen configuration is static and if it is so the Interrupt
> > resource should be part of the _CRS unless there is something I am
> > missing here.
> 
> Sorry for not clear in the commit message. MBIgen is an interrupt producer
> which produces irq resource to devices connecting to it, and MBIgen itself
> don't consume wired interrupts.

That's why you mark it as ResourceProducer, but that's not a reason to
put it in the _PRS instead of _CRS.

IIUC _PRS is there to provide a way to define the possible resource
settings of a _configurable_ device (ie programmable) so that the actual
resource value you would programme with a call to its _SRS is sane (ie
the OS has a way, through the _PRS, to detect what possible resource
settings are available for the device).

I think Rafael has more insights into how the _PRS is used on x86
systems so I would ask his point of view here before merrily merging
this code.

> Also devices connecting MBIgen may not consume all the interrupts produced
> by MBIgen, for example, MBIgen may produce 128 interrupts but only half of
> them are currently used, so _PRS here means "provide interrupt resources
> may consumed by devices connecting to it".

See above.

Lorenzo
