From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: clear/enable power button on resume
Date: Mon, 08 Mar 2004 00:27:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078702077.541.29.camel@sunshine>
References: <1078685555.541.9.camel@sunshine> <404B7A1B.80006@pca.it>
	 <1078689765.541.20.camel@sunshine>  <20040307224318.GA1551@ergo.gotdns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mgLkkV5V50mwZ0quax/Q"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040307224318.GA1551-nlVyBo/8EO9N0TnZuCh8vA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-mgLkkV5V50mwZ0quax/Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-03-07 at 23:43, Sebastian Seifert wrote:
> The ACPI spec says that the pressing of a button (e.g. the power button)
> that leads to a wake event is reported differently to the OS. The Notify
> value (second column in output of /proc/acpi/event) of a regular button e=
vent=20
> is 0x80, that of a wake event is 0x02. Nevertheless, on my system, 0x80
> is generated for a power button wake. Strange.

Yes. Same here.

[root-eqrHSpLoP5M@public.gmane.org:~]$ cat
acpid.log_2.6.4-rc1-mm2                                                    =
                                                            (0:23)
Linux 2.6.4-rc1-mm4
[Sun Mar  7 19:19:40 2004] 1 client rule loaded
[Sun Mar  7 19:19:50 2004] received event "button/power PWRF 00000080
00000006"
[Sun Mar  7 19:19:50 2004] notifying client 525[1000:1000]
[Sun Mar  7 19:19:50 2004] completed event "button/power PWRF 00000080
00000006"


  Timo

--=-mgLkkV5V50mwZ0quax/Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAS6/84D8IS7MFQGYRApz6AJ9FxDqGaofWUqdcgb5JvVgmqDbjVgCfa1GD
qRURv0KJkPHji0A/NXVy/AM=
=EoSJ
-----END PGP SIGNATURE-----

--=-mgLkkV5V50mwZ0quax/Q--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
