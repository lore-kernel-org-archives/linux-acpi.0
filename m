From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PME via interrupt or SCI mechanism?
Date: Thu, 29 Sep 2011 23:38:48 +0200
Message-ID: <201109292338.48690.rjw@sisk.pl>
References: <20110912171003.GA7939@xanatos> <20110929204440.GA6043@xanatos> <201109292328.45375.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201109292328.45375.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, September 29, 2011, Rafael J. Wysocki wrote:
> On Thursday, September 29, 2011, Sarah Sharp wrote:
> > On Thu, Sep 29, 2011 at 09:39:56PM +0200, Rafael J. Wysocki wrote:
> > > On Thursday, September 29, 2011, Sarah Sharp wrote:
> > > > On Thu, Sep 29, 2011 at 12:21:28AM +0200, Rafael J. Wysocki wrote:
> > > Please try the appended patch and check if you see the "Notification error
> > > for GPE" message (please keep your previous debug patches applied).
> > 
> > Do I need to have the ACPI debug_level or debug_layer set to anything in
> > particular to see this message?
> 
> No, I don't think so, but just in case please try the patch below instead
> of the previous one.

Actually, please don't, it's a BIOS-related issue after all.  Apparently,
wakeup from xHCD is not supported by the BIOS, because the DSDT defines
the _L0D method for GPE 0D (13), which is the following:

        Method (_L0D, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.EHC1, 0x02)
            Notify (\_SB.PCI0.EHC2, 0x02)
            Notify (\_SB.PCI0.HDEF, 0x02)
            Notify (\_SB.PCI0.GLAN, 0x02)
        }

so it notifies some devices, but not the xHCD.

We might work around this by doing what Matthew has suggested (ie. polling
all PCI and PCIe devices to check if they have PME pending) or perhaps
we can do something about this in ACPICA.

Still, the right fix is to put Notify () for the ACPI objects
corresponding to xHCD into the above method.

Thanks,
Rafael
