From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: ACPI + IO-APIC power off by button problems
Date: Sun, 2 Mar 2003 14:38:11 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476BFD3@cceexc19.americas.cpqcorp.net>
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
To: AnonimoVeneziano <voloterreno-nc/lrvXPQ4s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Email us the output from 'cat /proc/interrupts' and 'dmesg'.  It may
help to debug this issue.  It sounds like an IRQ problem to me.

Regards,
John
--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux

> -----Original Message-----
> From: AnonimoVeneziano [mailto:voloterreno-nc/lrvXPQ4s@public.gmane.org]=20
> Sent: Sunday, March 02, 2003 12:54 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] ACPI + IO-APIC power off by button problems
>=20
>=20
> Hi, I have this configuration:
>=20
> MSI KT4 Ultra MoBo
> Athlon XP 2400+
> Matrox G450
>=20
> and this problem: with kernel 2.4.20 and without ACPI patch installed=20
> and IO-APIC support activated the system does not shutdown=20
> properly, and=20
> it reboots instead of turn off and if I try to turn off the PC by=20
> pressing the power off button it does nothing, as if I've=20
> never pressed it
>=20
> Using instead the kernel 2.4.21-pre4 + lastest ACPI patch I've solved=20
> the power down issue , and now the system shutdown properly , but the=20
> button does not work again . Without IO-APIC the button works=20
> correctly.=20
> There are some incompatibilities between the PowerButton and=20
> the IO-APIC?
>=20
> I've noticed this problem in my old mobo too, an ASUS CUV4X-EA
>=20
> Thanks
>=20
> Bye


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
