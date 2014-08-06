From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2 V2] USB: Use ACPI device information
Date: Wed, 06 Aug 2014 22:30:53 +0200
Message-ID: <3651033.4ACFakzb6s@vostro.rjw.lan>
References: <56D4B9BFEADA5948B14547D2A81CE2C0284660F3@HASMSX106.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57094 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753145AbaHFUMN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Aug 2014 16:12:13 -0400
In-Reply-To: <56D4B9BFEADA5948B14547D2A81CE2C0284660F3@HASMSX106.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tenoutit, Faouaz" <faouaz.tenoutit@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Samuel Ortiz <samuel.ortiz@intel.com>

On Wednesday, July 09, 2014 04:42:38 PM Tenoutit, Faouaz wrote:
> From: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> 
> Use ACPI device pld information instead of calling
> acpi_get_physical_device_location.
> 
> Signed-off-by: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>

Can you please fix the whitespace in this patch?

Rafael


> ---
>  drivers/acpi/scan.c         | 13 +++++++++++++
>  drivers/usb/core/usb-acpi.c | 14 +++++---------
>  include/acpi/acpi_bus.h     |  1 +
>  3 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f775fa0..7ad6beb 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -764,6 +764,13 @@ static int acpi_device_setup_files(struct acpi_device *dev)
>                              &dev_attr_real_power_state);
>      }
> 
> +    /*
> +     * If device has _PLD, initialize the 'pld' struct
> +     */
> +    if (acpi_has_method(dev->handle, "_PLD"))
> +        acpi_get_physical_device_location(dev->handle,
> +                    &dev->pld);
> +
>  end:
>      return result;
>  }
> @@ -803,6 +810,12 @@ static void acpi_device_remove_files(struct acpi_device *dev)
>          device_remove_file(&dev->dev, &dev_attr_status);
>      if (dev->handle)
>          device_remove_file(&dev->dev, &dev_attr_path);
> +
> +    /*
> +     * If device has _PLD, free 'pld' struct
> +     */
> +    if (dev->pld)
> +        ACPI_FREE(dev->pld);
>  }
>  /* --------------------------------------------------------------------------
>              ACPI Bus operations
> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> index 2776cfe..a8cbb72 100644
> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -157,9 +157,6 @@ static struct acpi_device *usb_acpi_find_companion(struct device *dev)
>      } else if (is_usb_port(dev)) {
>          struct usb_port *port_dev = to_usb_port(dev);
>          int port1 = port_dev->portnum;
> -        struct acpi_pld_info *pld;
> -        acpi_handle *handle;
> -        acpi_status status;
> 
>          /* Get the struct usb_device point of port's hub */
>          udev = to_usb_device(dev->parent->parent);
> @@ -190,15 +187,14 @@ static struct acpi_device *usb_acpi_find_companion(struct device *dev)
>              if (!adev)
>                  return NULL;
>          }
> -        handle = adev->handle;
> -        status = acpi_get_physical_device_location(handle, &pld);
> -        if (ACPI_FAILURE(status) || !pld)
> +        if (!adev->pld)
>              return adev;
> 
>          port_dev->location = USB_ACPI_LOCATION_VALID
> -            | pld->group_token << 8 | pld->group_position;
> -        port_dev->connect_type = usb_acpi_get_connect_type(handle, pld);
> -        ACPI_FREE(pld);
> +            | adev->pld->group_token << 8
> +            | adev->pld->group_position;
> +        port_dev->connect_type = usb_acpi_get_connect_type(adev->handle,
> +                adev->pld);
> 
>          return adev;
>      }
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index b571458..1b05d07 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -350,6 +350,7 @@ struct acpi_device {
>      struct acpi_scan_handler *handler;
>      struct acpi_hotplug_context *hp;
>      struct acpi_driver *driver;
> +    struct acpi_pld_info *pld;
>      void *driver_data;
>      struct device dev;
>      unsigned int physical_node_count;
> --
> 2.0.0

