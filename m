From: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: 19 Sep 2002 15:51:44 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032443504.6326.20.camel@momo>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
	<1032428873.6326.5.camel@momo>
	<20020919144450.T10583@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7IrkwCDhlC3eQXN2gcVG"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020919144450.T10583-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-7IrkwCDhlC3eQXN2gcVG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Il gio, 2002-09-19 alle 15:44, Matthew Wilcox ha scritto:
> On Thu, Sep 19, 2002 at 11:47:53AM +0200, Federico Di Gregorio wrote:
> > everything seems to work fine. how can i say if an interrupt has been
> > wrongly assigned? anyway the only problem has always been there but i
> > don't know if it is about irq:
>=20
> So the problem exists in both the vanilla Marcelo kernel and in the
> ACPI-patched kernel?  That doesn't seem like a reason to exclude the
> ACPI patch from going in.

acpi kernel is much better than marcelo's. i get a lot of errors on it.

> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> > pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1f.03 not
> > present in PCI namespace
> > pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1f.06 not
> > present in PCI namespace
>=20
> Interesting ... could you send the output from /sbin/lspci -s 00: I
> suspect a bug in your machine's _PRT -- it's describing routing for a
> device which doesn't exist.  Maybe we should silently ignore that.
>=20
> > ACPI: Power Resource [PFAN] (off)
> >=20
> > and later:
> >=20
> > acpi_processor-2115 [07] acpi_processor_get_inf: Invalid PBLK length [5=
]
[snip]
> so you're one element short, and that element is what tells us the addres=
s
> to call to enter C3.  Clearly this is a broken BIOS, but I wonder if we
> couldn't hande this more cleanly ...

thank you very much for explaining exactly what's happening here. i am
sending you my dsts and lspci info in a separate private mail to not
disturb the ML.

--=20
Federico Di Gregorio
Debian GNU/Linux Developer & Italian Press Contact        fog-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
INIT.D Developer                                           fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org
                           Don't dream it. Be it. -- Dr. Frank'n'further

--=-7IrkwCDhlC3eQXN2gcVG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9idZwvcCgrgZGjesRAtsKAJ98V1EWrx5vsdTJ0BpkBgLQ5XfegACfScCe
5WSRtwKanxMnADKPE0FfOM0=
=uEhE
-----END PGP SIGNATURE-----

--=-7IrkwCDhlC3eQXN2gcVG--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
