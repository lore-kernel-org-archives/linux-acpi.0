From: Fred Thiele <ferdy_news-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Toshiba Satellite L10-101 Smart Battery System works with patched DSDT
Date: Wed, 19 Oct 2005 20:51:49 +0200
Message-ID: <20051019185149.GA8943@sleipnir.th0r.ath.cx>
References: <43567DFF.3080700@suse.de> <20051019173121.GD27321@sleipnir.th0r.ath.cx> <200510192021.51029.o.jansen@orb-net.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200510192021.51029.o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Olaf Jansen-Olliges <o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org> [2005-10-19 20:21:50 +0200]:

> Hi Fred,=20
>=20
> > That would be really interesting. The problem is that the ec-nospinlock
> > patch in that project just works for kernels 2.6.10/11/12 but not for
> > the current 2.6.13 kernel. I already tried to adapt it but i need a lot
> > more knowledge of acpi/kernel hacking to achieve this.
>=20
> have you tried to boot you machine with the kernel parameter ec_burst=3D1=
=2E This=20
> works on my machine. Up to kernel 2.6.11 I've used Rich Townsends spinloc=
k=20
> patch. But afterwards i found a posting from Luming Yu in which he asked =
to=20
> try his patche which should solve this interrupt issue. And fortunately h=
is=20
> patches found the way to the kernel-sources :-)
> Perhaps you should have a look at /drivers/acpi/ec.c. If there is somethi=
ng=20
> like setup("ec_burst=3D ...  you may give this a try.

Ahh great. This is my log output:

Oct 19 20:39:40 sleipnir Kernel command line: root=3D/dev/hda7
resume=3D/dev/hda5 acpi_os_name=3D"Microsoft Windows XP" ec_burst=3D1 lapic
Oct 19 20:39:40 sleipnir ACPI: EC burst mode.

Can someone tell me what is the aim of the EC burst mode, what does it
do?

--=20
Best regards,

Fred Thiele                    GnuPG-Key: 0x4F6BE238 <ferdy_news-Mmb7MZpHnFY@public.gmane.org>

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDVpXFEBTrFk9r4jgRAojsAJ9rY+009zDIHHeNG6Pm6h2CA4G9MwCeOabz
nyg9e6k+SzDzRDLDWjgoHhI=
=UjKk
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
