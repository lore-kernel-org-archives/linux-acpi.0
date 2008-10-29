From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 6/8] PCI: added pci_msi_enabled which checks for pci=nomsi
Date: Wed, 29 Oct 2008 08:33:15 -0600
Message-ID: <200810290833.15669.bjorn.helgaas@hp.com>
References: <20081029054815.2263.40833.stgit@bob.kio> <20081029054846.2263.59248.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081029054846.2263.59248.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx
List-Id: linux-acpi@vger.kernel.org

On Tuesday 28 October 2008 11:48:46 pm Andrew Patterson wrote:
> PCI: added pci_msi_enabled which checks for pci=nomsi
> 
> The pci_msi_enabled() function is used to check whether pci=nomsi
> is set on the kernel command-line.
> 
> Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
> ---
> 
>  drivers/pci/msi.c   |   12 ++++++++++++
>  include/linux/pci.h |    5 +++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d281201..0e8dae1 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -755,6 +755,18 @@ void pci_no_msi(void)
>  	pci_msi_enable = 0;
>  }
>  
> +/**
> + * pci_msi_enabled - is MSI enabled?
> + *
> + * Returns true if MSI has not been disabled by the command-line option
> + * pci=nomsi.
> + **/
> +int pci_msi_enabled(void)
> +{
> +	return pci_msi_enable;
> +}
> +EXPORT_SYMBOL(pci_msi_enabled);
> +
>  void pci_msi_init_pci_dev(struct pci_dev *dev)
>  {
>  	INIT_LIST_HEAD(&dev->msi_list);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 752def8..8d0513e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -767,6 +767,10 @@ static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev)
>  
>  static inline void pci_restore_msi_state(struct pci_dev *dev)
>  { }
> +static inline int pci_msi_enabled(void)
> +{
> +	return 0;
> +}
>  #else
>  extern int pci_enable_msi(struct pci_dev *dev);
>  extern void pci_msi_shutdown(struct pci_dev *dev);
> @@ -777,6 +781,7 @@ extern void pci_msix_shutdown(struct pci_dev *dev);
>  extern void pci_disable_msix(struct pci_dev *dev);
>  extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
>  extern void pci_restore_msi_state(struct pci_dev *dev);
> +extern int pci_msi_enabled(void);
>  #endif
>  
>  #ifdef CONFIG_HT_IRQ

I don't think it's worth splitting out this patch.  You might
as well just add pci_msi_enabled() in the same patch where you
add a use of it.

Bjorn
