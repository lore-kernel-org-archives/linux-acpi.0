From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] x86/pci: do assign root bus res if _CRS is used
Date: Mon, 27 Apr 2009 14:39:36 -0600
Message-ID: <200904271439.37396.bjorn.helgaas@hp.com>
References: <49ED22EC.2040204@kernel.org> <200904271344.04099.bjorn.helgaas@hp.com> <49F61265.10201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <49F61265.10201@kernel.org>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, Gary Hade <garyhade@us.ibm.com>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-acpi@vger.kernel.org

On Monday 27 April 2009 02:15:33 pm Yinghai Lu wrote:
> Bjorn Helgaas wrote:
> > On Monday 20 April 2009 07:35:40 pm Yinghai Lu wrote:
> >> it wil be overwriten later if _CRS is used, so don't bother to set it.
> >>
> >> [ Impact: cleanup ]
> >>
> >> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >>
> >> ---
> >>  arch/x86/pci/amd_bus.c |    4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> Index: linux-2.6/arch/x86/pci/amd_bus.c
> >> ===================================================================
> >> --- linux-2.6.orig/arch/x86/pci/amd_bus.c
> >> +++ linux-2.6/arch/x86/pci/amd_bus.c
> >> @@ -100,6 +100,10 @@ void x86_pci_root_bus_res_quirks(struct
> >>  	int j;
> >>  	struct pci_root_info *info;
> >>  
> >> +	/* don't go for it if _CRS is used */
> >> +	if (pci_probe & PCI_USE__CRS)
> >> +		return;
> >> +
> >>  	/* if only one root bus, don't need to anything */
> >>  	if (pci_root_num < 2)
> >>  		return;
> > 
> > This isn't a comment on this patch per se.
> > 
> > I am concerned about the fact that "pci=use_crs" is not the default.
> > From the changelog of 62f420f8282, it sounds like you have to boot an
> > IBM x3850 with "pci=use_crs" to make hot-plug work, even though ACPI
> > tells us everything we need to know.  That's backwards.
> > 
> > We shouldn't need an option to tell Linux that the firmware is
> > trustworthy.  We should have an option to *ignore* it for the times
> > when we trip over something broken and haven't figured out a way to
> > work around it yet.
> 
> other system may have broken _CRS.

Do you have examples of problems here, or are you just worried that
there *may* be problems?

> maybe we could try to use DMI whitelist them?

I don't like a whitelist because it requires ongoing maintenance
for correctly-working machines.  A blacklist is nicer because it
only requires maintenance for *broken* machines.  A date-based
solution would be better from that point of view.

Bjorn
