From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: "ignoring host bridge windows from ACPI" in a recent laptop
Date: Tue, 15 Jun 2010 07:27:10 -0600
Message-ID: <201006150727.10978.bjorn.helgaas@hp.com>
References: <1276600703.31461.53.camel@thorin>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1276600703.31461.53.camel@thorin>
Sender: linux-pci-owner@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, June 15, 2010 05:18:23 am Bernd Petrovitsch wrote:
> Hi!
> 
> I have a Sony Vaio VPCF11M1E since early this year. Looking through the
> output of `dmesg`, I noticed
> ----  snip  ----
> pci_root PNP0A08:00: ignoring host bridge windows from ACPI; boot with "pci=use_crs" to use them
> ----  snip  ----
> So I tried that.
> The laptop boots and works without problems so far. I attached a diff of
> the first approx. 630 lines of the `dmesg` outputs without and with the
> above parameter. It gets pretty messy afterwards because (at least) the
> USB and/or SATA initialization runs apparently in parallel.
> 
> After finding http://lkml.org/lkml/2010/2/12/174, it seems that we might
> need another quirk to activate that automatically.
> 
> At the end, I lost also dozens of
> ----  snip  ----
> name_count maxed, losing inode data: dev=00:07, inode=
> ----  snip  ----
> lines (which are also not in the attached diff). I don't know if that
> has something to do with the above.

Until the patch you mentioned above, Linux silently ignored window
information from ACPI.  On your machine, the only effect of the
patch was to print the new line you mentioned, which was only intended
as a hint that "if PCI devices don't work correctly, here's something
we can try."

If your devices *are* working correctly, you can just ignore the hint.

You mention the "name_count maxed" messages, and I think you meant
they go away when you use "pci=use_crs".  I don't see how that would
be connected, since that's from syscall auditing code that is several
layers removed from PCI device resource management.

Bjorn
