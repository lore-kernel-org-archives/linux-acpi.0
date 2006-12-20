From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 18/19] ACPI: make code static
Date: Wed, 20 Dec 2006 17:02:45 -0500
Message-ID: <200612201702.46156.lenb@kernel.org>
References: <200612192056.kBJKuOEJ010065@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51175 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030369AbWLTWJo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 17:09:44 -0500
In-Reply-To: <200612192056.kBJKuOEJ010065@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bunk@stusta.de

Applied.

thanks,
-Len

On Tuesday 19 December 2006 15:56, akpm@osdl.org wrote:
> From: Adrian Bunk <bunk@stusta.de>
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/bus.c          |    2 +-
>  drivers/acpi/dock.c         |    4 ++--
>  drivers/acpi/pci_bind.c     |    4 ++--
>  include/acpi/acpi_bus.h     |    2 --
>  include/acpi/acpi_drivers.h |    2 --
>  5 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff -puN drivers/acpi/bus.c~acpi-make-code-static drivers/acpi/bus.c
> --- a/drivers/acpi/bus.c~acpi-make-code-static
> +++ a/drivers/acpi/bus.c
> @@ -728,7 +728,7 @@ static int __init acpi_bus_init(void)
>  	return -ENODEV;
>  }
>  
> -decl_subsys(acpi, NULL, NULL);
> +static decl_subsys(acpi, NULL, NULL);
>  
>  static int __init acpi_init(void)
>  {
> diff -puN drivers/acpi/dock.c~acpi-make-code-static drivers/acpi/dock.c
> --- a/drivers/acpi/dock.c~acpi-make-code-static
> +++ a/drivers/acpi/dock.c
> @@ -641,7 +641,7 @@ static ssize_t show_docked(struct device
>  	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
>  
>  }
> -DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
> +static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
>  
>  /*
>   * write_undock - write method for "undock" file in sysfs
> @@ -657,7 +657,7 @@ static ssize_t write_undock(struct devic
>  	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
>  	return ret ? ret: count;
>  }
> -DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
> +static DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
>  
>  /**
>   * dock_add - add a new dock station
> diff -puN drivers/acpi/pci_bind.c~acpi-make-code-static drivers/acpi/pci_bind.c
> --- a/drivers/acpi/pci_bind.c~acpi-make-code-static
> +++ a/drivers/acpi/pci_bind.c
> @@ -106,7 +106,7 @@ acpi_status acpi_get_pci_id(acpi_handle 
>  
>  EXPORT_SYMBOL(acpi_get_pci_id);
>  
> -int acpi_pci_bind(struct acpi_device *device)
> +static int acpi_pci_bind(struct acpi_device *device)
>  {
>  	int result = 0;
>  	acpi_status status = AE_OK;
> @@ -267,7 +267,7 @@ int acpi_pci_bind(struct acpi_device *de
>  	return result;
>  }
>  
> -int acpi_pci_unbind(struct acpi_device *device)
> +static int acpi_pci_unbind(struct acpi_device *device)
>  {
>  	int result = 0;
>  	acpi_status status = AE_OK;
> diff -puN include/acpi/acpi_bus.h~acpi-make-code-static include/acpi/acpi_bus.h
> --- a/include/acpi/acpi_bus.h~acpi-make-code-static
> +++ a/include/acpi/acpi_bus.h
> @@ -315,8 +315,6 @@ struct acpi_bus_event {
>  	u32 data;
>  };
>  
> -extern struct subsystem acpi_subsys;
> -
>  /*
>   * External Functions
>   */
> diff -puN include/acpi/acpi_drivers.h~acpi-make-code-static include/acpi/acpi_drivers.h
> --- a/include/acpi/acpi_drivers.h~acpi-make-code-static
> +++ a/include/acpi/acpi_drivers.h
> @@ -66,8 +66,6 @@ void acpi_pci_irq_del_prt(int segment, i
>  struct pci_bus;
>  
>  acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id);
> -int acpi_pci_bind(struct acpi_device *device);
> -int acpi_pci_unbind(struct acpi_device *device);
>  int acpi_pci_bind_root(struct acpi_device *device, struct acpi_pci_id *id,
>  		       struct pci_bus *bus);
>  
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
