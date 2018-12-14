From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v9 6/6] PCI: Stub out pci_request_acs() when CONFIG_PCI
 is not set
Date: Fri, 14 Dec 2018 16:26:01 -0600
Message-ID: <20181214222601.GH20725@google.com>
References: <20181214163319.27479-1-okaya@kernel.org>
 <20181214163319.27479-7-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214163319.27479-7-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-acpi@vger.kernel.org, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robin Murphy <robin.murphy@arm.com>, Logan Gunthorpe <logang@deltatee.com>
List-Id: linux-acpi@vger.kernel.org

[+cc Lorenzo, Robin, Logan]

On Fri, Dec 14, 2018 at 04:33:19PM +0000, Sinan Kaya wrote:
> ACPI IORT table code relies on pci_request_acs() to be present. Define
> a stub function when CONFI_PCI is not set.

This doesn't seem like the simplest approach to me, but I probably
don't understand what's going on in IORT.

It looks like *all* of iort_enable_acs() (the caller of
pci_request_acs()) is PCI-specific; at least, the whole thing is
wrapped in a test for ACPI_IORT_NODE_PCI_ROOT_COMPLEX.  So the whole
function could be wrapped in #ifdef CONFIG_PCI.

Here's the caller of iort_enable_acs():

  iort_init_platform_devices
    acs_enabled = false
    for (i = 0; i < iort->node_count; i++) {
      if (!acs_enabled)
        acs_enabled = iort_enable_acs(iort_node);

It seems like the acs_enabled state could be encapsulated inside
iort_enable_acs().

Today pci_request_acs() is a system-wide thing, but I don't know why
that's the case.  Isn't it conceivable that different PCI hierarchies
could have different ACS policies, e.g., because of P2P DMA or
something?

Bottom line, pci_request_acs() is being called from what looks like
PCI-specific code in IORT, and it would make more sense to me to prune
out that code in IORT than to make a stub pci_request_acs().

> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 51a5a5217667..f0f2f55ea93c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2101,7 +2101,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_PCI
>  void pci_request_acs(void);
> +#else
> +static inline void pci_request_acs(void) {}
> +#endif
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> -- 
> 2.19.0
> 
