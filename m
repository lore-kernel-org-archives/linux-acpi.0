From: Craig Bradney <cbradney-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>
Subject: Re: acpi problem with nforce motherboards and ethernet
Date: Fri, 06 Feb 2004 01:14:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076026496.16107.23.camel@athlonxp.bradney.info>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-j/uIsR0B7++NrV/pO4Q9"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040205154059.6649dd74.akpm-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>, david+challenge-response-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-j/uIsR0B7++NrV/pO4Q9
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-06 at 00:40, Andrew Morton wrote:
> Luis Miguel Garc=EDa <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org> wrote:
> >
> > David Ford wrote:
> >=20
> > > I have the same problem.  I "solved" it a while ago by mucking with=20
> > > the AGP stuff.  IIRC, it was turning off AGP fast writes or 8x or=20
> > > something similar in cmos.  Went from incredibly broken to stable=20
> > > instantly.  I'll check my cmos settings in a bit and refresh my memor=
y.
> > >
> > > What patches are you using?
> >=20
> >=20
> > I'm using nforce2-apic.patch and nforce2-disconnect-quirk.patch that=20
> > Andrew Morton have sent to me. I think they have been included in=20
> > previous mm kernels but now are droped because they caused some=20
> > temperature problems for some people with no nforce motherboards.
>=20
> Yes, the patch which disables "Halt Disconnect and Stop Grant Disconnect"
> apparently causes the CPU to run hot.
>=20
> > By the way, is anyone involved in solving the IO-APIC thing in nforce=20
> > motherboards? Anyone trying a different approach? Anyone contacting=20
> > nvidia about this problem?
>=20
> As far as I know, we're dead in the water on these problems.


One day hopefully this will be sorted in the BIOSes and in mainline. I
keep having to patch for every release (although as thats the only patch
I have to do I'm sure there are many worse off than me). I use the 3com
n/w on my A7N8X Deluxe v2 BIOS 1007 so no need for nforcedeth.

Best patches are at:
http://lkml.org/lkml/2003/12/21/7

Ive applied them to 2.6.0 and 2.6.1 and give no crashes and no heat
issues.

 (XP2600+ runs at 31/32C normal use and 38C compiling with Zalman cooler
+exhaust fans in box)

Craig

--=-j/uIsR0B7++NrV/pO4Q9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAItyAi+pIEYrr7mQRAtYqAJkBBBh3kFO8f/4EVW/8K0KKmnvqygCeKzZV
9MXxRAbDqattNkQIP/GH+Rc=
=2i6k
-----END PGP SIGNATURE-----

--=-j/uIsR0B7++NrV/pO4Q9--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
