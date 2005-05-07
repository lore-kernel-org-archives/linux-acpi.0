From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Sat, 7 May 2005 16:44:17 +0200
Message-ID: <20050507144417.GA3100@isilmar.linta.de>
References: <427CC869.1050506@kernelconcepts.de> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <1115475297.10424.4.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <427CC869.1050506-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org> <427CC9B3.7060005-hi6Y0CQ0nG0@public.gmane.org> <1115475297.10424.4.camel@localhost>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hendrik =?iso-8859-1?Q?J=FCrgens?= <hjuerg-ULHALamj7Vx/+Jgy1241yg@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 07, 2005 at 04:14:56PM +0200, Hendrik J=FCrgens wrote:
> Am Samstag, den 07.05.2005, 15:59 +0200 schrieb Carl-Daniel Hailfinger:
> > Hi,
> >=20
> > Nils Faerber schrieb:
> > > I just observed a strange phenomenon on my new T42p (latest BIOS).
> > > [...]
> > > Before suspend I usually see a power consumption of about 16W includi=
ng
> > > WLAN, which is nicely low.
> > > But strangely after resume from either S3 or S4 I have see a power
> > > consumption of 19W+. This means ~3W more or in other words, roughly 2=
0%
> > > less runtime.
> >=20
> > I didn't measure the power consumption of my Samsung P35, but after
> > resume from S3 it gets hotter under the same load than before suspend.
> > So I can somewhat confirm your report.
> >=20
> I can also confirm this behaviour with my acer tm4002lmi. it also has ja
> power consumption ~16W and after resuming it has round about 20W.

On a P35, a friend of mine determined that suspend to mem leads to a higher
power consumption if X was running. But only when using the ATI driver. When
using the vesa driver, the power consumption is increased to a higher rate=
=20
all the time...

Other than the video driver, you can check whether PCI devices changed their
status (they shouldn't) by doing "lspci -vvv > lspci_before.txt" before
suspend, "lspci -vvv > lspci_after.txt" after suspend, and checking=20
"diff -u lspci_before.txt lspci_after.txt".

Also, does the bus master activity rates typically seen (check=20
/proc/acpi/processor/*/power every once in a while) differ
between pre-suspend and post-suspend?

	Dominik

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCfNRBPB5F+WW+qdIRAiYBAKCyb62hB1A42gAC2mRFPLnH3P7JEwCeO7kj
c1JohSmrEMp/FcdjFvaxIUE=
=sN+r
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
