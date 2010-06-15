From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: "ignoring host bridge windows from ACPI" in a recent laptop
Date: Tue, 15 Jun 2010 15:45:13 +0200
Message-ID: <1276609513.31461.78.camel@thorin>
References: <1276600703.31461.53.camel@thorin>
	 <201006150727.10978.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201006150727.10978.bjorn.helgaas@hp.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi!

On Die, 2010-06-15 at 07:27 -0600, Bjorn Helgaas wrote:
> On Tuesday, June 15, 2010 05:18:23 am Bernd Petrovitsch wrote:
[...]
> > I have a Sony Vaio VPCF11M1E since early this year. Looking through the
> > output of `dmesg`, I noticed
> > ----  snip  ----
> > pci_root PNP0A08:00: ignoring host bridge windows from ACPI; boot with "pci=use_crs" to use them
> > ----  snip  ----
> > So I tried that.
> > The laptop boots and works without problems so far. I attached a diff of
> > the first approx. 630 lines of the `dmesg` outputs without and with the
> > above parameter. It gets pretty messy afterwards because (at least) the
> > USB and/or SATA initialization runs apparently in parallel.
> > 
> > After finding http://lkml.org/lkml/2010/2/12/174, it seems that we might
> > need another quirk to activate that automatically.
> > 
> > At the end, I lost also dozens of
> > ----  snip  ----
> > name_count maxed, losing inode data: dev=00:07, inode=
> > ----  snip  ----
> > lines (which are also not in the attached diff). I don't know if that
> > has something to do with the above.
> 
> Until the patch you mentioned above, Linux silently ignored window
> information from ACPI.  On your machine, the only effect of the
> patch was to print the new line you mentioned, which was only intended
> as a hint that "if PCI devices don't work correctly, here's something
> we can try."
> 
> If your devices *are* working correctly, you can just ignore the hint.

OK.
The not really correctly working device (so far) is the graphics card
---- snip  ----
01:00.0 VGA compatible controller: nVidia Corporation GT216 [GeForce GT 330M] (rev a2)
---- snip  ---- 
as I get only some standard VESA resolution (800x600 or so - but there
is a full-hd-screen on it) with X.
I'm in the process of playing around with that ("nv vs nouveau driver"
or "is it a system-config-display issue") and writing something in the
Fedora-12 bugzilla eventually - if only to see where the real problem
lies.

> You mention the "name_count maxed" messages, and I think you meant
> they go away when you use "pci=use_crs".  I don't see how that would

ACK.

> be connected, since that's from syscall auditing code that is several
> layers removed from PCI device resource management.

I (also) thought similar - I also just googled for the line (and didn't
find anything useful, probably not enough googled) and just wondered why
it was gone.
So I take is as "not related".

Thanks for the quick answer BTW,
	Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services
