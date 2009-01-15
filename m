From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI hotplug panic with current git head
Date: Thu, 15 Jan 2009 14:22:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901151421110.4737@localhost.localdomain>
References: <1231604250.3642.33.camel@localhost.localdomain>
 <alpine.LFD.2.00.0901121604380.5859@localhost.localdomain>
 <1231807693.27151.21.camel@localhost.localdomain>
 <1232046108.5966.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-reply-to: <1232046108.5966.57.camel@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "Barnes, Jesse" <jesse.barnes@intel.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, shaohua.li@intel.com
List-Id: linux-acpi@vger.kernel.org

On Thu, 15 Jan 2009, James Bottomley wrote:

> On Mon, 2009-01-12 at 18:48 -0600, James Bottomley wrote:
> > On Mon, 2009-01-12 at 16:16 -0500, Len Brown wrote:
> > > > This is on an IBM Maia system with the calgary IOMMU enabled. It's a
> > > > fatal boot up panic.
> > > > 
> > > 
> > > James,
> > > A guided bisect...
> > > Please let me know which of these fail
> > > 
> > > a3a798c88a14b35e5d4ca30716dbc9eb9a1ddfe2 is 2.6.29 at ACPI merge
> > > efcb3cf7f00c3c424db012380a8a974c2676a3c8 is 2.6.29 before ACPI merge
> > 
> > Didn't try these (being after the failure)
> > 
> > > ec9f168fcc344d2ffec1c8c822076bf22dab5c33 is 2.6.28 with most ACPI
> > 
> > This is the failing one.
> > 
> > > e8443c358c34f3fe65236e24147ddf0cd0e61b08 is 2.6.28 plus just ACPICA
> > 
> > This one boots fine.
> > 
> > > Please test the "2.6.28+ACPICA" one first.
> > > If it fails, we are close so you can skip the others above
> > > and bisect between that and 2.6.28.
> > 
> > I'll try bisecting between ec9f168fcc344d2ffec1c8c822076bf22dab5c33 and
> > e8443c358c34f3fe65236e24147ddf0cd0e61b08.
> 
> OK, bisection complete.  It's not actually coming from the ACPI tree but
> from the PCI one (appropriate CC's added).
> 
> The commit causing the boot panic is:
> 
> commit e8c331e963c58b83db24b7d0e39e8c07f687dbc6
> Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Date:   Wed Dec 17 12:09:12 2008 +0900
> 
>     PCI hotplug: introduce functions for ACPI slot detection
> 
> I'm still not sure why, though

Nothing jumped out at me in the patch.
Does reverting e8c331e963c58b83db24b7d0e39e8c07f687dbc6
make the boot crash go away?

thanks,
Len Brown, Intel Open Source Technology Center
