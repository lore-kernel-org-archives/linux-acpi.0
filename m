From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts
 as-is
Date: Fri, 2 Nov 2018 10:53:00 +0100
Message-ID: <20181102095300.GB14602@zn.tnic>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
 <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keith Busch <keith.busch@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 29, 2018 at 04:06:51PM -0500, Bjorn Helgaas wrote:
> [+cc Rafael, Len, Tony, Borislav, Tyler, Christoph, linux-acpi, LKML]
> 
> On Fri, Oct 26, 2018 at 02:19:04PM -0600, Jon Derrick wrote:
> > Add a bit in pci_host_bridge to indicate to leave the System Error
> > Interrupts as configured by the pre-boot environment. Propagate this to
> > the AER driver which disables System Error Interrupts.

This commit message should not explain what the patch does - that's
obvious - but why it is doing it.


> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> >  drivers/pci/pcie/aer.c | 7 +++++--
> >  include/linux/pci.h    | 3 +++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 83180ed..6a4af63 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1360,6 +1360,7 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
> >  static void aer_enable_rootport(struct aer_rpc *rpc)
> >  {
> >  	struct pci_dev *pdev = rpc->rpd;
> > +	struct pci_host_bridge *host;
> >  	int aer_pos;
> >  	u16 reg16;
> >  	u32 reg32;
> > @@ -1369,8 +1370,10 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
> >  	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
> >  
> >  	/* Disable system error generation in response to error messages */
> > -	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
> > -				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
> > +	host = pci_find_host_bridge(pdev->bus);
> > +	if (!host->no_disable_sys_err)

Double negation

	if (! .. ->no..

could simply be

	if (host->disable_sys_err...

> > +		pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
> > +					   SYSTEM_ERROR_INTR_ON_MESG_MASK);
> 
> If I squint hard enough this sort of makes sense, but it also makes me
> confused about the normal APEI firmware-first model works.
> 
> In the NON-firmare-first case, firmware isn't involved in handling AER
> errors.  The Linux AER driver fields an interrupt from a Root Port,
> reads AER log registers, etc.
> 
> In the normal APEI firmware-first case, when the hardware reports an
> AER event, I think firmware gets control first, and *it* reads the AER
> log registers, packages them up, and generates an interrupt to the OS,
> which reads the packaged error state from the firmware via the HEST.
> 
> If I understand this special Intel VMD firmware-first case correctly,
> firmware gets control first, reads the AER log registers, and
> synthesizes what looks to the OS like a normal AER interrupt.  The

Why?

Why the faking?

If firmware needs to get control, why doesn't it then *retain* control
and report the error through HEST, like others do?

AFAIUC, fw wants to do something underneath. What's wrong with making it
a normal firmware-first case?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
