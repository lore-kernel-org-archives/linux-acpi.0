From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: add dynamic_debug support
Date: Mon, 26 May 2014 15:09:53 +0200
Message-ID: <60940418.4Cez3ysg4f@vostro.rjw.lan>
References: <1400755667-5377-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53603 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751651AbaEZMwt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 May 2014 08:52:49 -0400
In-Reply-To: <1400755667-5377-1-git-send-email-bjorn@mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Toshi Kani <toshi.kani@hp.com>

On Thursday, May 22, 2014 12:47:47 PM Bj=C3=B8rn Mork wrote:
> Commit 1a699476e258 ("ACPI / hotplug / PCI: Hotplug notifications
> from acpi_bus_notify()") added debug messages for a few common
> events. These debug messages are unconditionally enabled if
> CONFIG_DYNAMIC_DEBUG is defined, contrary to the documented
> meaning, making the ACPI system spew lots of unwanted noise on
> any kernel with dynamic debugging.
>=20
> The bug was introduced by commit fbfddae69657 ("ACPI: Add
> acpi_handle_<level>() interfaces"), which added the
> CONFIG_DYNAMIC_DEBUG dependency without respecting its meaning.
>=20
> Fix by adding real support for dynamic_debug.
>=20
> Fixes: fbfddae69657 ("ACPI: Add acpi_handle_<level>() interfaces")
> Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>

Queued up for 3.16, thanks!

> ---
> Background:  I suddenly got lots of these messages in v3.15-rcX
> without having enabled any ACPI debugging AFAIK:
>=20
>  ACPI: \_SB_.PCI0.HDEF: ACPI_NOTIFY_DEVICE_WAKE event
>  ACPI: \_SB_.PCI0.EHC1: ACPI_NOTIFY_DEVICE_WAKE event
>  ACPI: \_SB_.PCI0.EHC0: ACPI_NOTIFY_DEVICE_WAKE event
>  ACPI: \_SB_.PCI0.IGBE: ACPI_NOTIFY_DEVICE_WAKE event
>  ACPI: \_SB_.PCI0.HDEF: ACPI_NOTIFY_DEVICE_WAKE event
>=20
> The reason turned out to be that I have CONFIG_DYNAMIC_DEBUG
> enabled.  Which I must say I have primarily to debug other
> stuff, and *not* ACPI.
>=20
> An alternative way to fix this would of course be just removing
> the bogus CONFIG_DYNAMIC_DEBUG dependency. But I guess it's better
> to actually support dynamic debugging?
>=20
>=20
> Bj=C3=B8rn
>=20
>=20
>  drivers/acpi/utils.c |   64 ++++++++++++++++++++++++++++++++++++++++=
----------
>  include/linux/acpi.h |   22 +++++++++++++++--
>  2 files changed, 72 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index bba526148583..07c8c5a5ee95 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -30,6 +30,7 @@
>  #include <linux/types.h>
>  #include <linux/hardirq.h>
>  #include <linux/acpi.h>
> +#include <linux/dynamic_debug.h>
> =20
>  #include "internal.h"
> =20
> @@ -457,6 +458,24 @@ acpi_evaluate_ost(acpi_handle handle, u32 source=
_event, u32 status_code,
>  EXPORT_SYMBOL(acpi_evaluate_ost);
> =20
>  /**
> + * acpi_handle_path: Return the object path of handle
> + *
> + * Caller must free the returned buffer
> + */
> +static char *acpi_handle_path(acpi_handle handle)
> +{
> +	struct acpi_buffer buffer =3D {
> +		.length =3D ACPI_ALLOCATE_BUFFER,
> +		.pointer =3D NULL
> +	};
> +
> +	if (in_interrupt() ||
> +	    acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer) !=3D AE_OK)
> +		return NULL;
> +	return buffer.pointer;
> +}
> +
> +/**
>   * acpi_handle_printk: Print message with ACPI prefix and object pat=
h
>   *
>   * This function is called through acpi_handle_<level> macros and pr=
ints
> @@ -469,29 +488,50 @@ acpi_handle_printk(const char *level, acpi_hand=
le handle, const char *fmt, ...)
>  {
>  	struct va_format vaf;
>  	va_list args;
> -	struct acpi_buffer buffer =3D {
> -		.length =3D ACPI_ALLOCATE_BUFFER,
> -		.pointer =3D NULL
> -	};
>  	const char *path;
> =20
>  	va_start(args, fmt);
>  	vaf.fmt =3D fmt;
>  	vaf.va =3D &args;
> =20
> -	if (in_interrupt() ||
> -	    acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer) !=3D AE_OK)
> -		path =3D "<n/a>";
> -	else
> -		path =3D buffer.pointer;
> -
> -	printk("%sACPI: %s: %pV", level, path, &vaf);
> +	path =3D acpi_handle_path(handle);
> +	printk("%sACPI: %s: %pV", level, path ? path : "<n/a>" , &vaf);
> =20
>  	va_end(args);
> -	kfree(buffer.pointer);
> +	kfree(path);
>  }
>  EXPORT_SYMBOL(acpi_handle_printk);
> =20
> +#if defined(CONFIG_DYNAMIC_DEBUG)
> +/**
> + * __acpi_handle_debug: pr_debug with ACPI prefix and object path
> + *
> + * This function is called through acpi_handle_debug macro and debug
> + * prints a message with ACPI prefix and object path. This function
> + * acquires the global namespace mutex to obtain an object path.  In
> + * interrupt context, it shows the object path as <n/a>.
> + */
> +void
> +__acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle,
> +		    const char *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +	const char *path;
> +
> +	va_start(args, fmt);
> +	vaf.fmt =3D fmt;
> +	vaf.va =3D &args;
> +
> +	path =3D acpi_handle_path(handle);
> +	__dynamic_pr_debug(descriptor, "ACPI: %s: %pV", path ? path : "<n/a=
>", &vaf);
> +
> +	va_end(args);
> +	kfree(path);
> +}
> +EXPORT_SYMBOL(__acpi_handle_debug);
> +#endif
> +
>  /**
>   * acpi_has_method: Check whether @handle has a method named @name
>   * @handle: ACPI device handle
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 7a8f2cd66c8b..0e2569031a6f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -37,6 +37,7 @@
> =20
>  #include <linux/list.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/dynamic_debug.h>
> =20
>  #include <acpi/acpi.h>
>  #include <acpi/acpi_bus.h>
> @@ -589,6 +590,14 @@ static inline __printf(3, 4) void
>  acpi_handle_printk(const char *level, void *handle, const char *fmt,=
 ...) {}
>  #endif	/* !CONFIG_ACPI */
> =20
> +#if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
> +__printf(3, 4)
> +void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle han=
dle, const char *fmt, ...);
> +#else
> +#define __acpi_handle_debug(descriptor, handle, fmt, ...)		\
> +	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
> +#endif
> +
>  /*
>   * acpi_handle_<level>: Print message with ACPI prefix and object pa=
th
>   *
> @@ -610,11 +619,19 @@ acpi_handle_printk(const char *level, void *han=
dle, const char *fmt, ...) {}
>  #define acpi_handle_info(handle, fmt, ...)				\
>  	acpi_handle_printk(KERN_INFO, handle, fmt, ##__VA_ARGS__)
> =20
> -/* REVISIT: Support CONFIG_DYNAMIC_DEBUG when necessary */
> -#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
> +#if defined(DEBUG)
>  #define acpi_handle_debug(handle, fmt, ...)				\
>  	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__)
>  #else
> +#if defined(CONFIG_DYNAMIC_DEBUG)
> +#define acpi_handle_debug(handle, fmt, ...)				\
> +do {									\
> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
> +	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))		\
> +		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
> +				##__VA_ARGS__);				\
> +} while (0)
> +#else
>  #define acpi_handle_debug(handle, fmt, ...)				\
>  ({									\
>  	if (0)								\
> @@ -622,5 +639,6 @@ acpi_handle_printk(const char *level, void *handl=
e, const char *fmt, ...) {}
>  	0;								\
>  })
>  #endif
> +#endif
> =20
>  #endif	/*_LINUX_ACPI_H*/
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
