From: tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org (Tomasz Ciolek)
Subject: Re: ACPI does''t work on my Pundit asus !
Date: Mon, 22 Mar 2004 07:23:44 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040321202344.GA1690@dreamcraft.com.au>
References: <NEBBJBIJELCOLFMEMIIIIEJPFBAA.jlacvdr@ifrance.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <NEBBJBIJELCOLFMEMIIIIEJPFBAA.jlacvdr-6bugY6I12JBBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: JLac <jlacvdr-6bugY6I12JBBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

 Did you install the acpid daemon that monitors the events and invokes
 the right scripts?

 TMC

On Sun, Mar 21, 2004 at 09:03:05PM +0100, JLac wrote:
> Hello,
>=20
> I would like shuting down my computer when I press the power button (thro=
ugh
> the shutdown script).
> I install the acpi but nothing happens when I press the button
>=20
> I read different web page about it, and the how-to, but it's not enough f=
or
> my problem...
>=20
> My configuration is :
> Hardware :
> 	Asus Pundit (http://www.asus.com/products/desktop/pundit/overview.htm)
>=20
> Software :
> 	Linux distrib. Debian with kernel source 2.4.24
> 	Patch ACPI : acpi-20040311-2.4.24
>=20
> I compile and install the kernel with this configuration :
> 	in General Setup
> 	 [*] Power Management support
> 	 < > APM
> 	 [*] ACPI Support
> 	   <M> Button
>=20
>=20
> In fact, I can see the directory /proc/acpi
> and after loading the button module, a new directory /proc/acpi/button an=
d a
> sub-directory power
> I execute a 'cat /proc/acpi/event' nothing is displayed when I press the
> power button.
>=20
> I also try with the acpid daemon but it doesn't work neither. (and also w=
ith
> 2.4.25 kernel)
>=20
> What is my mistake ?
> What have I forgotten ?
>=20
> Thanks,
>=20
> Best Regards,
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=20
Tomasz M. Ciolek=09
***************************************************************************=
****
 tmc at dreamcraft dot com dot au or tmc at goldweb dot com dot au =09
***************************************************************************=
****
	GPG Key ID: 0x41C4C2F0  Key available on www.pgp.net=09
***************************************************************************=
****
  Everything falls under the law of change;=09
  Like a dream, a phantom, a bubble, a shadow,
  like dew of flash of lightning.
  You should contemplate like this.=20

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAXfnQOh0OrUHEwvARArOCAKDQs6KvI/37lvDzZBmphMeJYb83rACeNZyL
YNoXpnwiGqnIlbZkyKI4exM=
=mJpu
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
