From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: FW: Help with suspend / hybernate
Date: Tue, 1 Jul 2003 15:01:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030701130156.GD873@enigma.daemon.sh>
References: <F760B14C9561B941B89469F59BA3A847E96FE2@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96FE2-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: fredi-X9IQk7V7lNg1GQ1Ptb7lUw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello frederik

* "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [2003-07-01 09:15 +0200]:

> Tryed with ACPI (latest 2.4 patch included in 2.4.21-pre[12]) , the BIOS
>=20
> passes the blacklist check just fine. With acpi I get the battery time
> left,=20
> events so I can poweroff with lkaptop's power key and the two termal=20
> controlls. Now, reading /proc/acpi/sleep I get this modes:
> S0 S3 S4 S5
> But trying with echo <n> > sleep I can only poweroff with S5. The other
> values=20
> for sleep do nothing, tried with debug enabled too and nothing in the
> logs. So=20
> I can not get the=20
> laptop in sleep or hybernate.

S3 and S4 are not supported in ACPI for 2.4.x (S0 is running and S5 is
soft-off).


> As It seems that this laptop's ACPI/BIOS is good, is there any chance to
> get=20
> sleep=20
> / hybernate with ACPI on this laptop? This will be the best option if=20
> possible. And yes, I accept patches for this and I'll gladly try them
=20
try swsusp for hibernation:
http://swsusp.sf.net and http://sf.net/projects/swsusp

hth,
 sebastian

--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/AYZEreHfL3pi+bQRAvo2AJ9m5JMedQeu//RZOK2S4H3/vQJSKwCfUGhe
M+W4vz9hr07YK7CGt5eej3Q=
=Az9G
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
