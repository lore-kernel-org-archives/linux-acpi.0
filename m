From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup
	(PNP0C32)
Date: Thu, 27 Mar 2008 10:30:13 +0800
Message-ID: <1206585013.8282.17.camel@sli10-desk.sh.intel.com>
References: <20080314151712.34836918.miknix@gmail.com>
	 <1206428373.3047.34.camel@acpi-hp-zz.sh.intel.com>
	 <20080326175139.d59ff46d.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53501 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412AbYC0Cbj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Mar 2008 22:31:39 -0400
In-Reply-To: <20080326175139.d59ff46d.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org


On Thu, 2008-03-27 at 01:51 +0800, =C3=82ngelo Miguel Arrifano wrote:
> PATCH
> - -----------------------------------------------------------------
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f688c21..fb096ee 100644
> - --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -196,6 +196,14 @@ config ACPI_THERMAL
>           recommended that this option be enabled, as your
> processor(s)
>           may be damaged without it.
>=20
> +config ACPI_QUICKSTART
> +       tristate "Quickstart"
> +       default y
default m?


> +
> +static struct quickstart_driver_data {
> +       struct quickstart_btn *btn_lst;
> +       struct quickstart_btn *pressed;
> +} quickstart_data =3D {
> +       .btn_lst =3D NULL,
> +       .pressed =3D NULL,
> +};
They are NULL, you don't need initialize them.


> + * Platform driver structs
> + */
> +static ssize_t buttons_show(struct device *dev,
> +                                       struct device_attribute *attr=
,
> +                                       char *buf);
> +static ssize_t pressed_button_show(struct device *dev,
> +                                       struct device_attribute *attr=
,
> +                                       char *buf);
> +static ssize_t pressed_button_store(struct device *dev,
> +                                       struct device_attribute *attr=
,
> +                                        const char *buf,
> +                                        size_t count);
> +static DEVICE_ATTR(pressed_button, 0666, pressed_button_show,
> +                                        pressed_button_store);
this file can be changed by non-root?


> +static ssize_t buttons_show(struct device *dev,
> +                                        struct device_attribute
> *attr,
> +                                        char *buf)
> +{
> +       int count =3D 0;
> +       char tmpbuf[QUICKSTART_MAX_BTN_NAME_LEN + 2];
> +       struct quickstart_btn *ptr =3D quickstart_data.btn_lst;
> +
> +       if (!ptr)
> +               return snprintf(buf, PAGE_SIZE, "none");
> +
> +       while (ptr && (count < PAGE_SIZE)) {
> +               if (ptr->name) {
> +                       strncpy(tmpbuf, ptr->name,
> QUICKSTART_MAX_BTN_NAME_LEN);
> +                       strcat(tmpbuf, "\n");
> +                       count +=3D snprintf(buf + count,
> +                                       PAGE_SIZE - count,
> +                                       tmpbuf);
we could simplify:
snprintf(buf + count, PAGE_SIZE -count, "%s\n", ptr->name);
> +               }
> +               ptr =3D ptr->next;
> +       }
> +
> +       return count;
> +}

> +

> +
> +/* ACPI Driver functions */
> +static void quickstart_acpi_notify(acpi_handle handle, u32 event,
> void *data)
> +{
> +       struct quickstart_acpi *quickstart =3D data;
> +
> +       if (!quickstart)
> +               return;
> +
> +       if (event =3D=3D QUICKSTART_EVENT_WAKE) {
> +               quickstart_data.pressed =3D quickstart->btn;
> +               printk(KERN_ERR "quickstart: Quickbutton %s
> pressed.\n",
> +
> acpi_device_bid(quickstart->device));
> +       } else if (event =3D=3D QUICKSTART_EVENT_RUNTIME) {
> +               printk(KERN_ERR "quickstart: Runtime button %s
> pressed.\n\t"
> +                      "please report on linux-acpi@vger.kernel.org",
> +
> acpi_device_bid(quickstart->device));
> +       }
Please remove above printks. they are misleading, which isn't an error.
please send an ACPI event to userspace in the notify, we need it for
runtime.

> +       return;
> +}
> +
> +static void quickstart_acpi_raise_notify(struct quickstart_acpi
> *quickstart)
> +{
> +       acpi_status status;
> +       struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +
> +       if (!quickstart)
> +               return;
> +
> +       /* This returns a buffer telling the  button usage ID
> (useless),
> +        * we dont care about it now. The important is to trigger
> +        * pending notify events (The ones before booting). */
> +       status =3D acpi_evaluate_object(quickstart->device->handle,
> +                                       "GHID", NULL, &buffer);
> +       if (ACPI_FAILURE(status) || !buffer.pointer) {
> +               printk(KERN_ERR "quickstart: %s GHID method
> failed.\n",
> +                      quickstart->btn->name);
> +               return;
> +       }
I'd suggest the GHID info should be exported to sysfs too. It's hard to
judge what a button is just per its name. You know it but an
inexperienced user doesn't.=20

> +       kfree(buffer.pointer);
> +       return;
> +}
> +

> +
> +static int quickstart_acpi_add(struct acpi_device *device)
> +{
> +       int ret =3D 0;
> +       acpi_status status =3D AE_OK;
> +       struct quickstart_acpi *quickstart =3D NULL;
> +
> +       if (!device)
> +               return -EINVAL;
> +
> +       quickstart =3D kzalloc(sizeof(struct quickstart_acpi),
> GFP_KERNEL);
> +       if (!quickstart)
> +               return -ENOMEM;
> +
> +       quickstart->device =3D device;
> +       strcpy(acpi_device_name(device), QUICKSTART_ACPI_DEVICE_NAME)=
;
> +       strcpy(acpi_device_class(device), QUICKSTART_ACPI_CLASS);
> +       acpi_driver_data(device) =3D quickstart;
> +
> +       /* Add button to list and initialize some stuff */
> +       ret =3D quickstart_acpi_config(quickstart,
> acpi_device_bid(device));
> +       if (ret)
> +               goto fail_config;
> +
> +       status =3D acpi_install_notify_handler(device->handle,
> +                                               ACPI_ALL_NOTIFY,
> +
> quickstart_acpi_notify,
> +                                               quickstart);
> +       if (ACPI_FAILURE(status)) {
> +               printk(KERN_ERR "quickstart: Notify handler install
> error\n");
> +               ret =3D -ENODEV;
> +               goto fail_installnotify;
memory is freed but it's still in the list.

Thanks,
Shaohua

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
