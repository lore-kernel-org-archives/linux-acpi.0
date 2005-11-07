From: Nir Tzachar <tzachar-7iDlm8ZLfO0Zqb/kyJCLuA@public.gmane.org>
Subject: ACPI and PRREMPT bug
Date: Mon, 07 Nov 2005 11:35:33 +0200
Message-ID: <1131356134.973.23.camel@nexus.cs.bgu.ac.il>
Reply-To: tzachar-7iDlm8ZLfO0Zqb/kyJCLuA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Hwwbufimd7AV4QYfRuJE"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-Hwwbufimd7AV4QYfRuJE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello.

I'm encountering a problem with acpi on kernels where preempt is
enabled.
The problem is 100% reproducible on all kernels starting from 2.6.12.1
to 2.6.14
( i didn't try 2.6.11 and below ).

the problem is manifested via the battery proc interface. to produce it,
run in two terminals simultaneously:=20
while true; do cat /proc/acpi/battery/BAT0/info; done

if i turn on kernel preemption (either voluntary or not), i get the
following error messages in dmesg:
Nov  7 08:31:00 lapnir ACPI-0292: *** Error: Looking up [SERN] in
namespace, AE_ALREADY_EXISTS
Nov  7 08:31:00 lapnir ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.GBIF] (Node c18f5d60), AE_ALREADY_EXISTS
Nov  7 08:31:02 lapnir ACPI-0213: *** Error: Method reached maximum
reentrancy limit (255)
Nov  7 08:31:02 lapnir ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f5c20), AE_AML_METHOD_LIMIT

and with acpi debugging info turned on:
Nov  7 08:46:08 lapnir dswload-0292: *** Error: Looking up [SERN] in
namespace, AE_ALREADY_EXISTS
Nov  7 08:46:08 lapnir psloop-0287 [4399] ps_parse_loop         : During
name lookup/catalog, AE_ALREADY_EXISTS
Nov  7 08:46:08 lapnir psparse-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.GBIF] (Node c18f94e8), AE_ALREADY_EXISTS
Nov  7 08:46:08 lapnir osl-0856 [4403] os_wait_semaphore     : Failed to
acquire semaphore[c18de5e0|1|0], AE_TIME
Nov  7 08:46:08 lapnir dsmethod-0213: *** Error: Method reached maximum
reentrancy limit (255)
Nov  7 08:46:08 lapnir psparse-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f9268), AE_AML_METHOD_LIMIT
Nov  7 08:46:08 lapnir acpi_battery-0144 [4449] battery_get_info      :
Error evaluating _BIF
Nov  7 08:46:08 lapnir dsmethod-0213: *** Error: Method reached maximum
reentrancy limit (255)
Nov  7 08:46:08 lapnir psparse-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f9268), AE_AML_METHOD_LIMIT


this is repeated until a reboot. loading and unloading the battery
module does not help.

My computer is a thinkpad t43p, and i didn't try to reproduce it on
another laptop
(have no access to another model..).
If you need more info, let me know.

p.s. please cc me, im not in the list.

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Nir Tzachar.

--=-Hwwbufimd7AV4QYfRuJE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDbx/lIHR+zI+Dam4RAtAaAJ93o7lRT7qq65o94IXHT1s+YSUdNQCgiu+b
CZIjx1ojl6pVSTYG55R3fSs=
=T3Xx
-----END PGP SIGNATURE-----

--=-Hwwbufimd7AV4QYfRuJE--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
