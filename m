From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ASL help with latest acpi and compaq presario 2800t
Date: Mon, 28 Apr 2003 17:29:30 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F842722C5@pdsmsx403.ccr.corp.intel.com>
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
To: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have made a patch for fixing compiling time error of =
http://www.scrye.com/~kevin/dsdt.dsl-20030409
Would you please apply it and see what's unusual and send boot log to =
me.

42,51d41
< {
<=20
< External (C1AF)
< External (C1BA)
< External (C1BB)
< External (C1B0)
< External (C1B1)
< External (C1B2)
< External (C1B3)
<=20
52a43
> {
177,178c168,169
<                 If(\_OSI("Windows 2001"))=20
< 		{
---
>                 If(\_OSI) {
>                     "Windows 2001"
2297c2288
<                 Name(_HID, "SYN0100")
---
>                 Name(_HID, "*SYN0100")


Thanks,
Luming


-----Original Message-----
From: Kevin Fenzi [mailto:kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org]
Sent: 2003?4?10? 1:30
To: Yu, Luming
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] ASL help with latest acpi and compaq presario 2800t


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Luming" =3D=3D Luming Yu <Yu> writes:

Luming> Is dsdt.asl modified version. I compiled it, and my error
Luming> message is slightly different with yours.  Would you please
Luming> send the original dsdt.asl to me?

You can get the dsdt.dat and dsdt.dsl from:=20

http://www.scrye.com/~kevin/dsdt.dat-20030409
http://www.scrye.com/~kevin/dsdt.dsl-20030409

Those are from my laptop today using the iasl-20030228

Let me know if you need any more info.=20

Luming> Thanks, Luming

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 =
<http://mailcrypt.sourceforge.net/>

iD8DBQE+lFil3imCezTjY0ERAiNVAJ0RbLT1+K532UBaz31tLeIODB6tAwCdF/OF
37iSC0J5jiZDJiEmC8G3QT8=3D
=3D5jP8
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
