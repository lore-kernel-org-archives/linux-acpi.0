From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: APIC not enabled on Opteron
Date: Fri, 22 Aug 2003 22:29:56 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCC4@hdsmsx402.hd.intel.com>
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
To: Michael Madore <mmadore-JChM1cqIHx8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Michael,
I don't see the log attachment.

In any case, 2.6-test3 is missing a couple of acpi interrupt changes
that are now in 2.4.22-rc2; and I'll be getting those changes ready for
2.6 shortly.

In the mean-time, if you want the APIC more than you want ACPI, you can
boot with acpi=3Doff for now and the legacy code will configure your
interrupts.

Cheers,
-Len

> -----Original Message-----
> From: Michael Madore [mailto:mmadore-JChM1cqIHx8AvxtiuMwx3w@public.gmane.org]=20
> Sent: Friday, August 22, 2003 7:31 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] APIC not enabled on Opteron
>=20
>=20
> Hi,
>=20
> I'm not postive if my problem is being caused by ACPI, but it=20
> seems to=20
> be involved, so I'm posting my questiong here first.  If this=20
> is not an=20
> ACPI issue just let me know.
>=20
> I have a single processor Operteron motherboard with the=20
> Nvidia nforce 3=20
> chipset.  I am running a 32-bit Linux kernel (2.4.6-test3) and things=20
> are perfectly stable.  The problem is that the system is running in=20
> XT-PIC mode even though I enabled Local APIC support.  Here is the=20
> contents of /proc/interrupts:
>=20
>             CPU0
>    0:      53477          XT-PIC  timer
>    1:        115          XT-PIC  i8042
>    2:          0          XT-PIC  cascade
>    8:          1          XT-PIC  rtc
>    9:          0          XT-PIC  acpi
>   12:         60          XT-PIC  i8042
>   14:      62385          XT-PIC  ide0
>   15:          1          XT-PIC  ide1
> NMI:          0
> LOC:      53266
> ERR:          0
>=20
> This may not look too crowded, but when drivers are loaded=20
> for all the=20
> onboard hardware there is a lot of sharing going on.  I also tried=20
> enabling the IO-APIC, which works, but I still only get 15 IRQs.
>=20
> The reason I think ACPI is involved is because of this kernel message:
>=20
> Using ACPI for processor (LAPIC) configuration information
>=20
> I have attached the full kernel log.  If anyone can give me a=20
> clue, I'd=20
> appreciate it.
>=20
> Thanks
>=20
> Mike
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: VM Ware
> With VMware you can run multiple operating systems on a=20
> single machine.
> WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
> at the same time. Free trial click=20
> here:http://www.vmware.com/wl/offer/358/0
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
