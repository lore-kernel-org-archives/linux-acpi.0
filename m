From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Wed, 17 Mar 2004 10:53:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040317095314.GB14983@dominikbrodowski.de>
References: <16471.43776.178128.198317@wombat.chubb.wattle.id.au> <200403162340.57546.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200403162340.57546.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: Peter Chubb <peter-LkDQP0DxSMGxwJ88Py/mJxCuuivNXqWP@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, john stultz <johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2004 at 11:40:57PM -0500, Dmitry Torokhov wrote:
> On Tuesday 16 March 2004 08:33 pm, Peter Chubb wrote:
> > >>>>> "Dmitry" =3D=3D Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org> writes:
> >=20
> > Dmitry> On Tuesday 16 March 2004 07:13 pm, Karol Kozimor wrote:
> > >> Thus wrote john stultz: > Hmm. This is untested, but I think this
> > >> should do the trick.
> > >>=20
> > >> Hmm... without the patch, neither cpu MHz nor bogomips are updated,
> > >> with the patch cpu MHz value seems correct (both using acpi.ko and
> > >> speedstep-ich.ko, but the bogomips is still at its initial value.
> > >> Best regards,
> > >>=20
> >=20
> > Dmitry> Karol, do you have a P4? AFAIK P4's TSC is stable even if core
> > Dmitry> frequence changes so loop_per_juffy (=3D=3D bogomips) need not =
be
> > Dmitry> updated.
> >=20
> > The TSC is variable rate for Pentium-IV if you're using clock
> > modulation.
> >=20
> > Peter C
> >=20
>=20
> I understand that by clock modulation you mean throttling as opposed to
> true SpeedStep... OK, that means that for P4+ we somehow need to figure
> out whether the CPU is throttled or not to correctly calculate delays.
> Is there a clean way to get this data?

Hm, will have one patch to test it ready later today -- and a basic patch to
do this distinction is in the hiding of my notebook's harddisk already...
who's willing to do some testing on his SpeedStep-capable Pentium 4 - Mobil=
e.

	Dominik

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWCAKZ8MDCHJbN8YRAofzAKCBU1SRxVyq74ZD4CUChAe49FNKWwCfd+cM
7tbRdB/PnjbU03ruhRGy2G4=
=+BQ9
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
