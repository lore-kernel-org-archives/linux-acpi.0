From: mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: Re: [SOLVED] TM632 and S3. Network after wakeup. (kernel 2.6.10-rc3-mm1)
Date: Mon, 10 Jan 2005 12:34:14 +0100
Message-ID: <20050110113414.GB10315@icmza.sk>
References: <20041216091137.GB5605@alfa.intrak.sk> <200412162130.27395.stefandoesinger@gmx.at> <20050104185526.GA18862@icmza.sk> <20050107115538.0a1dcab3@orfeo.nikhef.nl> <20050107152947.GA12129@icmza.sk> <20050110111929.42927f9e@orfeo.nikhef.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050110111929.42927f9e-acHaiI0CM+haAVKTNDtesg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tim Dijkstra <tim-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi


Without this line in lilo.conf, resume will fail, (i think so).


append=3D"acpi_sleep=3Ds3_bios"



On Mon, Jan 10, 2005 at 11:19:29AM +0100, Tim Dijkstra wrote:
> On Fri, 7 Jan 2005 16:29:47 +0100
> mizu <michal-VaXaUECoPuY@public.gmane.org> wrote:
>=20
> > i did not test S4 yet.
> >=20
> > WHat kind of problem, do you have ?
> > What is the last message of your resume operation ?
>=20
> I don't know;) Suspend seems to do what it's supposed to. But on resume,
> I hear the disk spin up again, but then nothing. Nothing on the screen
> (it's still of I think), but also no network, keyboard doesn't work. I
> think it locks up.
> =20
> > my config is here as attachment.
>=20
> I haven't build a new kernel yet, but looked at your config. I
> spotted two obvious differences. For one I boot with a initrd, don't
> know if that's a problem. Second, you didn't include the pcmcia/pccard
> subsystem. Doesn't you're machine have any pccard slots? a

Actually, i don't have any pcmcia card, so i've removed this drivers from
my kernel.
Try to build your kernel and sleep without pcmcia code.

see you

		=09
			mizu



--=20
              mizu
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
[-> E-mail:michal_AT_zimen_DOT_sk   =20
[-> ICQ:97165392
[-> WWW: http://michal.zimen.sk
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB4mg29kFXwDL4DRkRAgNsAJwIIla/ZNCPYLjlL//1va0dcxt5gwCfQSwI
eejLbzVqvlGGoXDCEwGAeh8=
=7vt9
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
