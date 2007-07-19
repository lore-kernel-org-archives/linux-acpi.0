From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] - Increase PNP_MAX_PORT. ACPI devices can have a lot
	IO resource declarations
Date: Thu, 19 Jul 2007 11:23:35 +0200
Message-ID: <1184837015.15328.116.camel@queen.suse.de>
References: <1184595667.19959.312.camel@queen.suse.de>
	 <200707170949.47346.bjorn.helgaas@hp.com>
	 <1184746874.4062.35.camel@fanta4.site>
	 <200707181533.25366.bjorn.helgaas@hp.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937643AbXGSJX4@vger.kernel.org>
In-Reply-To: <200707181533.25366.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, Jean Delvare <khali@linux-fr.org>, Bernhard Walle <bwalle@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2007-07-18 at 15:33 -0600, Bjorn Helgaas wrote:
> On Wednesday 18 July 2007 02:21:14 am Thomas Renninger wrote:
> > On Tue, 2007-07-17 at 09:49 -0600, Bjorn Helgaas wrote:
> > > On Monday 16 July 2007 08:21:07 am Thomas Renninger wrote:
> > > > PNP0C02 devices normally have a lot more IO port declarations than
> > > > currently defined in PNP_MAX_PORT
> > > 
> > > Yes.
> > > 
> > > > I also wonder whether other limits like:
> > > >  #define PNP_MAX_MEM        4
> > > >  #define PNP_MAX_IRQ        2
> > > >  #define PNP_MAX_DMA        2
> > > > could get exceeded with pnpacpi?
> > > 
> > > Definitely.  I think the current limits come from the PNP ISA spec
> > > (sec 4.6).  I don't see similar limits in the PNPBIOS or ACPI specs,
> > > so ideally I think they should be dynamically allocated as you suggest.
> > > 
> > I wanted to implement the dynamic approach and used a dynamically
> > allocated array, filled up from beginning. While this is close to the
> > current implementation I thought this is the easiest sufficient way...
> > (I also only did this for io ports where most mem is wasted).
> > Now I am thinking about hotplug (e.g. if a SSDT with resources gets
> > hot-added, removed)... If a device can vanish, the array must get
> > reordered, not a really well fitting structure, a list (a pnp specific
> > set up, or from include/linux/list.h?) should be better?
> 
> I don't understand the array reordering problem.  Either a device exists
> or it doesn't.  Loading or unloading an SSDT should not change the number
> of resources for devices (except that it might add or remove an entire
> device).
Yes, you are right. I feared there could be cases were single resources
should be able to be removed.
> 
> I think for now, it would be sufficient to increase PNP_MAX_IRQ to 8
> and PNP_MAX_PORT to 32 and be done with it.  I don't think it's worth
> getting more complicated unless we dynamically allocate everything.
Ok.

Thanks,

   Thomas
