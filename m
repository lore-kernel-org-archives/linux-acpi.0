From: Fred Thiele <ferdy_news-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Toshiba Satellite L10-101 Smart Battery System works with patched DSDT
Date: Wed, 19 Oct 2005 19:31:21 +0200
Message-ID: <20051019173121.GD27321@sleipnir.th0r.ath.cx>
References: <43567DFF.3080700@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43567DFF.3080700-l3A5Bk7waGM@public.gmane.org>
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


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> [2005-10-19 19:10:23 +0200]:

> Hi,
>=20
> I just want to add this one to the list of working Smart Battery Systems=
=20
> with the DSDT patch from https://sourceforge.net/projects/sbs-linux/.
>=20
> Are there still efforts for integrating something into the kernel to let=
=20
> those systems run out of box?

That would be really interesting. The problem is that the ec-nospinlock
patch in that project just works for kernels 2.6.10/11/12 but not for
the current 2.6.13 kernel. I already tried to adapt it but i need a lot
more knowledge of acpi/kernel hacking to achieve this.

To summarize it: The above patch lets you see your smart battery systems
but depending on what kernel you are using you will lose interrupts
which results in e.g. lost keypresses if the battery is read. If any of
the kernel hackers could drop a note what is planned to solve these
sbs-related issues it would make some people happy. The patch above is
written by Rich Townsend who seem not to continue his project.=20

--=20
Best regards,

Fred Thiele                    GnuPG-Key: 0x4F6BE238 <ferdy_news-Mmb7MZpHnFY@public.gmane.org>

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDVoLpEBTrFk9r4jgRAisMAJ9iYwpfdc7FOhRA+YJ1H3mP6sOXmACdHx4x
4jlYm5WWFO9XV3G0F9LDEFo=
=eG3K
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
