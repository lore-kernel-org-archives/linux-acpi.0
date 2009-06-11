From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] x86/pci: do assign root bus res if _CRS is used
Date: Thu, 11 Jun 2009 11:00:35 -0700
Message-ID: <20090611110035.209122a4@jbarnes-g45>
References: <49ED22EC.2040204@kernel.org>
	<200905081640.12677.bjorn.helgaas@hp.com>
	<20090520164910.6939b92b@jbarnes-g45>
	<200905210846.18292.bjorn.helgaas@hp.com>
	<20090521163737.GA7891@us.ibm.com>
	<20090527194144.GA7933@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-25.bluehost.com ([69.89.21.20]:60505 "HELO
	outbound-mail-25.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756287AbZFKSBQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jun 2009 14:01:16 -0400
In-Reply-To: <20090527194144.GA7933@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Gary Hade <garyhade@us.ibm.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>

On Wed, 27 May 2009 12:41:44 -0700
Gary Hade <garyhade@us.ibm.com> wrote:

> On Thu, May 21, 2009 at 09:37:37AM -0700, Gary Hade wrote:
> > On Thu, May 21, 2009 at 08:46:17AM -0600, Bjorn Helgaas wrote:
> > > On Wednesday 20 May 2009 5:49:10 pm Jesse Barnes wrote:
> > > > On Fri, 8 May 2009 16:40:10 -0600
> > > > Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > > > Did anything happen with this?
> > > > > 
> > > > > The longer we wait to make "use_crs" the default, the harder
> > > > > it will be, so I'd like to push ahead.
> > > > 
> > > > Here's a patch to make CRS the default.  If it looks ok I can
> > > > push it into my linux-next branch.  I'm all for using reliable
> > > > data from the BIOS.  I guess we'll find out fairly quickly if
> > > > this stuff isn't...
> > > 
> > > Thanks for following up on this, Jesse.  It was on my to-do list
> > > for yesterday, but I didn't get to it.
> > > 
> > > Yinghai mentioned a specific box where we might have trouble, but
> > > we never got enough details to really debug it.  So I think we
> > > might as well give it a shot and fine-tune it as we need to.
> > 
> > I just remembered that Andrew Morton once raised some concerns
> > related to the number of _CRS returned resources exceeding the
> > fixed resource array size -> http://lkml.org/lkml/2007/11/1/49
> > 
> > I believe PCI_BUS_NUM_RESOURCES was later increased but if 
> > that increase was insufficient to cover all systems that the
> > code will now be exposed to, it seems like the "And should we
> > really be silently ignoring this problem?  Should we at least
> > report it?" comment that was not addressed could become relevent.
> 
> Not only do we not warn, if we did warn based on the current
>     'if (info->res_num >= PCI_BUS_NUM_RESOURCES)'
> resource array overrun avoidance criteria it would be incorrect
> for a root bus that is connected to a subordinate bus with a
> transparent bridge.  We need to avoid the last 3 slots of the
> resource array since they do not get mapped to a transparent
> bridge connected subordinate bus.  I believe the below patch
> addresses these issues.
> 
> With PCI_BUS_NUM_RESOURCES currently at 16 we still have space
> to accomodate 13 _CRS returned resource descriptors which will
> hopefully be sufficient.

Ok, applied the patch (with Yinghai's suggested name change) to my
linux-next branch.  We'll see now it goes and revert it if there's
trouble.


-- 
Jesse Barnes, Intel Open Source Technology Center
