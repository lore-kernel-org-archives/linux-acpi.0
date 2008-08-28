From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup (PNP0C32)
Date: Thu, 28 Aug 2008 17:36:42 +0200
Message-ID: <20080828153642.GP26610@one.firstfloor.org>
References: <1206585013.8282.17.camel@sli10-desk.sh.intel.com> <20080327160346.424052fe.miknix@gmail.com> <1206668215.12574.8.camel@sli10-desk.sh.intel.com> <20080328193919.fb23bcc8.miknix@gmail.com> <20080824183924.daf28d3b.miknix@gmail.com> <1219627740.24775.12.camel@rzhang-dt> <878wujsjku.fsf@basil.nowhere.org> <20080828143708.25815142.miknix@gmail.com> <20080828130804.GO26610@one.firstfloor.org> <20080828154745.0ccf261b.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:42274 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbYH1PeJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2008 11:34:09 -0400
Content-Disposition: inline
In-Reply-To: <20080828154745.0ccf261b.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

On Thu, Aug 28, 2008 at 03:47:45PM +0200, =C2ngelo Miguel Arrifano wrot=
e:
> On Thu, 28 Aug 2008 15:08:05 +0200
> Andi Kleen <andi@firstfloor.org> wrote:
>=20
> > > Ok thanks, here it is.
> >=20
> > Please submit it with proper description and Signed-off-by lines.
> > (see Documentation/SubmittingPatches)
> >=20
> > -Andi

Quick review:

Need a title (one line description)=20

Best probably you run it through checkpatch.pl and fix the warnings
and possibly also Lindent.

> index c52fca8..ed48a56 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -199,6 +199,14 @@ config ACPI_THERMAL
>  	  recommended that this option be enabled, as your processor(s)
>  	  may be damaged without it.
> =20
> +config ACPI_QUICKSTART
> +	tristate "Quickstart"
> +	default m

Please remove the default m

Also I think the position is wrong, this should be further down with
other misc ACPI drivers.

> +
> +#define QUICKSTART_PF_DRIVER_NAME     "quickstart"
> +#define QUICKSTART_PF_DEVICE_NAME     "quickstart"
> +#define QUICKSTART_PF_DEVATTR_NAME    "pressed_button"

I don't see the point of these defines. Can you just expand
them please?=20

> +
> +/*
> + * ACPI driver Structs
> + */
> +
> +struct quickstart_acpi {
> +	struct acpi_device *device;
> +	struct quickstart_btn *btn;
> +};

There should be a new line here.

> +static int quickstart_acpi_add(struct acpi_device *device);
> +static int quickstart_acpi_remove(struct acpi_device *device, int ty=
pe);

Standard practice is to reorder the file that forward declarations
are not needed.

> +
> +static struct acpi_driver quickstart_acpi_driver =3D {
> +	.name =3D "quickstart",
> +	.class =3D QUICKSTART_ACPI_CLASS,
> +	.ids =3D quickstart_device_ids,
> +	.ops =3D {
> +			.add =3D quickstart_acpi_add,
> +			.remove =3D quickstart_acpi_remove,

Unusual indentation.

> +		},
> +};
> +
> +/*
> + * Platform driver structs
> + */
> +static ssize_t buttons_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf);
> +static ssize_t pressed_button_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf);
> +static ssize_t pressed_button_store(struct device *dev,
> +					struct device_attribute *attr,
> +					 const char *buf,
> +					 size_t count);

See above for forward declarations.
> + */
> +static ssize_t buttons_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	int count =3D 0;
> +	struct quickstart_btn *ptr =3D quickstart_data.btn_lst;
> +
> +	if (!ptr)
> +		return snprintf(buf, PAGE_SIZE, "none");
> +
> +	while (ptr && (count < PAGE_SIZE)) {
> +		if (ptr->name) {
> +			count +=3D snprintf(buf + count,
> +					PAGE_SIZE - count,
> +					"%s\n", ptr->name);
> +		}
> +		ptr =3D ptr->next;
> +	}

Is it guaranteed that list is always shorter than
PAGE_SIZE? PAGE_SIZE - count might go negative otherwise
and snprintf will not handle that. Should be some proper limit.


> +
> +
> +static ssize_t pressed_button_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	if (count < 2)
> +		return -EINVAL;

Check is redundant.

> +
> +	if (strncasecmp(buf, "none", 4) !=3D 0)
> +		return -EINVAL;
> +
> +	quickstart_data.pressed =3D NULL;
> +	return count;
> +}
> +
> +/* Hotstart Helper functions */
> +static int quickstart_btnlst_add(struct quickstart_btn **data)
> +{
> +	struct quickstart_btn **ptr =3D &quickstart_data.btn_lst;
> +
> +	while (*ptr)
> +		ptr =3D &((*ptr)->next);

Would be all clearer if you used standard list.h lists.

> +	ret =3D quickstart_btnlst_add(&quickstart->btn);
> +	if (ret)
> +		return ret;
> +
> +	quickstart->btn->name =3D kzalloc(len + 1, GFP_KERNEL);

> +	if (!quickstart->btn->name) {
> +		quickstart_btnlst_free();
> +		return -ENOMEM;
> +	}
> +	strcpy(quickstart->btn->name, bid);

Use kstrndup()

> +
> +	platform_device_unregister(pf_device);
> +
> +	platform_driver_unregister(&pf_driver);
> +
> +	acpi_bus_unregister_driver(&quickstart_acpi_driver);
> +
> +	quickstart_btnlst_free();
> +
> +	return;

You have a lot of stray such returns; Remove them all.

> Signed-off-by: Angelo Miguel Arrifano <miknix@gmail.com>

That should be at the bottom of the description.

-Andi


--=20
ak@linux.intel.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
