From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: [Fwd: [ACPI] How to control IRQ polarities on PCI devices?]
Date: 26 Jul 2003 18:45:11 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1059241512.1585.16.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi
I think this questions in not only ACPI related, and should be asked in
kernel mailing list so...

-----Forwarded Message-----
>=20
> Hi, I've just tested what Windows XP programs my IO-APIC to with my w=
avelan=20
> card (using Softice to interrogate the IO-APIC by hand :)
>=20
> It turns out that with my latest patch, I am programming the IO-APIC =
the same=20
> way it is set up under windows.
>=20
> Thing is, the IO-APIC is set up to active high, level trigger. This i=
s how it=20
> is setup under windows as well (the device works under windows).
>=20
> I'm assuming the device is by default expecting PCI standard IRQs whi=
ch are=20
> active LOW, level polarity... which is why I either get no IRQs, or l=
ots of=20
> rubbish ones.
>=20
> Is there a standard way of controlling the polarity of IRQs generated=
 by PCI=20
> devices? This looks like the last issue to be resolved under linux.
>=20
>=20
Please CC me=20
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.
