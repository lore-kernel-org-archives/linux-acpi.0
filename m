From: John M Flinchbaugh <john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [Suspend2-devel] Cause of Suspend2 resume failures on Toshiba laptops
Date: Mon, 7 Mar 2005 11:48:00 -0500
Message-ID: <20050307164800.GA28079@butterfly.hjsoft.com>
References: <20050304175058.GA4042@blackham.com.au> <1110012298.6028.10.camel@DustPuppy.LNX.RO> <20050305100254.GH4042@blackham.com.au> <20050305175640.GL3485@openzaurus.ucw.cz> <20050305203533.GI4042@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20050305203533.GI4042-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Dumitru Ciobarcianu <swsusp-devel-P4rH+HwZiSk@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, suspend2-devel-g/J2nbn7YhmWn91e4EydUaxOck334EZe@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 06, 2005 at 04:35:33AM +0800, Bernard Blackham wrote:
> So, combining this patch with the previous kacpid NOFREEZE patch...
> Does this make people happy? :) (And should it be submitted via Len
> or akpm?)
> --=20
>  Bernard Blackham <bernard at blackham dot com dot au>

> --- linux-2.6.9-rc1/drivers/acpi/events/evgpe.c.orig	2005-03-06 04:29:40.=
000000000 +0800
> +++ linux-2.6.9-rc1/drivers/acpi/events/evgpe.c	2005-03-06 04:29:49.00000=
0000 +0800
> @@ -253,10 +253,6 @@
>  	ACPI_FUNCTION_TRACE ("ev_disable_gpe");
> =20
> =20
> -	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
> -		return_ACPI_STATUS (AE_OK);
> -	}
> -
>  	/* Make sure HW enable masks are updated */
> =20
>  	status =3D acpi_ev_update_gpe_enable_masks (gpe_event_info, ACPI_GPE_DI=
SABLE);

I'm looking into your patches in hopes to eliminate system freezes
related to ACPI and swsusp on my Thinkpad R40.

I can apply this patch to 2.6.11.1, but the previous PF_NOFREEZE patch
won't compile.  Would you mind providing a proper patch for 2.6.11.1
that makes all the changes you intend?

Thanks.
--=20
John M Flinchbaugh
john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCLIXACGPRljI8080RAllLAJ9uP/b9/M+qTxbUsiZ4tdvQBMV8mwCgiS4/
DEOBcS3yiBkdjr0lFe2ecRE=
=ic0B
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
