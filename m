From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 05/14] wmi: Turn WMI into a bus driver
Date: Sat, 16 Jan 2016 08:19:43 -0800
Message-ID: <CALCETrXd8uWfutP24dAMbiALHfs_P1idbU7aaWRGQ5K1+D-_Tg@mail.gmail.com>
References: <cover.1448931782.git.luto@kernel.org> <e51677868b69e4bcf8847b340c92673e7e92b20d.1448931782.git.luto@kernel.org>
 <20160116125639.GA7816@eudyptula.hq.kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35640 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbcAPQUD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2016 11:20:03 -0500
Received: by mail-ob0-f181.google.com with SMTP id py5so165324238obc.2
        for <linux-acpi@vger.kernel.org>; Sat, 16 Jan 2016 08:20:03 -0800 (PST)
In-Reply-To: <20160116125639.GA7816@eudyptula.hq.kempniu.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Andy Lutomirski <luto@kernel.org>, Darren Hart <dvhart@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>

On Sat, Jan 16, 2016 at 4:56 AM, Micha=C5=82 K=C4=99pie=C5=84 <kernel@k=
empniu.pl> wrote:
>> WMI is logically a bus: the WMI driver binds to an ACPI node (or
>> more than one), and each instance of the WMI driver enumerates its
>> children and hopes that drivers will attach to the children that are
>> useful.
>>
>> This patch gives WMI a driver model bus type and the ability to
>> match to drivers.  The bus itself is a device in the new "wmi_bus"
>> class, and all of the individual WMI devices are slotted into the
>> device hierarchy correctly.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>  drivers/platform/x86/wmi.c | 198 ++++++++++++++++++++++++++++++++++=
+----------
>>  include/linux/wmi.h        |  47 +++++++++++
>>  2 files changed, 202 insertions(+), 43 deletions(-)
>>  create mode 100644 include/linux/wmi.h
>>
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index dcb34a5f5669..2fa9493bd35c 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -37,14 +37,13 @@
>>  #include <linux/acpi.h>
>>  #include <linux/slab.h>
>>  #include <linux/module.h>
>> +#include <linux/wmi.h>
>>
>>  ACPI_MODULE_NAME("wmi");
>>  MODULE_AUTHOR("Carlos Corbacho");
>>  MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
>>  MODULE_LICENSE("GPL");
>>
>> -#define ACPI_WMI_CLASS "wmi"
>> -
>>  static LIST_HEAD(wmi_block_list);
>>
>>  struct guid_block {
>> @@ -61,12 +60,12 @@ struct guid_block {
>>  };
>>
>>  struct wmi_block {
>> +     struct wmi_device dev;
>>       struct list_head list;
>>       struct guid_block gblock;
>>       struct acpi_device *acpi_device;
>>       wmi_notify_handler handler;
>>       void *handler_data;
>> -     struct device dev;
>>  };
>>
>>
>> @@ -101,8 +100,8 @@ static const struct acpi_device_id wmi_device_id=
s[] =3D {
>>  MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
>>
>>  static struct acpi_driver acpi_wmi_driver =3D {
>> -     .name =3D "wmi",
>> -     .class =3D ACPI_WMI_CLASS,
>> +     .name =3D "acpi-wmi",
>> +     .owner =3D THIS_MODULE,
>>       .ids =3D wmi_device_ids,
>>       .ops =3D {
>>               .add =3D acpi_wmi_add,
>> @@ -623,77 +622,146 @@ bool wmi_has_guid(const char *guid_string)
>>  }
>>  EXPORT_SYMBOL_GPL(wmi_has_guid);
>>
>> +static struct wmi_block *dev_to_wblock(struct device *dev)
>> +{
>> +     return container_of(dev, struct wmi_block, dev.dev);
>> +}
>> +
>> +static struct wmi_device *dev_to_wdev(struct device *dev)
>> +{
>> +     return container_of(dev, struct wmi_device, dev);
>> +}
>> +
>>  /*
>>   * sysfs interface
>>   */
>>  static ssize_t modalias_show(struct device *dev, struct device_attr=
ibute *attr,
>>                            char *buf)
>>  {
>> -     struct wmi_block *wblock;
>> -
>> -     wblock =3D dev_get_drvdata(dev);
>> -     if (!wblock) {
>> -             strcat(buf, "\n");
>> -             return strlen(buf);
>> -     }
>> +     struct wmi_block *wblock =3D dev_to_wblock(dev);
>>
>>       return sprintf(buf, "wmi:%pUL\n", wblock->gblock.guid);
>>  }
>>  static DEVICE_ATTR_RO(modalias);
>>
>> +static ssize_t guid_show(struct device *dev, struct device_attribut=
e *attr,
>> +                      char *buf)
>> +{
>> +     struct wmi_block *wblock =3D dev_to_wblock(dev);
>> +
>> +     return sprintf(buf, "%pUL\n", wblock->gblock.guid);
>> +}
>> +static DEVICE_ATTR_RO(guid);
>> +
>>  static struct attribute *wmi_attrs[] =3D {
>>       &dev_attr_modalias.attr,
>> +     &dev_attr_guid.attr,
>>       NULL,
>>  };
>>  ATTRIBUTE_GROUPS(wmi);
>>
>>  static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_en=
v *env)
>>  {
>> -     char guid_string[37];
>> -
>> -     struct wmi_block *wblock;
>> +     struct wmi_block *wblock =3D dev_to_wblock(dev);
>>
>> -     if (add_uevent_var(env, "MODALIAS=3D"))
>> +     if (add_uevent_var(env, "MODALIAS=3Dwmi:%pUL", wblock->gblock.=
guid))
>>               return -ENOMEM;
>>
>> -     wblock =3D dev_get_drvdata(dev);
>> -     if (!wblock)
>> +     if (add_uevent_var(env, "WMI_GUID=3D%pUL", wblock->gblock.guid=
))
>>               return -ENOMEM;
>>
>> -     sprintf(guid_string, "%pUL", wblock->gblock.guid);
>> +     return 0;
>> +}
>> +
>> +static void wmi_dev_release(struct device *dev)
>> +{
>> +     struct wmi_block *wblock =3D dev_to_wblock(dev);
>> +
>> +     kfree(wblock);
>> +}
>> +
>> +static int wmi_dev_match(struct device *dev, struct device_driver *=
driver)
>> +{
>> +     struct wmi_driver *wmi_driver =3D
>> +             container_of(driver, struct wmi_driver, driver);
>> +     struct wmi_block *wblock =3D dev_to_wblock(dev);
>> +     const struct wmi_device_id *id =3D wmi_driver->id_table;
>>
>> -     strcpy(&env->buf[env->buflen - 1], "wmi:");
>> -     memcpy(&env->buf[env->buflen - 1 + 4], guid_string, 36);
>> -     env->buflen +=3D 40;
>> +     while (id->guid_string) {
>> +             u8 tmp[16], driver_guid[16];
>> +
>> +             wmi_parse_guid(id->guid_string, tmp);
>> +             wmi_swap_bytes(tmp, driver_guid);
>> +             if (!memcmp(driver_guid, wblock->gblock.guid, 16))
>> +                     return 1;
>> +
>> +             id++;
>> +     }
>>
>>       return 0;
>>  }
>>
>> -static void wmi_dev_free(struct device *dev)
>> +int wmi_dev_probe(struct device *dev)
>
> Can be static.

Indeed, thanks.

>
>>  {
>> -     struct wmi_block *wmi_block =3D container_of(dev, struct wmi_b=
lock, dev);
>> +     struct wmi_block *wblock =3D dev_to_wblock(dev);
>> +     struct wmi_driver *wdriver =3D
>> +             container_of(dev->driver, struct wmi_driver, driver);
>> +     int ret =3D 0;
>> +
>> +     if (ACPI_FAILURE(wmi_method_enable(wblock, 1)))
>> +             dev_warn(dev, "failed to enable device -- probing anyw=
ay\n");
>> +
>> +     if (wdriver->probe) {
>> +             ret =3D wdriver->probe(dev_to_wdev(dev));
>> +             if (ret !=3D 0 && ACPI_FAILURE(wmi_method_enable(wbloc=
k, 0)))
>> +                     dev_warn(dev, "failed to disable device\n");
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +int wmi_dev_remove(struct device *dev)
>
> Can be static.

=46ixed.

>
>> +{
>> +     struct wmi_block *wblock =3D dev_to_wblock(dev);
>> +     struct wmi_driver *wdriver =3D
>> +             container_of(dev->driver, struct wmi_driver, driver);
>> +     int ret =3D 0;
>> +
>> +     if (wdriver->remove)
>> +             ret =3D wdriver->remove(dev_to_wdev(dev));
>> +
>> +     if (ACPI_FAILURE(wmi_method_enable(wblock, 0)))
>> +             dev_warn(dev, "failed to disable device\n");
>>
>> -     kfree(wmi_block);
>> +     return ret;
>>  }
>>
>> -static struct class wmi_class =3D {
>> +static struct class wmi_bus_class =3D {
>> +     .name =3D "wmi_bus",
>> +};
>> +
>> +static struct bus_type wmi_bus_type =3D {
>>       .name =3D "wmi",
>> -     .dev_release =3D wmi_dev_free,
>> -     .dev_uevent =3D wmi_dev_uevent,
>>       .dev_groups =3D wmi_groups,
>> +     .match =3D wmi_dev_match,
>> +     .uevent =3D wmi_dev_uevent,
>> +     .probe =3D wmi_dev_probe,
>> +     .remove =3D wmi_dev_remove,
>>  };
>>
>> -static int wmi_create_device(const struct guid_block *gblock,
>> +static int wmi_create_device(struct device *wmi_bus_dev,
>> +                          const struct guid_block *gblock,
>>                            struct wmi_block *wblock,
>>                            struct acpi_device *device)
>>  {
>> -     wblock->dev.class =3D &wmi_class;
>> +     wblock->dev.dev.bus =3D &wmi_bus_type;
>> +     wblock->dev.dev.parent =3D wmi_bus_dev;
>>
>> -     dev_set_name(&wblock->dev, "%pUL", gblock->guid);
>> +     dev_set_name(&wblock->dev.dev, "%pUL", gblock->guid);
>>
>> -     dev_set_drvdata(&wblock->dev, wblock);
>> +     wblock->dev.dev.release =3D wmi_dev_release;
>>
>> -     return device_register(&wblock->dev);
>> +     return device_register(&wblock->dev.dev);
>>  }
>>
>>  static void wmi_free_devices(struct acpi_device *device)
>> @@ -704,8 +772,8 @@ static void wmi_free_devices(struct acpi_device =
*device)
>>       list_for_each_entry_safe(wblock, next, &wmi_block_list, list) =
{
>>               if (wblock->acpi_device =3D=3D device) {
>>                       list_del(&wblock->list);
>> -                     if (wblock->dev.class)
>> -                             device_unregister(&wblock->dev);
>> +                     if (wblock->dev.dev.bus)
>> +                             device_unregister(&wblock->dev.dev);
>>                       else
>>                               kfree(wblock);
>>               }
>> @@ -737,7 +805,7 @@ static bool guid_already_parsed(struct acpi_devi=
ce *device,
>>  /*
>>   * Parse the _WDG method for the GUID data blocks
>>   */
>> -static int parse_wdg(struct acpi_device *device)
>> +static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device=
 *device)
>>  {
>>       struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
>>       union acpi_object *obj;
>> @@ -781,7 +849,8 @@ static int parse_wdg(struct acpi_device *device)
>>                 for device creation.
>>               */
>>               if (!guid_already_parsed(device, gblock[i].guid)) {
>> -                     retval =3D wmi_create_device(&gblock[i], wbloc=
k, device);
>> +                     retval =3D wmi_create_device(wmi_bus_dev, &gbl=
ock[i],
>> +                                                wblock, device);
>>                       if (retval) {
>>                               wmi_free_devices(device);
>>                               goto out_free_pointer;
>> @@ -881,12 +950,15 @@ static int acpi_wmi_remove(struct acpi_device =
*device)
>>       acpi_remove_address_space_handler(device->handle,
>>                               ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_=
handler);
>>       wmi_free_devices(device);
>> +     device_unregister((struct device *)acpi_driver_data(device));
>> +     device->driver_data =3D NULL;
>>
>>       return 0;
>>  }
>>
>>  static int acpi_wmi_add(struct acpi_device *device)
>>  {
>> +     struct device *wmi_bus_dev;
>>       acpi_status status;
>>       int error;
>>
>> @@ -899,14 +971,26 @@ static int acpi_wmi_add(struct acpi_device *de=
vice)
>>               return -ENODEV;
>>       }
>>
>> -     error =3D parse_wdg(device);
>> +     wmi_bus_dev =3D device_create(&wmi_bus_class, &device->dev, MK=
DEV(0, 0),
>> +                                 NULL, "wmi_bus-%s", dev_name(&devi=
ce->dev));
>> +     if (IS_ERR(wmi_bus_dev)) {
>> +             error =3D PTR_ERR(wmi_bus_dev);
>> +             goto err_remove_handler;
>> +     }
>> +     device->driver_data =3D wmi_bus_dev;
>> +
>> +     error =3D parse_wdg(wmi_bus_dev, device);
>>       if (error) {
>>               pr_err("Failed to parse WDG method\n");
>> -             goto err_remove_handler;
>> +             goto err_remove_busdev;
>>       }
>>
>>       return 0;
>>
>> +err_remove_busdev:
>> +     device_unregister(wmi_bus_dev);
>> +     put_device(wmi_bus_dev);
>
> I believe this put_device() call is excessive.  device_create() calls
> device_initialize() and device_add(); device_unregister() calls
> device_del() and put_device(), so it should already take care of
> removing all references to wmi_bus_dev.  Am I missing something?
>

I think you're right, and my acpi_wmi_remove agrees.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
