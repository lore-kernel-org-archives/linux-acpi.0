From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v11 2/7] ACPI / OSL: Stub out
 acpi_os_(read/write)_pci_configurations()
Date: Mon, 17 Dec 2018 23:32:31 -0800
Message-ID: <20181218073231.GB8612@infradead.org>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-3-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218025606.32668-3-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 18, 2018 at 02:56:01AM +0000, Sinan Kaya wrote:
> Getting ready to allow CONFIG_PCI to be unset with ACPI enabled. Stub out
> acpi_os_read_pci_configuration and acpi_os_write_pci_configuration
> functions when CONFIG_PCI is not defined.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/osl.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index b48874b8e1ea..524fd5f33ea4 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -773,6 +773,7 @@ acpi_status
>  acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
>  			       u64 *value, u32 width)
>  {
> +#ifdef CONFIG_PCI
>  	int result, size;
>  	u32 value32;
>  
> @@ -799,12 +800,19 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
>  	*value = value32;
>  
>  	return (result ? AE_ERROR : AE_OK);
> +#else
> +	int rc;
> +
> +	rc = pr_warn_once("PCI configuration space access is not supported\n");
> +	return rc ? AE_SUPPORT : AE_OK;
> +#endif

Normally we provide a full separate stub version.  If we have enough
of them in a separate file.
