From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH 09/14] wmi: Instantiate all devices before adding them
Date: Sun, 17 Jan 2016 15:06:08 +0100
Message-ID: <20160117140608.GA8869@eudyptula.hq.kempniu.pl>
References: <cover.1448931782.git.luto@kernel.org>
 <344ad68ef32ea13d2a7bb81e3ced15c4507a6cc8.1448931782.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32872 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbcAQOGM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Jan 2016 09:06:12 -0500
Received: by mail-lf0-f65.google.com with SMTP id z62so10818434lfd.0
        for <linux-acpi@vger.kernel.org>; Sun, 17 Jan 2016 06:06:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <344ad68ef32ea13d2a7bb81e3ced15c4507a6cc8.1448931782.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>

> At some point, we'll want to subdrivers to get references to other

Did you mean "(...) we'll want subdrivers to get references to (...)"
(without the first "to")?

> devices on the same WMI bus.  This change is needed to avoid races.
>=20
> This ends up simplifying the setup code and fixng some leaks, too.

fixing

>=20
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/platform/x86/wmi.c | 49 +++++++++++++++++++++++++++++-------=
----------
>  1 file changed, 31 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 49be61207c4a..7d8a11a45bf9 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -869,7 +869,7 @@ static struct device_type wmi_type_data =3D {
>  	.release =3D wmi_dev_release,
>  };
> =20
> -static int wmi_create_device(struct device *wmi_bus_dev,
> +static void wmi_create_device(struct device *wmi_bus_dev,
>  			     const struct guid_block *gblock,
>  			     struct wmi_block *wblock,
>  			     struct acpi_device *device)
> @@ -923,7 +923,7 @@ static int wmi_create_device(struct device *wmi_b=
us_dev,
> =20
>  	}
> =20
> -	return device_register(&wblock->dev.dev);
> +	device_initialize(&wblock->dev.dev);
>  }
> =20
>  static void wmi_free_devices(struct acpi_device *device)
> @@ -934,10 +934,14 @@ static void wmi_free_devices(struct acpi_device=
 *device)
>  	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
>  		if (wblock->acpi_device =3D=3D device) {
>  			list_del(&wblock->list);
> -			if (wblock->dev.dev.bus)
> -				device_unregister(&wblock->dev.dev);
> -			else
> +			if (wblock->dev.dev.bus) {
> +				/* Device was initialized. */
> +				device_del(&wblock->dev.dev);
> +				put_device(&wblock->dev.dev);

Is there any specific reason for splitting device_unregister() into two
separate calls it performs?

> +			} else {
> +				/* device_initialize was not called. */
>  				kfree(wblock);

This kfree() obviously wasn't introduced by you, but I believe that
after patch 06 from this series is applied, this branch cannot be
reached any more.  If I understand correctly, it could only be reached
(using code without this patch series applied) when duplicate GUIDs wer=
e
present, for which a struct wmi_block was allocated and added to
wmi_block_list, but for which wmi_create_device() wasn't called.  Patch
06 prevents a struct wmi_block from ever being allocated for duplicate
GUIDs and this patch ensures that even if device_add() fails for some
reason, the relevant struct wmi_block is removed from wmi_block_list an=
d
freed anyway.  I also don't see any way for a struct wmi_block to be
inserted into wmi_block_list without both wmi_create_device() (so
device_initialize()) and device_add() being called.  So perhaps this
kfree() call (and the relevant conditional expression) could be removed
in another patch?

> +			}
>  		}
>  	}
>  }
> @@ -972,9 +976,9 @@ static int parse_wdg(struct device *wmi_bus_dev, =
struct acpi_device *device)
>  	struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
>  	union acpi_object *obj;
>  	const struct guid_block *gblock;
> -	struct wmi_block *wblock;
> +	struct wmi_block *wblock, *next;
>  	acpi_status status;
> -	int retval;
> +	int retval =3D 0;
>  	u32 i, total;
> =20
>  	status =3D acpi_evaluate_object(device->handle, "_WDG", NULL, &out)=
;
> @@ -1007,19 +1011,15 @@ static int parse_wdg(struct device *wmi_bus_d=
ev, struct acpi_device *device)
>  			continue;
> =20
>  		wblock =3D kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
> -		if (!wblock)
> -			return -ENOMEM;
> +		if (!wblock) {
> +			retval =3D -ENOMEM;
> +			break;
> +		}
> =20
>  		wblock->acpi_device =3D device;
>  		wblock->gblock =3D gblock[i];
> =20
> -		retval =3D wmi_create_device(wmi_bus_dev, &gblock[i],
> -					   wblock, device);
> -		if (retval) {
> -			put_device(&wblock->dev.dev);
> -			wmi_free_devices(device);
> -			goto out_free_pointer;
> -		}
> +		wmi_create_device(wmi_bus_dev, &gblock[i], wblock, device);
> =20
>  		list_add_tail(&wblock->list, &wmi_block_list);
> =20
> @@ -1029,11 +1029,24 @@ static int parse_wdg(struct device *wmi_bus_d=
ev, struct acpi_device *device)
>  		}
>  	}
> =20
> -	retval =3D 0;
> -
>  out_free_pointer:
>  	kfree(out.pointer);

Perhaps this label and the kfree() call should be moved closer to the
return statement below to avoid confusion?  If obj is not a buffer then
no new struct wmi_block(s) will be added to wmi_block_list, so there is
little point in iterating over the latter below.

> =20
> +	/*
> +	 * Now that all of the devices are created, add them to the
> +	 * device tree and probe subdrivers.
> +	 */
> +	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
> +		if (wblock->acpi_device =3D=3D device) {
> +			if (device_add(&wblock->dev.dev) !=3D 0) {
> +				dev_err(wmi_bus_dev,
> +					"failed to register %pULL\n",
> +					wblock->gblock.guid);
> +				list_del(&wblock->list);

A put_device(&wblock->dev.dev) is missing here.  If we don't do that,
the reference count for wblock->dev.dev will still be at 1 due to
device_initialize() being called before and we will leak wblock.

I have one more minor issue with error handling for device_add().  A bi=
t
earlier, in the GUID-processing loop, there's this snippet:

	if (debug_event) {
		wblock->handler =3D wmi_notify_debug;
		wmi_method_enable(wblock, 1);
	}

So we should probably put:

	if (debug_event)
		wmi_method_enable(wblock, 0);

before the put_device() call I mentioned above.

--=20
Best regards,
Micha=C5=82 K=C4=99pie=C5=84
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
