From: Marc-Christian Petersen <m.c.p-hi6Y0CQ0nG0@public.gmane.org>
Subject: AGAIN problems with newest ACPI patch :-((((((
Date: Sat, 27 Jul 2002 04:19:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207270418.54513.m.c.p@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi there,

again many troubles with your newest ACPI patch (20020726).

Unlike almost every second release the Network (NIC) are working, but if =
i do=20
a ping <IP> i get 1 reply and after that:

Jul 27 03:43:13 codeman kernel: eth0: Tx ring dump,  Tx queue 169 / 141:
Jul 27 03:43:13 codeman kernel: eth0:     0 200ca000.
Jul 27 03:43:13 codeman kernel: eth0:     1 000ca000.
Jul 27 03:43:13 codeman kernel: eth0:     2 000ca000.
Jul 27 03:43:13 codeman kernel: eth0:     3 000ca000.
Jul 27 03:43:13 codeman kernel: eth0:     4 000ca000.
Jul 27 03:43:13 codeman kernel: eth0:     5 000ca000.
Jul 27 03:43:13 codeman kernel: eth0:     6 000ca000.
Jul 27 03:43:13 codeman kernel: eth0:     7 000ca000.
Jul 27 03:43:13 codeman kernel: eth0:     8 600ca000.
Jul 27 03:43:13 codeman kernel: eth0:   =3D 9 000ca000.
=2E..
Jul 27 03:43:13 codeman kernel: eth0: Printing Rx ring (next to receive i=
nto=20
0, dirty index 0).
=2E..

and so on. Many more lines of the above. After that the network is=20
NON-functional.

And now the bad one: pon dsl-provider (ADSL connect, pppd, no kernel base=
d=20
PPPoE) and the system freezes!! Only hard reset will help.

This is with 2.4.18.

[*] ACPI Support
[ ] CPU Enumeration Only
<M>   AC Adapter
<M>   Battery
<M>   Button
<M>   Fan
<M>   Processor
<M>   Thermal Zone
[ ]   Debug Statements

I've also tried with Debug statements with no more debugging output.
Now I use again, like before updating the ACPI code, v20020611 with no=20
problems.

P.S.: Isn't it possible to make always a ~95% working code?! ;-))

System:
-------
- Celeron 800MHz
- 256MB RAM
- eepro100 internal network
- rtl8139 external network (adsl)
- Debian SID

--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
