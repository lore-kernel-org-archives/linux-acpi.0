From: Andreas Leppert <wudmx-S0/GAf8tV78@public.gmane.org>
Subject: Re: About DSDT fixing and debugging
Date: Thu, 23 Sep 2004 14:55:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040923125525.GA19982@laptop>
References: <I4HK00$27530FB661DF79A95160CDA9EDFBAE18@libero.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <I4HK00$27530FB661DF79A95160CDA9EDFBAE18-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gaetano Sferra <gaesferr-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

just want to say that these are exactly the same problems i have with my fu=
jitsu amilo D 7830!
no throttling (always C1 =3D 12%), no cooling (always 75=B0 C). i have alre=
ady disassembled with a few=20
errors, but couldn't fix it correctly.

Gaetano, when you'll have fixed it, could you send me your dsdt? this would=
 be very nice...=20

thanks for your great job
Andi Leppert



On Thu, Sep 23, 2004 at 10:38:24AM +0200, Gaetano Sferra wrote:
> Hello to all,
> I'm reading the ACPI specification to try to fix my DSDT (Amilo D 7830) t=
hat
> seems to be badly written
> because there are several errors while comiling it with IASL (statements =
in
> wrong place and poor control
> methods definitions) but I've some questions about the DSDT functionality=
 and
> debugging.
> a) Is there a debugger (something like gdb) or a sinulator to test the DS=
DT without
> patching the kernel and load it?
> b) Looking in the acpi log files (/proc/acpi) the cooling system reports =
<not
> supported>, the
> temperature stills on 75 C, and the processor state stills on C1 (12%). C=
an this
> condition be fixed
> throught the DSDT (eg. checking the _TZ notifies and the _AC methods)?
>=20
> Thanks to all for the support and the great work...
> ---
> Gaetano Sferra
>=20

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUse96EeWSkhF85cRAr1eAJ4tS5x+cSK17nZKNGDUzc2tkLtkEwCgi4xP
vjs7O9j51FzoiTH4Vh2kGbc=
=9NAb
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
