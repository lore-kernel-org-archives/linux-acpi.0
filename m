From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Re: Acpi slows down my new Asus portable quite a lot
Date: Thu, 17 Jul 2003 13:55:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030717115521.GC652@enigma.daemon.sh>
References: <200307161834.02571.rmuehlhoff@wtal.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200307161834.02571.rmuehlhoff-52dn/g0OV9M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello rainer..

* "Rainer M." <rmuehlhoff-52dn/g0OV9M@public.gmane.org> [2003-07-17 07:50 +0200]:

> I'm using an ASUS MxN, acpi works fine after applying a modified DSDT to =
solve=20
> the 100%-cpu-load problem. But what still does not work is fan control an=
d=20
> speedstepping.=20
> When starting with AC-adaptor, the fan would toggle between off and full=
=20
> power. When starting with battery, the fan would never start running, (ev=
en=20
> when my computer's compiling) and cpu speed eventually gets throttled dow=
n=20
> (presumably by the cpu's internal overheat handlers) to 100MHz in the end=
=2E=20
>=20
> The second question of course would be whether someone has ideas how to s=
olve=20
> it. My DSDT can be found at acpi.sf.net, section ASUS M2400N (this fixed =
one,=20
> not the original one).=20

you might try using cpufreq (http://www.codemonkey.org.uk/cpufreq/) and
cpufreqd (http://cpufreqd.sf.net) to regulate the speed of your cpu (and
thus your fan).

hth,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Fo6preHfL3pi+bQRAsVUAJ9MhmBhiGuAdLWXLwRgPQhcUxJzCQCcCzFS
Ziw7cYYQSCbZUuQBXv+a7Qw=
=n/PQ
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
