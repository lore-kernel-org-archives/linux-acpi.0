From: "./SuperbepS" <superbeps-ceJDNWc+7SM@public.gmane.org>
Subject: wrong battery info
Date: Sat, 3 Aug 2002 10:48:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208031048.29073.superbeps@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I just upgraded mi kernel (2.4.18) with the latest acpi patch (20020725).=
 This=20
version lets me to read /proc/acpi/battery/BAT1/info without blocking the=
=20
keyboard, but introduces a new problem: the informations about battery=20
capacity are wrong. This version tells me that my battery has:
design capacity:         5 mWh
last full capacity:      5 mWh
The older versions and the state (when the battery is fully charged) file=
 tell=20
me that my battery has:
design capacity:=0944400 mWh
last full capacity:=0944400 mWh

- --=20
Ciao ???
___________________________________________________________
Riker: "I say we turn him over to them."
Q: "Oh, well, I take it back. You do have a sense of humor, a dreadful on=
e at
that."
Riker: "I'm serious."
- -- "Deja Q", Stardate 43539.1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9S5jc62upIGwAieoRAiHlAKC0bwYPbHjZw+CS+n33kTgFhM76HACfYbQm
vduqxq1muxOxPofbIfnCi8U=3D
=3DDHcz
-----END PGP SIGNATURE-----



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
