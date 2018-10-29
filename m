From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts
 as-is
Date: Mon, 29 Oct 2018 16:06:51 -0500
Message-ID: <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keith Busch <keith.busch@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Tyler Baicar <tbaicar@codeaurora.org>, Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

[+cc Rafael, Len, Tony, Borislav, Tyler, Christoph, linux-acpi, LKML]

On Fri, Oct 26, 2018 at 02:19:04PM -0600, Jon Derrick wrote:
> Add a bit in pci_host_bridge to indicate to leave the System Error
> Interrupts as configured by the pre-boot environment. Propagate this to
> the AER driver which disables System Error Interrupts.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 7 +++++--
>  include/linux/pci.h    | 3 +++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 83180ed..6a4af63 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1360,6 +1360,7 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
>  static void aer_enable_rootport(struct aer_rpc *rpc)
>  {
>  	struct pci_dev *pdev = rpc->rpd;
> +	struct pci_host_bridge *host;
>  	int aer_pos;
>  	u16 reg16;
>  	u32 reg32;
> @@ -1369,8 +1370,10 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
>  
>  	/* Disable system error generation in response to error messages */
> -	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
> -				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
> +	host = pci_find_host_bridge(pdev->bus);
> +	if (!host->no_disable_sys_err)
> +		pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
> +					   SYSTEM_ERROR_INTR_ON_MESG_MASK);

If I squint hard enough this sort of makes sense, but it also makes me
confused about the normal APEI firmware-first model works.

In the NON-firmare-first case, firmware isn't involved in handling AER
errors.  The Linux AER driver fields an interrupt from a Root Port,
reads AER log registers, etc.

In the normal APEI firmware-first case, when the hardware reports an
AER event, I think firmware gets control first, and *it* reads the AER
log registers, packages them up, and generates an interrupt to the OS,
which reads the packaged error state from the firmware via the HEST.

If I understand this special Intel VMD firmware-first case correctly,
firmware gets control first, reads the AER log registers, and
synthesizes what looks to the OS like a normal AER interrupt.  The
Linux AER driver gets what it thinks is an interrupt from a Root Port,
and it reads AER log registers from the hardware just like it does in
the NON-firmware-first case.

My confusion is about how we manage the mechanism by which the
firmware gets control first.  In the Intel VMD case, it looks like
firmware fields the System Errors controlled by the Root Control
register of Root Ports.  This patch adds some framework so we know not
to touch something set up by firmware.

But in the normal APEI firmware-first case, we disable those System
Errors in the Root Control registers, so firmware must get control
some other way.

How does the OS know what mechanism the firmware uses, so it can make
sure to preserve it?  This patch might be part of the solution, but it
seems pretty ad hoc, and of course it does nothing for the APEI
firmware-first case.  How does firmware get control in that case?

>  	aer_pos = pdev->aer_cap;
>  	/* Clear error status */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6925828..6fcfab4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -484,6 +484,9 @@ struct pci_host_bridge {
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
> +	unsigned int	no_disable_sys_err:1;	/* Don't disable system
> +						   error interrupts */
> +
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> -- 
> 1.8.3.1
> 
