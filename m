From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Failed compile kernel with apci patch applied
Date: Mon, 27 Oct 2003 14:19:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031027131953.GB1934@enigma.daemon.sh>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC87C5@hdsmsx402.hd.intel.com> <1066907937.1880.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1066907937.1880.11.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

salut fred..

* Frederic Dernbach <fredatwork-GANU6spQydw@public.gmane.org> [2003-10-27 10:04 +0100]:
>=20
> I followed the steps you recommended.
>=20
> I restarted the whole process from scratch. I installed the 2.4.22
> baseline kernel source files as well as the 2.4.22 acpi patch
> (acpi-20031002-2.4.22.diff.gz).
>=20
> "make bzImage" went fine. "make modules" went fine I presume (I did not
> spot any error in the std output or std error that I kept).
>=20
> However "make modules_install" terminated with :
> depmod:*** Unresolved symbols in
> /lib/modules/2.4.22-22-acpi/kernel/crypto/autoload.o
> depmod:		crypto_alg_lookup
> depmod:*** Unresolved symbols in
> /lib/modules/2.4.22-22-acpi/kernel/crypto/proc.o
> depmod:		crypto_alg_sem
> depmod:		crypto_alg_list
>=20
> Is there anythting wrong that I dod ?=20

i suppose you did not do anything wrong. it looks like some relations in
your .config could not be resolved completely by the scripts. at least,
my builds of 2.4.22 did not show these errors. :)

> Can I continue installing the
> newly compiles kernel ? (I'm a newbee with linux kernel).

yes, usually it poses no problem if some modules unnecessary for your setup
are dysfunctional. but do not expect the crypto-system to work.

> For your information that my .config file include the option
> "Cryptographic API" in the "Cyptographic" options of the kernel config
> menu (I use "make menuconfig"). It is checked. Maybe it has something to
> do with.

looks like that. you can uncheck that option and the unresolved symbols
should disappear after a rebuild.

hth,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/nRt4reHfL3pi+bQRAsyPAJ0QoVbEyDmGVXGKHBRmW1mejMhf+gCgiN3g
+9vtEuRAxhyj/SP6OnxGzA8=
=wwqt
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
