From: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Subject: REPORT: 2.6.0-test2 + last acpi patch on vaio 505ap
Date: 31 Jul 2003 15:33:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1059658394.1068.26.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-k8WC8yVl5fYYp9BP2Bc1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


--=-k8WC8yVl5fYYp9BP2Bc1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hi *,

as requested on this ML i patched and 2.6.0-test2 and tested it on my
sony vaio pcg-v505ap. since now (8h uptime and a couple of reboots)
everything works well.

i just noticed a couple of problems with cpufreq scaling. if i start the
laptop with ac on and then switch it off, everything goes well (the data
in /sys/... does not change when i disconnect ac but maybe i am supposed
to switch governor manually, i don't know. cpu freq chnages anyway, as
shown by /proc/cpuinfo.) but if i start with ac switched off, i get the
following error:

Jul 31 13:04:19 localhost kernel: cpufreq: CPU0 - ACPI performance manageme=
nt activated.
Jul 31 13:04:19 localhost kernel: cpufreq: *P0: 2000 MHz, 32000 mW, 250 uS
Jul 31 13:04:19 localhost kernel: cpufreq:  P1: 1200 MHz, 20200 mW, 250 uS
Jul 31 13:04:19 localhost kernel: acpi_processor_perf-0254 [47] acpi_proces=
sor_set_per: Platform limit (P1) overrides target state (P0)
Jul 31 13:04:19 localhost kernel: acpi_processor_perf-0254 [46] acpi_proces=
sor_set_per: Platform limit (P1) overrides target state (P0)
Jul 31 13:04:19 localhost kernel: acpi_processor_perf-0702 [45] acpi_cpufre=
q_init     : Disabled P-States due to failure while switching.
Jul 31 13:04:19 localhost kernel: cpufreq: No CPUs supporting ACPI performa=
nce management found.

as long as i can say everything else works pretty much like 2.5.x with
last patch.

greetings,

--=20
Federico Di Gregorio
Debian GNU/Linux Developer                                fog-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
INIT.D Developer                                           fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org
                  Beh un bacio, se ben dato, non si rifiuta. --  <laura>

--=-k8WC8yVl5fYYp9BP2Bc1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Questa parte del messaggio =?ISO-8859-1?Q?=E8?= firmata

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/KRqavcCgrgZGjesRAkH0AJ0aqL/ZT+bbxZiiufId5V40ydC74gCfZPDh
bxWdXlOu2X78p9xDqbgSyJ4=
=h+MI
-----END PGP SIGNATURE-----

--=-k8WC8yVl5fYYp9BP2Bc1--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
