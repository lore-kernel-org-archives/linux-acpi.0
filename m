From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH 08/14] wmi: Probe data objects for read and write
 capabilities
Date: Sat, 16 Jan 2016 14:11:11 +0100
Message-ID: <20160116131111.GB7816@eudyptula.hq.kempniu.pl>
References: <cover.1448931782.git.luto@kernel.org>
 <6027f0563e82e3ca5265c6b29777636a9b8dc244.1448931782.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34778 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbcAPNLO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2016 08:11:14 -0500
Received: by mail-lb0-f194.google.com with SMTP id oe3so5794046lbb.1
        for <linux-acpi@vger.kernel.org>; Sat, 16 Jan 2016 05:11:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6027f0563e82e3ca5265c6b29777636a9b8dc244.1448931782.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>

> My laptop has one RW data object, one RO data object, and one
> totally inaccessible data object.  Check for the existence of the
> accessor methods and report in sysfs.
>=20
> The docs also permit WQxx getters for single-instance objects to
> take no parameters.  Probe for that as well to avoid ACPICA warnings
> about mismatched signatures.
>=20
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/platform/x86/wmi.c | 94 ++++++++++++++++++++++++++++++++++++=
++++++++--
>  include/linux/wmi.h        |  6 +++
>  2 files changed, 96 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 5571ae7354a1..49be61207c4a 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -66,6 +66,8 @@ struct wmi_block {
>  	struct acpi_device *acpi_device;
>  	wmi_notify_handler handler;
>  	void *handler_data;
> +
> +	bool read_takes_no_args;	/* only defined if readable */
>  };
> =20
> =20
> @@ -216,6 +218,25 @@ static bool find_guid(const char *guid_string, s=
truct wmi_block **out)
>  	return false;
>  }
> =20
> +static int get_subobj_info(acpi_handle handle, const char *pathname,
> +			   struct acpi_device_info *info)
> +{
> +	acpi_handle subobj_handle;
> +	acpi_status status;
> +
> +	status =3D acpi_get_handle(handle, (char *)pathname, &subobj_handle=
);
> +	if (status =3D=3D AE_NOT_FOUND)
> +		return -ENOENT;
> +	else if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	status =3D acpi_get_object_info(subobj_handle, &info);

acpi_get_object_info() allocates the returned buffer itself.  The latte=
r
should then subsequently be freed by the caller.  One solution is to
change get_subobj_info() so that it takes a struct acpi_device_info **
as an argument, which should then be passed to acpi_get_object_info().
See also below.

> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static acpi_status wmi_method_enable(struct wmi_block *wblock, int e=
nable)
>  {
>  	struct guid_block *block =3D NULL;
> @@ -339,6 +360,9 @@ struct acpi_buffer *out)
>  	wq_params[0].type =3D ACPI_TYPE_INTEGER;
>  	wq_params[0].integer.value =3D instance;
> =20
> +	if (instance =3D=3D 0 && wblock->read_takes_no_args)
> +		input.count =3D 0;
> +
>  	/*
>  	 * If ACPI_WMI_EXPENSIVE, call the relevant WCxx method first to
>  	 * enable collection.
> @@ -706,11 +730,37 @@ static ssize_t object_id_show(struct device *de=
v, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(object_id);
> =20
> -static struct attribute *wmi_data_or_method_attrs[] =3D {
> +static ssize_t readable_show(struct device *dev, struct device_attri=
bute *attr,
> +			     char *buf)
> +{
> +	struct wmi_device *wdev =3D dev_to_wdev(dev);
> +
> +	return sprintf(buf, "%d\n", (int)wdev->readable);
> +}
> +static DEVICE_ATTR_RO(readable);
> +
> +static ssize_t writeable_show(struct device *dev, struct device_attr=
ibute *attr,
> +			      char *buf)
> +{
> +	struct wmi_device *wdev =3D dev_to_wdev(dev);
> +
> +	return sprintf(buf, "%d\n", (int)wdev->writeable);
> +}
> +static DEVICE_ATTR_RO(writeable);
> +
> +static struct attribute *wmi_data_attrs[] =3D {
>  	&dev_attr_object_id.attr,
> +	&dev_attr_readable.attr,
> +	&dev_attr_writeable.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(wmi_data_or_method);
> +ATTRIBUTE_GROUPS(wmi_data);
> +
> +static struct attribute *wmi_method_attrs[] =3D {
> +	&dev_attr_object_id.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(wmi_method);
> =20
>  static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_env=
 *env)
>  {
> @@ -809,13 +859,13 @@ static struct device_type wmi_type_event =3D {
> =20
>  static struct device_type wmi_type_method =3D {
>  	.name =3D "method",
> -	.groups =3D wmi_data_or_method_groups,
> +	.groups =3D wmi_method_groups,
>  	.release =3D wmi_dev_release,
>  };
> =20
>  static struct device_type wmi_type_data =3D {
>  	.name =3D "data",
> -	.groups =3D wmi_data_or_method_groups,
> +	.groups =3D wmi_data_groups,
>  	.release =3D wmi_dev_release,
>  };
> =20
> @@ -834,7 +884,43 @@ static int wmi_create_device(struct device *wmi_=
bus_dev,
>  	} else if (gblock->flags & ACPI_WMI_METHOD) {
>  		wblock->dev.dev.type =3D &wmi_type_method;
>  	} else {
> +		struct acpi_device_info info;

struct acpi_device_info *info;

> +		char method[5];
> +		int result;
> +
>  		wblock->dev.dev.type =3D &wmi_type_data;
> +
> +		strcpy(method, "WQ");
> +		strncat(method, wblock->gblock.object_id, 2);
> +		result =3D get_subobj_info(device->handle, method, &info);
> +
> +		if (result =3D=3D 0) {
> +			wblock->dev.readable =3D true;
> +
> +			/*
> +			 * The Microsoft documentation specifically states:
> +			 *
> +			 *   Data blocks registered with only a single instance
> +			 *   can ignore the parameter.
> +			 *
> +			 * ACPICA will get mad at us if we call the method
> +			 * with the wrong number of arguments, so check what
> +			 * our method expects.  (On some Dell laptops, WQxx
> +			 * may not be a method at all.)
> +			 */
> +			if (info.type !=3D ACPI_TYPE_METHOD ||
> +			    info.param_count =3D=3D 0)
> +				wblock->read_takes_no_args =3D true;

kfree(info)

> +		}
> +
> +		strcpy(method, "WS");
> +		strncat(method, wblock->gblock.object_id, 2);
> +		result =3D get_subobj_info(device->handle, method, &info);
> +
> +		if (result =3D=3D 0) {
> +			wblock->dev.writeable =3D true;

kfree(info)

--=20
Best regards,
Micha=C5=82 K=C4=99pie=C5=84
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
