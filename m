From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi with linux-2.4.22
Date: Fri, 26 Sep 2003 17:57:33 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EF2D@orsmsx401.jf.intel.com>
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
To: Michael Glickman <michg-pHk1y4uTXVCai2JIS6bsrQ@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Michael,

2.4.22 had some huge ACPI code changes. Everyone on acpi-devel is
working hard to resolve these. You will want to make sure you are using
the absolutely latest release, as your problem may have been fixed.

Regards -- Andy

> -----Original Message-----
> From: Michael Glickman [mailto:michg-pHk1y4uTXVCai2JIS6bsrQ@public.gmane.org]=20
> Sent: Friday, September 26, 2003 5:35 PM
> To: Grover, Andrew
> Subject: acpi with linux-2.4.22
>=20
>=20
> Hello Andrew and thank you for supporting Linux.
>=20
> Though ACPI drive is experimental, I've been using it with my=20
> Gigabyte=20
> GA-7IXE4 motherboard (AMD 750 chipset - sorry, but someone has to use=20
> AMD as well :) ) since 2.4.2 in hope I will be able to use it in the=20
> full extent one day. With upgrade from 2.4.18 to 2.4.22 it has become=20
> even worse than it was !
>=20
> I compile acpi drivers as modules. Version 2.4.18 has them named=20
> ospm_xxx.  ospm_button recognizes the buttons while loading,=20
> but looks=20
> like pressing Power/Sleep/Wake is not recorded.  =20
> /sbin/poweroff  works=20
> OK  - it turns off the computer (with ospm_system loaded).
>=20
> With 2.4.22 nothing appears to work at all. When I 'modprobe=20
> button' or=20
> any other acpi module, I get message "Device not found".=20
> /sbin/poweroff=20
>  doesn't turn the computer off either. I hear a "click" like=20
> the system=20
> is about to power off, but it doesn't !   It might be related=20
> to another=20
> activity goinmg on I am not sure.
>=20
>=20
> Awaiting your reply with impatience
> Michae;
>=20
>=20
>=20
>=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
