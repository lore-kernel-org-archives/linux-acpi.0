From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] x86/pci: intel ioh need to subtract mmconf range
Date: Thu, 14 Jan 2010 16:49:07 -0700
Message-ID: <201001141649.08554.bjorn.helgaas@hp.com>
References: <20100113053736.GA6720@jgarrett.org> <201001141609.19290.bjorn.helgaas@hp.com> <4B4FAAE0.7080608@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4B4FAAE0.7080608@kernel.org>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jeff Garrett <jeff@jgarrett.org>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, David Airlie <airlied@linux.ie>
List-Id: linux-acpi@vger.kernel.org

On Thursday 14 January 2010 04:38:08 pm Yinghai Lu wrote:
> On 01/14/2010 03:09 PM, Bjorn Helgaas wrote:
> > On Thursday 14 January 2010 03:46:35 pm Yinghai Lu wrote:
> >>
> >> Bjorn pointed out we need to remove mmconf range
> >>
> >> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >>
> >> ---
> >>  arch/x86/pci/intel_bus.c |   29 +++++++++++++++++++++++++++--
> >>  1 file changed, 27 insertions(+), 2 deletions(-)
> >>
> >> Index: linux-2.6/arch/x86/pci/intel_bus.c
> >> ===================================================================
> >> --- linux-2.6.orig/arch/x86/pci/intel_bus.c
> >> +++ linux-2.6/arch/x86/pci/intel_bus.c
> >> @@ -46,6 +46,20 @@ static inline void print_ioh_resources(s
> >>  
> >>  #define RANGE_NUM 16
> >>  
> >> +static void __devinit subtract_mmconf(struct range *range, int nr)
> >> +{
> >> +#ifdef CONFIG_PCI_MMCONFIG
> >> +	struct pci_mmcfg_region *cfg;
> >> +
> >> +	if (list_empty(&pci_mmcfg_list))
> >> +		return;
> >> +
> >> +        list_for_each_entry(cfg, &pci_mmcfg_list, list)
> >> +		subtract_range(range, nr, cfg->res.start,
> >> +			 cfg->res.end + 1);
> >> +#endif
> > 
> > This can't be right, can it?  Let's say the kernel was built with
> > CONFIG_PCI_MMCONFIG turned off, or the user used "pci=nommconf",
> > or the kernel decides not to use MMCONFIG for some other reason.
> > 
> > In that case, the hardware may still be configured to support
> > MMCONFIG, but the pci_mmcfg_list will be empty, so your code will
> > leave the window alone.  We might assign some of that MMCONFIG
> > space to a device, but the hardware will route it to MMCONFIG,
> > not to the device.
> 
> so if there is mmconf specified, we just skip the whole function?

No, I'm saying that intel-bus.c must ALWAYS remove the MMCONFIG region
from the host bridge apertures, even if Linux isn't using MMCONFIG.

That means intel-bus.c has to be smart enough to figure out on its
own what the MMCONFIG area is.  It can't depend on mmconfig-shared.c
to do it, because mmconfig-shared.c might not be there.

Bjorn
