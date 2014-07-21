From: "Tenoutit, Faouaz" <faouaz.tenoutit@intel.com>
Subject: RE: [PATCH 1/2 V2] USB: Use ACPI device information
Date: Mon, 21 Jul 2014 07:50:11 +0000
Message-ID: <56D4B9BFEADA5948B14547D2A81CE2C02846949C@HASMSX106.ger.corp.intel.com>
References: <56D4B9BFEADA5948B14547D2A81CE2C0284660F3@HASMSX106.ger.corp.intel.com>,<3737629.aqjFWyBK28@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47641 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbaGUHvC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2014 03:51:02 -0400
In-Reply-To: <3737629.aqjFWyBK28@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Ortiz, Samuel" <samuel.ortiz@intel.com>

________________________________________
From: Rafael J. Wysocki [rjw@rjwysocki.net]
Sent: Sunday, July 20, 2014 1:31 AM
To: Tenoutit, Faouaz
Cc: linux-acpi@vger.kernel.org; Ortiz, Samuel
Subject: Re: [PATCH 1/2 V2] USB: Use ACPI device information

On Wednesday, July 09, 2014 04:42:38 PM Tenoutit, Faouaz wrote:
> From: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
>
> Use ACPI device pld information instead of calling
> acpi_get_physical_device_location.
>
> Signed-off-by: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>

> This patch doesn't apply for me on top of 3.16-rc5.  Can you please rebase it?

Sorry, I generated it from latest kernel source tree (It applies on top of 3.16-rc6)

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
>
>
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

