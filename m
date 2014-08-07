From: Yidi Lin <yidi.lin@canonical.com>
Subject: Re: [PATCH] PNPACPI: do ACPI binding directly
Date: Thu, 7 Aug 2014 16:29:50 +0800
Message-ID: <CAFquV7Vb63n-EtXOLve00Hu3uyMuhHV+hmycdPJ7M5kaWC=4ew@mail.gmail.com>
References: <1404305689.8366.90.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:60364 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196AbaHGI3v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2014 04:29:51 -0400
Received: by mail-yh0-f54.google.com with SMTP id v1so2700251yhn.27
        for <linux-acpi@vger.kernel.org>; Thu, 07 Aug 2014 01:29:50 -0700 (PDT)
In-Reply-To: <1404305689.8366.90.camel@rzhang1-toshiba>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Prigent, Christophe" <christophe.prigent@intel.com>, YK <yk@canonical.com>

Hi,

I meet same bug in 3.13.x. And 3.16 fixes the bug.
After bisecting, the bug is fixed by this commit.

commit b6328a07bd6b3d31b64f85864fe74f3b08c010ca
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Wed Jul 30 00:23:09 2014 +0200

    ACPI / PNP: Fix acpi_pnp_match()

    The acpi_pnp_match() function is used for finding the ACPI device
    object that should be associated with the given PNP device.
    Unfortunately, the check used by that function is not strict enough
    and may cause success to be returned for a wrong ACPI device object.

    To fix that, use the observation that the pointer to the ACPI
    device object in question is already stored in the data field
    in struct pnp_dev, so acpi_pnp_match() can simply use that
    field to do its job.

    This problem was uncovered in 3.14 by commit 202317a573b2 (ACPI / scan:
    Add acpi_device objects for all device nodes in the namespace).

    Fixes: 202317a573b2 (ACPI / scan: Add acpi_device objects for all
device nodes in the namespace)
    Reported-and-tested-by: Vinson Lee <vlee@twopensource.com>
    Cc: 3.14+ <stable@vger.kernel.org> # 3.14+
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Is it suggested to apply the patch as mentioned above to 3.13.x?
Thanks.


On Wed, Jul 2, 2014 at 8:54 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> From 7daac7fc7cd7b605ccd84f10fc206cedf6170e89 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Fri, 20 Jun 2014 10:14:07 +0800
> Subject: [PATCH] PNPACPI: do ACPI binding directly
>
> PNPACPI uses acpi_bus_type to do ACPI binding for the PNPACPI devices.
>
> This is overkill because PNPACPI code already knows which ACPI
> device object to bind during PNPACPI device enumeration.
>
> This patch removes acpi_pnp_bus and does the binding by invoking
> acpi_bind_one() directly after device enumerated.
>
> This also fixes a bug in the previous code that some PNPACPI devices failed
> to be bound because
> 1. the ACPI device _HID is not pnpid, e.g. "MSFT0001", but its _CID is,
>    e.g. "PNP0303", thus ACPI _CID is used as the pnp device device id.
> 2. device is bound only if the pnp device id matches the ACPI device _HID.
>
> Tested-by: Prigent Christophe <christophe.prigent@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/internal.h    |  2 --
>  drivers/pnp/pnpacpi/core.c | 41 +++--------------------------------------
>  include/acpi/acpi_bus.h    |  2 ++
>  3 files changed, 5 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 7de5b60..151f3e7 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -84,8 +84,6 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
>                              int type, unsigned long long sta);
>  void acpi_device_add_finalize(struct acpi_device *device);
>  void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> -int acpi_bind_one(struct device *dev, struct acpi_device *adev);
> -int acpi_unbind_one(struct device *dev);
>  bool acpi_device_is_present(struct acpi_device *adev);
>  bool acpi_device_is_battery(struct acpi_device *adev);
>
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index b81448b..3bebeda 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -295,9 +295,11 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
>                 return error;
>         }
>
> +       error = acpi_bind_one(&dev->dev, device);
> +
>         num++;
>
> -       return 0;
> +       return error;
>  }
>
>  static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,
> @@ -313,41 +315,6 @@ static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,
>         return AE_OK;
>  }
>
> -static int __init acpi_pnp_match(struct device *dev, void *_pnp)
> -{
> -       struct acpi_device *acpi = to_acpi_device(dev);
> -       struct pnp_dev *pnp = _pnp;
> -
> -       /* true means it matched */
> -       return !acpi->physical_node_count
> -           && compare_pnp_id(pnp->id, acpi_device_hid(acpi));
> -}
> -
> -static struct acpi_device * __init acpi_pnp_find_companion(struct device *dev)
> -{
> -       dev = bus_find_device(&acpi_bus_type, NULL, to_pnp_dev(dev),
> -                             acpi_pnp_match);
> -       if (!dev)
> -               return NULL;
> -
> -       put_device(dev);
> -       return to_acpi_device(dev);
> -}
> -
> -/* complete initialization of a PNPACPI device includes having
> - * pnpdev->dev.archdata.acpi_handle point to its ACPI sibling.
> - */
> -static bool acpi_pnp_bus_match(struct device *dev)
> -{
> -       return dev->bus == &pnp_bus_type;
> -}
> -
> -static struct acpi_bus_type __initdata acpi_pnp_bus = {
> -       .name        = "PNP",
> -       .match       = acpi_pnp_bus_match,
> -       .find_companion = acpi_pnp_find_companion,
> -};
> -
>  int pnpacpi_disabled __initdata;
>  static int __init pnpacpi_init(void)
>  {
> @@ -357,10 +324,8 @@ static int __init pnpacpi_init(void)
>         }
>         printk(KERN_INFO "pnp: PnP ACPI init\n");
>         pnp_register_protocol(&pnpacpi_protocol);
> -       register_acpi_bus_type(&acpi_pnp_bus);
>         acpi_get_devices(NULL, pnpacpi_add_device_handler, NULL, NULL);
>         printk(KERN_INFO "pnp: PnP ACPI: found %d devices\n", num);
> -       unregister_acpi_bus_type(&acpi_pnp_bus);
>         pnp_platform_devices = 1;
>         return 0;
>  }
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index b571458..4bcbb94 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -487,6 +487,8 @@ struct acpi_bus_type {
>  };
>  int register_acpi_bus_type(struct acpi_bus_type *);
>  int unregister_acpi_bus_type(struct acpi_bus_type *);
> +int acpi_bind_one(struct device *dev, struct acpi_device *adev);
> +int acpi_unbind_one(struct device *dev);
>
>  struct acpi_pci_root {
>         struct acpi_device * device;
> --
> 1.8.3.2
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
