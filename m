From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: APIC, USB mouse and errors
Date: Thu, 27 Feb 2003 07:39:00 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476BF94@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

What does 'cat /proc/interrupts' show when your running this new kernel?

Regards,
John
--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux

> -----Original Message-----
> From: DPR [mailto:info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org]=20
> Sent: Thursday, February 27, 2003 7:14 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] APIC, USB mouse and errors
>=20
>=20
> Hi everybody,
>=20
> I've got the following problem with the latest=20
> "acpi-20030218" patch (for kernel
> 2.4.21-pre4-ac6) ...
>=20
> If I enable APIC then I get some "USB device not accepting=20
> new address" errors and my USB mouse doesn't work. If I use=20
> the "noapic" option then my mouse works fine but I get a=20
> bunch of "APIC error on CPU0 40(40)" messages. And finally if=20
> I use "disableapic" then I don't get these error messages but=20
> the mouse also doesn't work :(
>=20
> Any suggestions ???
>=20
> Many thanks in advance !!!
>=20
> --
>=20
> HOLGER
>=20
> motherboard	EPoX 8K5A2+ (VIA KT333, VT8235 southbridge, HPT372 RAID)
> mouse		Logitech Cordless MouseMan Optical
> kernel	2.4.21 pre4 ac6
> options	ACPI enabled, APIC enabled
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something=20
> 2 See! http://www.vasoftware.com=20
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> https://lists.sourceforge.net/lists/listinfo/a> cpi-devel
>=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
