From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: BUG: spinlock bad magic on CPU#0
Date: Fri, 14 Jan 2011 23:51:18 +0200
Message-ID: <20110114215118.GA3893@swordfish>
References: <20110114140803.GA4003@swordfish>
 <201101142209.35892.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37512 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab1ANVv1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jan 2011 16:51:27 -0500
Content-Disposition: inline
In-Reply-To: <201101142209.35892.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On (01/14/11 22:09), Rafael J. Wysocki wrote:
> > Hello,
>=20
> Does the appended patch help?
>=20
>

Hello,
Yes, it does. Seems to be fixed.

Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


Thanks,
	Sergey

=20
> ---
>  drivers/acpi/acpica/acglobal.h |    2 ++
>  drivers/acpi/acpica/evmisc.c   |    2 --
>  drivers/acpi/acpica/utmutex.c  |    1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
>=20
> Index: linux-2.6/drivers/acpi/acpica/acglobal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/acpica/acglobal.h
> +++ linux-2.6/drivers/acpi/acpica/acglobal.h
> @@ -228,8 +228,10 @@ ACPI_EXTERN u8 acpi_gbl_global_lock_pres
>   */
>  ACPI_EXTERN spinlock_t _acpi_gbl_gpe_lock;	/* For GPE data structs and r=
egisters */
>  ACPI_EXTERN spinlock_t _acpi_gbl_hardware_lock;	/* For ACPI H/W except G=
PE registers */
> +ACPI_EXTERN spinlock_t _acpi_ev_global_lock_pending_lock; /* For global =
lock */
>  #define acpi_gbl_gpe_lock	&_acpi_gbl_gpe_lock
>  #define acpi_gbl_hardware_lock	&_acpi_gbl_hardware_lock
> +#define acpi_ev_global_lock_pending_lock &_acpi_ev_global_lock_pending_l=
ock
> =20
>  /***********************************************************************=
******
>   *
> Index: linux-2.6/drivers/acpi/acpica/evmisc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/acpica/evmisc.c
> +++ linux-2.6/drivers/acpi/acpica/evmisc.c
> @@ -293,8 +293,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_no
>   *
>   ***********************************************************************=
*******/
>  static u8 acpi_ev_global_lock_pending;
> -static spinlock_t _acpi_ev_global_lock_pending_lock;
> -#define acpi_ev_global_lock_pending_lock &_acpi_ev_global_lock_pending_l=
ock
> =20
>  static u32 acpi_ev_global_lock_handler(void *context)
>  {
> Index: linux-2.6/drivers/acpi/acpica/utmutex.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/acpica/utmutex.c
> +++ linux-2.6/drivers/acpi/acpica/utmutex.c
> @@ -85,6 +85,7 @@ acpi_status acpi_ut_mutex_initialize(voi
> =20
>  	spin_lock_init(acpi_gbl_gpe_lock);
>  	spin_lock_init(acpi_gbl_hardware_lock);
> +	spin_lock_init(acpi_ev_global_lock_pending_lock);
> =20
>  	/* Mutex for _OSI support */
>  	status =3D acpi_os_create_mutex(&acpi_gbl_osi_mutex);
>=20

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iJwEAQECAAYFAk0wxVYACgkQfKHnntdSXjRiRgQAwOWECgpZ4TH2cw2cELPW5dDj
/H8P4T7KGYRqii5vC9Y4nkwkVUEzm1YqVff6EJOWBwgkqAvDYTKtFPmSXNpeOSJ0
o+XIAt2uaQ8BFKDcaZkuPiiEi71MEz5OpRQg357h4BENuMCJmmyW/qY5v8vBJMG7
rdkFOEKfW0lMARfNMwQ=
=s1x1
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
