From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PME via interrupt or SCI mechanism?
Date: Sat, 1 Oct 2011 22:29:55 +0200
Message-ID: <201110012229.55473.rjw@sisk.pl>
References: <20110912171003.GA7939@xanatos> <201109302221.06714.rjw@sisk.pl> <20111001003010.GA26349@xanatos>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20111001003010.GA26349@xanatos>
Sender: linux-pci-owner@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday, October 01, 2011, Sarah Sharp wrote:
> On Fri, Sep 30, 2011 at 10:21:06PM +0200, Rafael J. Wysocki wrote:
> > OK, please test the appended patch.  The difference is that it should only
> > continuously poll devices that don't get notifications.  You'll still see
> > the debug messages from your previous patches, but this one should be a bit
> > less wasteful than the previous one in general.
> 
> This patch seems to work.  The GPE fires and the xHCI host controller
> comes out of D3 after a stream of:
> 
> Sep 30 17:07:32 talon kernel: [  197.745312] ehci_hcd 0000:00:1d.0: pci_acpi_wake_dev
> Sep 30 17:07:32 talon kernel: [  197.745321] ehci_hcd 0000:00:1a.0: pci_acpi_wake_dev
> Sep 30 17:07:32 talon kernel: [  197.745326] snd_hda_intel 0000:00:1b.0: pci_acpi_wake_dev
> Sep 30 17:07:32 talon kernel: [  197.745331] e1000e 0000:00:19.0: pci_acpi_wake_dev
> 
> It does seem to take less time to come out of D3 than the previous patch
> though.
> 
> I occasionally do not see the host controller come out of D3 when I plug
> in a new device, but the interrupt count for GPE 0D doesn't increment
> when that happens, so it's probably just a BIOS or hardware bug.

I think the controller doesn't signal PME in those cases.

> Did mention this was bleeding edge hardware?

No, you didn't, but that doesn't matter a lot.  Bugs of this kind are found in
systems being sold in the market too and we need to work around them anyway. :-(

Thanks for testing the patch, I'll resent it with a changelog shortly.

Rafael
