From: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>
Subject: Re: [2.5.69] S3 does not come back / Sony Vaio C1MHP
Date: Tue, 27 May 2003 14:55:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030527125459.GA701@paradigm.rfc822.org>
References: <20030527101501.GB1247@paradigm.rfc822.org> <200305271929.43588.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200305271929.43588.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2003 at 07:29:41PM +0800, Michael Frank wrote:
>=20
> Common issue here is that many drivers have not been
> validated to resume properly.
>=20
> Please use S3 first without modules/drivers in single user
> console mode only. (boot with: single)

Done - Same behaviour - Even with init=3D/bin/sh booting
mounting proc and echoing s3 - Same ... Immediate suspend
- wakeup hangs.

> 2.5.70 - just out - seems to be better than 2.5.69, but
> it still causes problems with IDE on my machine (TM5600
> Tosh Libretto L2), msg follows.

2.5.70 does not boot for me - Some obscure unhandled IRQs coming up
which hangs the machine on boot.

Flo
--=20
Florian Lohoff                  flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org             +49-5201-669912
                        Heisenberg may have been here.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+02AjUaz2rXW+gJcRAj79AKDhlGZV1bwQwEHPtl8d8l9txiyH9QCgvO39
jFFnKddl11ywf1D9Y5YVVdc=
=lr1y
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
