From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI on Thinkpad T30
Date: Wed, 16 Apr 2003 15:40:58 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84272292@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: tom-GJzCDJVA6d1BDgjK7y7TUQ@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Your dmesg output doesn't provide any clue to root cause of your issue.
Can you turn on debug option of ACPI, and collect debug message of
1). boot time=20
2)  time when you are doing "fn+f3", or "fn+f4", or echo 5 > =
/proc/acpi/sleep

/proc/acpi/dsdt is also needed.

Thanks,
Luming

-----Original Message-----
From: Thomas Estaben [mailto:tom-GJzCDJVA6d1BDgjK7y7TUQ@public.gmane.org]
Sent: 2003?4?2? 18:52
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Subject: [ACPI] ACPI on Thinkpad T30


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello All,

A new bios for the T30 is available since yesterday. After upgrading the =

embedded controller to 1.03 version and the bios to 2.03 version, i =
tried the=20
last acpi patch available for the linux-2.4.21pre6 kernel.
Then, i had the problem described on :
http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D104852990617578&w=3D2
I applied the solution (modifying ec.c), and now i haven't any error.
All /proc/acpi sections seems present.
But now, the combination fn+f3, or fn+f4 doesn't work,
echo [0 or 1 or 3 or 4] > /proc/acpi/sleep does nothing.
and echo 5 > /proc/acpi/sleep reboot the machine.
I didn't succeed in trying to put the machine in a suspend mode..
Is my problem normal ?
I attache my dmesg output for more information.

Thanks in advance for the help.

Thomas Estaben
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+isDGPuLPd42GGIIRAu/sAKCWCzaRwbryoP7hPwP8CR5ZEkXt3ACfffOJ
mAp6IYoTnBKNqFUl8nGjohA=3D
=3Dslwu
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
