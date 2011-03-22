From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hot plug issue on 2.6.38
Date: Tue, 22 Mar 2011 01:07:19 +0100
Message-ID: <201103220107.19893.rjw@sisk.pl>
References: <201103052254.48515.rjw@sisk.pl> <201103212351.12696.rjw@sisk.pl> <20110321235403.GA4092@xanatos>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20110321235403.GA4092@xanatos>
Sender: linux-pci-owner@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, March 22, 2011, Sarah Sharp wrote:
> On Mon, Mar 21, 2011 at 11:51:12PM +0100, Rafael J. Wysocki wrote:
> > On Monday, March 21, 2011, Sarah Sharp wrote:
> > > I compiled 2.6.38 with CONFIG_PCI_MMCONFIG=y, and I'm no longer getting
> > > "irq nobody cared" messages.  However, PCI express hot plug seems to
> > > just not work for the xHCI PCI device.  Nothing appears in dmesg when I
> > > plug in the Express Card, and the device doesn't appear in lspci.
> > > However, I can get the card to show up if I run
> > > 
> > > 	echo 1 > /sys/bus/pci/rescan
> > > 
> > > PCI hot-remove doesn't seem to work either.  The xHCI driver notices the
> > > device got removed when the debugging polling loop runs, but the
> > > driver's PCI remove functions are never called.  A rescan of the bus
> > > doesn't help, and the device still shows up in lspci (although all the
> > > registers are read as 0xffff). dmesg and lspci after the device has been
> > > removed is attached.
> > > 
> > > I've tried turning on all the PCI config options that look relavant; my
> > > .config is attached.  I've turned on PCI debug too.  The only thing that
> > > looks PCI related that I don't have turned on is ACPI_PCI_SLOT.  Do I
> > > need that?
> > > 
> > > I'm not sure how to debug this hot plug issue further.
> > 
> > Well, we still don't seem to call the _OSC on this machine.  At least your
> > dmesg output doesn't indicate so.
> > 
> > Do you have the patch from:
> > 
> > https://patchwork.kernel.org/patch/604371/
> > 
> > applied?
> 
> No, it was just 2.6.38.  When I applied that patch, PCI hot plug worked!

Cool. :-)

> dmesg is attached.  Can the patch get queued for 2.6.38 stable, or is it
> just a hack?

It's not a hack and it's goint to -stable, but it hasn't been merged by
Linus yet (AFAICS).

Thanks,
Rafael
