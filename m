From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fan control on Sony Vaio PCG-NVR23
Date: Tue, 3 Feb 2004 16:01:54 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB66F@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marco Bertola <bertola-fC0AHe2n+mcHBZzjifzFer/b/tBG6AW9@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>  under linux the fan is whirring constantly (very annoying).
>  After trying around I found a useful bug.
>=20
>  echo 5 > /proc/acpi/sleep
>=20
>  This normally should turn off the machine but instead it >=20
> seems as if puts
>  the cpu in some "cooler" mode, the temperature drops to 56-57
>  and the fan
>  turns off (and back on when temp goes up). The computer=20
> becomes really
>  quiet (even more than in windoze!)
>  No appreciable performance loss (it is not a throttling=20
> state change).

To bad, Sleep 5 was intended  for Soft Power Off.

>=20
>  In other words ACPI seems to be doing what it is supposed to do
>=20
>  This happens ONLY with kernel 2.4.21-0.13mdk (out-of-the box
>  Mandrake 9.1)
>               ^^^^

Please send us with disassembly DSDT to verify what's the expected
behaviour ?

>  there are drawbacks: firewire (raw1394)
>   port is broken with acpi, I have to reboot
>  with acpi=3Doff if I want to use it (DV input), the mike (yes! the
>  microphone!) does not work with acpi, occasionally it hangs (VERY
>  rarely, basically only if I play bzflag (?!): but now I have
>  ext3 and recovery is as long as a normal reboot. Not too bad!)
>=20
>  I have tried compiling other kernels (2.4.22, 2.6.0, 2.6.1, you name
>  it, with or without APM (which may conflict))
>  I have tried Fedora (2.4.22-1.2115.nptl)
>  No avail.
>=20

This sounds like another bug!


>  Note that in all these other kernels the acpi support IS
>  present, I can
>  check the temperature -which NEVER drops below 68, hence the fan not
>  stopping, I guess- (the directory /proc/acpi is identical as far as I
>  can see)

This is bug  --- NEVER drops below 68!.

Luming


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
