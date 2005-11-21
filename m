From: Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
Subject: Re: Battery cycle count on IBM Thinkpads.
Date: Mon, 21 Nov 2005 09:56:56 +0100
Message-ID: <20051121085656.GB4117@susi>
References: <20051119230734.GA4117@susi> <20051120214624.GC2556@spitz.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051120214624.GC2556-/Rtfo+muvtdI+ieYp0uEEg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sun, 2005-11-20 at 21:46, Pavel Machek wrote:
>=20
> You may be able to talk to smartbattery directly (using i2c), and
> get that info... expect to do some programming...

I'm not sure if this is a smart battery. At the moment i get this
infos with normal battery modul form kernel:

stefan@fairlight:~$ cat /proc/acpi/battery/BAT0/info=20
present:                 yes
design capacity:         71280 mWh
last full capacity:      58540 mWh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 2927 mWh
design capacity low:     200 mWh
capacity granularity 1:  1 mWh
capacity granularity 2:  1 mWh
model number:            IBM-93P5003
serial number:            1645
battery type:            LION
OEM info:                SONY

I will test the smartbattery modul later. And if that di not help too,
i'll look deeper in source code.

regards
Stefan Schmidt

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDgYvYbNSsvd31FmURAjAxAJ9gHO6X2fXpcfo4Bb8OM2cNoSH9RgCfd1wq
EvTcSiWmhsyrQ/AxH5pjiAQ=
=VBgv
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
