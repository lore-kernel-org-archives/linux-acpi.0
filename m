From: Bob McElrath <mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Subject: Re: laptop turns itself off
Date: Fri, 20 Sep 2002 11:36:00 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020920163600.GA31596@draal.physics.wisc.edu>
References: <E17Zvfr-000N02-00@f16.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E17Zvfr-000N02-00-Fua/sgysUDkox3rIn2DAYQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Huw H <hrhawk-JGs/UdohzUI@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Huw H [hrhawk-JGs/UdohzUI@public.gmane.org] wrote:
> I seem to have the same trouble, with my laptop turning itself off random=
ly
> without warning. I have a Toshiba Satellite 3000 (model PS302A-00Q5k) and=
 still
> use the former (20020517) patch against 2.4.18. In addition I have instal=
led
> Bruno's dsdt table for the 3000-601, which as far as I could tell has ide=
ntical
> specs (excepting a 1.13GHz max clock as opposed to 1GHz). I also use the =
tosh3k
> module to set the fan to keep the laptop at between 45-50C.
>=20
> Time to upgrade kernel and get someone to patch my dsdt propperly I guess.

I just noticed today that it is not actually hung...

It appears to be up but only processing a clock tick once every few
minutes.  If I hit the keyboard, several minutes later the screen will
unblank.  My CPU meter on screen *has* changed on the screen in the last
1/2 hour of watching it.  And the clock is currently 24 minutes slow.
(it should have been accurate at the time of the "hang") There are log
messages on the screen too in my logtail from immediately before the
hang:
    exresnte-0103 [12] Ex_resolve_note_to_val: No object attached to node c=
16bfd68
    acpi_battery-0195 [07] acpi_battery_get_statu: Error evaluating _BST

I have not seen the turn-off behavior in some time, using kernel
2.4.20-pre5 and acpi from august.  (I will try the latest one soon Andy)

Anyone have any idea what could cause this kind of behavior?

Cheers,
-- Bob

Bob McElrath (rsmcelrath-9geRo0GdX4mkVGS65fRQmodd74u8MsAO@public.gmane.org)=20
Univ. of Wisconsin at Madison, Department of Physics

    "The purpose of separation of church and state is to keep forever from
    these shores the ceaseless strife that has soaked the soil of Europe in
    blood for centuries." -- James Madison


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2LTnAACgkQjwioWRGe9K0AkQCgi2hoU+LhQQzYm0g8E7OvIaTr
cqAAoOu8RAXVioepdrrxs6sojB8FH5De
=tYYo
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
