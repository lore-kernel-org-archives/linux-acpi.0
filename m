From: Mattia Dongili <dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: vaio 505 (again)
Date: Tue, 15 Jul 2003 13:49:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030715114933.GC616@inferi.kami.home>
References: <1058266578.1077.16.camel@lana>
Reply-To: dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1058266578.1077.16.camel-c5SRAS+BrbU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2003 at 12:56:18PM +0200, Federico Di Gregorio wrote:
> hi,
>=20
[...]=20
> btw, what does that means? my ide interface works perfectly well, i am
> just curious:
>=20
>  pci_irq-0294 [23] acpi_pci_irq_derive   : Unable to derive IRQ for devic=
e 0000:00:1f.1
> ACPI: No IRQ known for interrupt pin A of device 0000:00:1f.1 - using IRQ=
 255
>=20
> 0000:00:1f.1 is:
>=20
> 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)

Well, somebody correct me if I'm wrong: this simply means that your ide
(as mine :) isn't listed within the _PRT methods of your DSDT and the acpi
subsystem falls back to a default irq routing.

I hope this is not too far for truth :P
--=20
mattia
:wq!

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/E+pNgpRPaOotLEERAq+rAKDfgqAwV4UcHCWy9X49Z3Ch6J4m8QCguFlE
WrxnyQDcQn/8/I0IWeWgq/E=
=kpvv
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
