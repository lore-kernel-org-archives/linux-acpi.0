From: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Subject: Re: [linux-usb-devel] PCI quirks not handled and config space
 differences on resume from S3
Date: Thu, 18 Aug 2005 11:34:27 +0200
Message-ID: <1124357667.12771.2.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0508161148570.18302-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xo5GigcqJYD6lrpw2eiU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.0508161148570.18302-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, USB development list <linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-xo5GigcqJYD6lrpw2eiU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-16 at 11:52 -0400, Alan Stern wrote:
> > > The uhci-hcd driver _does_ restore the config space for its devices=20
> > > properly.
> >=20
> > Apparently something is sort of wrong though, because I need to rmmod
> > uhci_hcd and hci_usb before suspending, otherwise nasty things happen.
>=20
> Can you be more specific?  Start with the kernel version you're using. =20
> What happens if you rmmod hci_usb and leave uhci_hcd alone?  What shows u=
p=20
> in dmesg?  What shows up if you set CONFIG_USB_DEBUG?

Hmm, it DOES seem to work with UHCI_HCD (in other words, it works if I
only have USB1.1 devices connected).

Then probably I've had problems with USB2.0 devices connected, so maybe
the EHCI_HCD driver is not suspend-safe? I will try that when at home.

--=-xo5GigcqJYD6lrpw2eiU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDBFYjJgD/6j32wUYRAgHGAJ4wB+zgIr2uJpx/MDzff5+rzGveHACeJ/4A
5Ym4uHYbF/aB/i2Eu34GB9g=
=GVh/
-----END PGP SIGNATURE-----

--=-xo5GigcqJYD6lrpw2eiU--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
