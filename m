From: Russell Neches <russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org>
Subject: Re: power-off on boot
Date: Sat, 24 Jul 2004 22:23:06 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090722186.3596.6.camel@localhost>
References: <1090363093.6236.27.camel@joker.ccs.neu.edu>
	 <1090720651.3519.6.camel@localhost>
Reply-To: russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ujzf2xcXNdpAPPbpKaxV"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1090720651.3519.6.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-ujzf2xcXNdpAPPbpKaxV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

All right, I'm silly. Loading the Therman Zone module causes the system
to receive the (bogus) panic about the CPU being on fire. This time at
least, I have a log entry to show for my trouble:

Jul 24 22:10:43 localhost kernel: ACPI: Thermal Zone [THRM] (121 C)
Jul 24 22:10:43 localhost shutdown[3965]: shutting down for system halt

So, maybe it is a broken DSTD after all. Has anyone else had this
problem with an ABit K7V motherboard?

Russell

On Sat, 2004-07-24 at 21:57, Russell Neches wrote:
> Well, I seem to have found a work-around for this problem, but it raises
> another question. The work around was to build the ACPI extensions (AC
> Adapter, Battery, Button, Fan...) as modules. The culprit, I'm sure, was
> Thermal Zone.
>=20
> On my laptop, I have all of them built-in, and this problem doesn't
> occur. Do ACPI extensions always have to be built as a module? Is it not
> *supposed* to work at boot-time? The Debian boot-scripts seem to assume
> that they will be built as modules...
>=20
> Russell
>=20
> On Tue, 2004-07-20 at 18:38, Russell Y. Neches wrote:
> > Hey there --
> >=20
> > I have an "interesting" behavior with 2.6.6 and 2.6.7, and I was
> > wondering if this list would mind helping me figure out what's causing
> > it.=20
> >=20
> > Basically, my machine turns off while it's booting. It doesn't get far
> > enough to mount any filesystems, so there aren't any logs. On a hunch, =
I
> > turned on ACPI-debugging, and noticed that the kernel immediately begin=
s
> > spewing warnings about a critical trap (that's from memory, I can't be
> > completely sure if that's literally the string), and that the CPU is
> > over 120 degrees C. Now, I'm actually *underclocking* my CPU because I
> > have very bad luck with hardware, and I happen to know that the
> > temperature never goes above 38 degrees C (according to my BIOS and the
> > hardware meter glued to the heat sync).=20
> >=20
> > 2.6.5 doesn't seem to have this problem (USB-related oopses
> > notwithstanding), and Debian's 2.6.7-1-k7 kernel package boots without
> > issue (Debian's module insanity notwithstanding). So, I know there is a
> > solution to the problem somewhere, but without logs, I'm not sure how t=
o
> > even begin researching it.
> >=20
> > If it weren't for the fact that there are recent ACPI-enabled kernels
> > that work fine, I'd guess that my motherboard has a broken DSTD.=20
> >=20
> > Would anyone mind orienting me and pointing me in the right direction?=20
> >=20
> > Thanks!
> >=20
> > Russell
> >=20
> > PS - The list moderator hasn't approved a previous email with some
> > system information attached. So, instead of attaching it, I'll just lin=
k
> > to it:
> > =09
> > 	http://vort.org/downloads/spew.txt
> >=20
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by BEA Weblogic Workshop
> > FREE Java Enterprise J2EE developer tools!
> > Get your free copy of BEA WebLogic Workshop 8.1 today.
> > http://ads.osdn.com/?ad_id=3D4721&alloc_id=3D10040&op=3Dclick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=-ujzf2xcXNdpAPPbpKaxV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBAxmJHeAQ1TJNf5IRAuZ9AKDIwasNtqZpeoWYcVb2iQ+RhU97JQCgzpYv
zgjqK+k7qQodu4xkrAsd9Qw=
=a+N/
-----END PGP SIGNATURE-----

--=-ujzf2xcXNdpAPPbpKaxV--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
