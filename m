From: Ethan Glasser-Camp <glasse-IL7dBOYR4Vg@public.gmane.org>
Subject: Re: Re: Oops during startup
Date: Wed, 2 Jun 2004 00:29:17 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040602042917.GA609@paladin>
References: <3ACA40606221794F80A5670F0AF15F840483B1C4@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840483B1C4-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2004 at 11:17:57AM +0800, Yu, Luming wrote:
>  Please try kernel option: acpi_sci=3D{ level | edge | high | low }
>=20
> --Luming

None of the above resulted in any differences.

Yi Zhu wrote:
> But firstly could you provide whatever be seen to give us a clue?

Here is my reproduction of the oops, as well as I could do it:

   EIP is at acpi_os_read_memory+0x0c/0x60
eax: c0428120  ebx: c13d6b7c  ecx: 00000008  edx: c1233f38
esi: c13d6b94  edi: c1233f38  ebp: 00000008  esp: c1233edc
ds: 007b  es: 0007b  ss: 0068
  Process events/0 (pid:3, threadinfo=3Dc1232000  task=3Dc123cc10)
Stack: 00001a66 c0246116 c0428120 c04280c0 c1233f38 00000008 c13d6b7c c1233=
f38
       00000282 c1233f3c c13c72bc 00000282 00000002 c03c18d0 c03c1520 c025e=
dc8
       00000008 c1233f38 c13d6b94 c1233f68 c13c72bc c1232000 00000283 00000=
000

Call trace:
 [<c0246116>] acpi_hw_low_level_read+0x6e/0x124
 [<c025edc8>] acpi_ec_gpe_query+0x128/0x220
 [<c023019d>] acpi_os_execute_deferred+0x5d/0x80
 [<c0230140>] acpi_os_execute_deferred+0x0/0x80
 [<c0130604>] worker_thread+0x298/0x3dc
 [<c013036c>] worker_thread+0x0/0x3dc
 [<c0230140>] acpi_os_execute_deferred+0x0/0x80
 [<c011913c>] default_wake_function+0x0/0x1c
 [<c011913c>] default_wake_function+0x0/0x1c
 [<c013519c>] kthread+0x70/0xa0
 [<c013512c>] kthread+0x0/0xa0
 [<c0103245>] kernel_thread_helper+0x5/0xc

Code: 8a 80 00 00 00 c0 88 02 eb 26 0f b7 80 00 00 00 c0 66 89 02
<6>note: events/0[3] exited with preempt-count 1

Ethan Glasser-Camp

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQFAvVedJATS9vswN4oRAiKzAJwJWhpFuQsYJw0yRKRB9A6G6ocBFACghJHZ
0IN7p3e2j5/v7g2ciEXOAdk=
=BjCw
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
