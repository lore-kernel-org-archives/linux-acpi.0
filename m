From: "Schmauss, Erik" <erik.schmauss@intel.com>
Subject: RE: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 19:02:38 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com>
References: <20181212171941.7437-1-okaya@kernel.org>
 <20181212171941.7437-6-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212171941.7437-6-okaya@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Sinan Kaya [mailto:okaya@kernel.org]
> Sent: Wednesday, December 12, 2018 9:20 AM
> To: linux-acpi@vger.kernel.org
> Cc: Sinan Kaya <okaya@kernel.org>; Moore, Robert
> <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>;
> Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
> <lenb@kernel.org>; open list:ACPI COMPONENT ARCHITECTURE (ACPICA)
> <devel@acpica.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
> CONFIG_PCI is unset
> 
> Now that we allow CONFIG_PCI to be unset, remove useless code from
> ACPICA too.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/acpica/Makefile  | 2 +-
>  drivers/acpi/acpica/achware.h | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile index
> b14621da5413..59700433a96e 100644
> --- a/drivers/acpi/acpica/Makefile
> +++ b/drivers/acpi/acpica/Makefile
> @@ -77,13 +77,13 @@ acpi-y +=		\
>  	hwacpi.o	\
>  	hwesleep.o	\
>  	hwgpe.o		\
> -	hwpci.o		\
>  	hwregs.o	\
>  	hwsleep.o	\
>  	hwvalid.o	\
>  	hwxface.o	\
>  	hwxfsleep.o
> 
> +acpi-$(CONFIG_PCI) += hwpci.o
>  acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
> 
>  acpi-y +=		\
> diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
> index 43ce67a9da1f..1c827184fe64 100644
> --- a/drivers/acpi/acpica/achware.h
> +++ b/drivers/acpi/acpica/achware.h
> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
> acpi_gpe_xrupt_info *gpe_xrupt_info,

CONFIG_PCI is a Linux-ism. We should stay with the OS-independent nature of
ACPICA. Please use ACPI_PCI_CONFIGURED and put it above the comment like so:

#ifdef ACPI_PCI_CONFIGURED
>  /*
>   * hwpci - PCI configuration support
>   */
> +#ifdef CONFIG_PCI
>  acpi_status
>  acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
>  		      acpi_handle root_pci_device, acpi_handle pci_region);
> +#else
> +static inline acpi_status
> +acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id, acpi_handle
> root_pci_device,
> +		      acpi_handle pci_region)
> +{
> +	return AE_SUPPORT;
> +}
> +#endif
> 
>  #endif				/* __ACHWARE_H__ */
> --
> 2.19.0
