From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: acpi-cpufreq; Intel Johnstown (Atom N270)
Date: Thu, 13 Aug 2009 15:09:02 -0400
Message-ID: <20090813190902.GD9385@alittletooquiet.net>
References: <20090813172556.GB9385@alittletooquiet.net> <20090813182908.GC9385@alittletooquiet.net> <20090813190741.GA7808@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:43385 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbZHMTJC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2009 15:09:02 -0400
Content-Disposition: inline
In-Reply-To: <20090813190741.GA7808@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-acpi@vger.kernel.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 13, 2009 at 03:07:41PM -0400, Dave Jones wrote:
> On Thu, Aug 13, 2009 at 02:29:08PM -0400, Forest Bond wrote:
>  > Hi,
>  >=20
>  > On Thu, Aug 13, 2009 at 01:25:57PM -0400, Forest Bond wrote:
>  > > I'm using an Intel Johnstown board with an Atom N270 processor.  Per=
formance
>  > > seems to improve dramatically with acpi-cpufreq loaded.  This caught=
 me by
>  > > surprise.  I had assumed that without loading acpi-cpufreq the CPU w=
ould be
>  > > running at its maximum speed all the time.
>  >=20
>  > I ran some tests to get some numbers.  My findings indicate that before
>  > acpi-cpufreq is loaded the CPU is running at 800MHz even though /proc/=
cpuinfo
>  > indicates 1.6GHz.
>=20
> if no cpufreq modules have been loaded, the CPU will be running at whatev=
er
> p-state the BIOS programmed it to start up at. In your case for some reas=
on, that's
> the 'slow' speed.=20

Okay, that's what I figured.

Looks like there's some BIOS settings that may have an effect.  I'll play w=
ith
those.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFKhGTORO4fQQdv5AwRAuMgAJsH/fA4cPTpdlwDEPuLG04R3FbEQQCgsN2E
t4c6xj/hqKP6YYekYr+IwfU=
=vC0p
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
