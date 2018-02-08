From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/5] ACPI / bus: Do not traverse through non-existed
 device table
Date: Thu, 8 Feb 2018 18:06:56 +0100
Message-ID: <CAJZ5v0homQUVTpAx-TF6W6T-H62OWcMDTzOwDfgXaVYGLG_Y6A@mail.gmail.com>
References: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
 <20180207145610.88434-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iEB74dPUN400pfB4+AV--NZj7hs6aZGiSoSiz5cTS37g@mail.gmail.com> <1518108802.22495.207.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34952 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeBHRG5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Feb 2018 12:06:57 -0500
In-Reply-To: <1518108802.22495.207.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, Feb 8, 2018 at 5:53 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, 2018-02-08 at 16:59 +0100, Rafael J. Wysocki wrote:
>> On Wed, Feb 7, 2018 at 3:56 PM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> >
>
>> And as far as I'm concerned you can do:
>>
>> if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)
>>         return (const struct acpi_device_id
>> *)acpi_of_match_device(device, of_ids);
>>
>> and update the comment accordingly.
>
> Would the following work for you?

Yes, it would.

> --- 8< --- 8< --- 8< ---
> From 03013c0c1e487cda4c0d8dc5065ed2f0031095de Mon Sep 17 00:00:00 2001
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Thu, 1 Feb 2018 21:52:14 +0200
> Subject: [PATCH 1/1] ACPI / bus: Do not traverse through non-existed
> device
>  table
>
> When __acpi_match_device() is called it would be possible to have
> ACPI ID table a MULL pointer. To avoid potential dereference,
> check for this before traverse.
>
> This patch implies a bit of refactoring acpi_of_match_device() to return
> pointer to OF ID when matched followed by refactoring
> __acpi_match_device() to return either ACPI or OF ID when matches.
>
> While here, remove redundant 'else'.
>
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/bus.c | 66 +++++++++++++++++++++++++++++++++------------
> ---------
>  1 file changed, 41 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 676c9788e1c8..33c5166e6028 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -660,13 +660,15 @@ struct acpi_device *acpi_companion_match(const
> struct device *dev)
>   * acpi_of_match_device - Match device object using the "compatible"
> property.
>   * @adev: ACPI device object to match.
>   * @of_match_table: List of device IDs to match against.
> + * @of_id: OF ID if matched
>   *
>   * If @dev has an ACPI companion which has ACPI_DT_NAMESPACE_HID in its
> list of
>   * identifiers and a _DSD object with the "compatible" property, use
> that
>   * property to match against the given list of identifiers.
>   */
>  static bool acpi_of_match_device(struct acpi_device *adev,
> -                                const struct of_device_id
> *of_match_table)
> +                                const struct of_device_id
> *of_match_table,
> +                                const struct of_device_id **of_id)
>  {
>         const union acpi_object *of_compatible, *obj;
>         int i, nval;
> @@ -690,8 +692,11 @@ static bool acpi_of_match_device(struct acpi_device
> *adev,
>                 const struct of_device_id *id;
>
>                 for (id = of_match_table; id->compatible[0]; id++)
> -                       if (!strcasecmp(obj->string.pointer, id-
>>compatible))
> +                       if (!strcasecmp(obj->string.pointer, id-
>>compatible)) {
> +                               if (of_id)
> +                                       *of_id = id;
>                                 return true;
> +                       }
>         }
>
>         return false;
> @@ -762,10 +767,11 @@ static bool __acpi_match_device_cls(const struct
> acpi_device_id *id,
>         return true;
>  }
>
> -static const struct acpi_device_id *__acpi_match_device(
> -       struct acpi_device *device,
> -       const struct acpi_device_id *ids,
> -       const struct of_device_id *of_ids)
> +static bool __acpi_match_device(struct acpi_device *device,
> +                               const struct acpi_device_id *acpi_ids,
> +                               const struct of_device_id *of_ids,
> +                               const struct acpi_device_id **acpi_id,
> +                               const struct of_device_id **of_id)
>  {
>         const struct acpi_device_id *id;
>         struct acpi_hardware_id *hwid;
> @@ -775,30 +781,35 @@ static const struct acpi_device_id
> *__acpi_match_device(
>          * driver for it.
>          */
>         if (!device || !device->status.present)
> -               return NULL;
> +               return false;
>
>         list_for_each_entry(hwid, &device->pnp.ids, list) {
>                 /* First, check the ACPI/PNP IDs provided by the
> caller. */
> -               for (id = ids; id->id[0] || id->cls; id++) {
> -                       if (id->id[0] && !strcmp((char *) id->id, hwid-
>>id))
> -                               return id;
> -                       else if (id->cls && __acpi_match_device_cls(id,
> hwid))
> -                               return id;
> +               if (acpi_ids) {
> +                       bool found;
> +
> +                       for (id = acpi_ids; id->id[0] || id->cls; id++)
> {
> +                               found = false;
> +                               if (id->id[0] && !strcmp((char *)id-
>>id, hwid->id))
> +                                       found = true;
> +                               if (id->cls &&
> __acpi_match_device_cls(id, hwid))
> +                                       found = true;
> +                               if (found) {
> +                                       if (acpi_id)
> +                                               *acpi_id = id;
> +                                       return true;
> +                               }
> +                       }
>                 }
>
>                 /*
>                  * Next, check ACPI_DT_NAMESPACE_HID and try to match
> the
>                  * "compatible" property if found.
> -                *
> -                * The id returned by the below is not valid, but the
> only
> -                * caller passing non-NULL of_ids here is only
> interested in
> -                * whether or not the return value is NULL.
>                  */
> -               if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)
> -                   && acpi_of_match_device(device, of_ids))
> -                       return id;
> +               if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id))
> +                       return acpi_of_match_device(device, of_ids,
> of_id);
>         }
> -       return NULL;
> +       return false;
>  }
>
>  /**
> @@ -815,7 +826,10 @@ static const struct acpi_device_id
> *__acpi_match_device(
>  const struct acpi_device_id *acpi_match_device(const struct
> acpi_device_id *ids,
>                                                const struct device
> *dev)
>  {
> -       return __acpi_match_device(acpi_companion_match(dev), ids,
> NULL);
> +       const struct acpi_device_id *id = NULL;
> +
> +       __acpi_match_device(acpi_companion_match(dev), ids, NULL, &id,
> NULL);
> +       return id;
>  }
>  EXPORT_SYMBOL_GPL(acpi_match_device);
>
> @@ -840,7 +854,7 @@ EXPORT_SYMBOL_GPL(acpi_get_match_data);
>  int acpi_match_device_ids(struct acpi_device *device,
>                           const struct acpi_device_id *ids)
>  {
> -       return __acpi_match_device(device, ids, NULL) ? 0 : -ENOENT;
> +       return __acpi_match_device(device, ids, NULL, NULL, NULL) ? 0 :
> -ENOENT;
>  }
>  EXPORT_SYMBOL(acpi_match_device_ids);
>
> @@ -849,10 +863,12 @@ bool acpi_driver_match_device(struct device *dev,
>  {
>         if (!drv->acpi_match_table)
>                 return acpi_of_match_device(ACPI_COMPANION(dev),
> -                                           drv->of_match_table);
> +                                           drv->of_match_table,
> +                                           NULL);
>
> -       return !!__acpi_match_device(acpi_companion_match(dev),
> -                                    drv->acpi_match_table, drv-
>>of_match_table);
> +       return __acpi_match_device(acpi_companion_match(dev),
> +                                  drv->acpi_match_table, drv-
>>of_match_table,
> +                                  NULL, NULL);
>  }
>  EXPORT_SYMBOL_GPL(acpi_driver_match_device);
>
> --
> 2.15.1
>
>
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
