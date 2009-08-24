From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PME# for add-on cards
Date: Mon, 24 Aug 2009 20:39:07 +0200
Message-ID: <200908242039.07607.rjw@sisk.pl>
References: <200908240112.39424.rjw@sisk.pl> <20090824094429.GB1134@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090824094429.GB1134@srcf.ucam.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 24 August 2009, Matthew Garrett wrote:
> On Mon, Aug 24, 2009 at 01:12:39AM +0200, Rafael J. Wysocki wrote:
> 
> > After some debugging it turned out that PCI0 is the PCI host bridge
> > (no-bus:pci0000:00), so apparently echoing PCI0 to /proc/acpi/wakeup causes
> > a wake-up GPE to be set up for the host bridge which triggers wake-up once
> > eth0 signals PME#.
> 
> Mm. That sounds entirely plausible. If it were a built-in card then the 
> DSDT would provide that GPE, but as an add-in...
> 
> > First, I wonder if that's the case in general (anybody knows?).  Second, if
> > that is the case, would it be a good idea to set up the host bridge wake-up GPE
> > by default?
> 
> I'd expect this to be the case in general, yes. Systems that work 
> without this probably have the BIOS enable it themselves on suspend. I 
> suspect we'll have to set it to make sure.

OK, Matthew, Alan, thanks for your opinions.

I'll try to implement this, then.

Best,
Rafael
