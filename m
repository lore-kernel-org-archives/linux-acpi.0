From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: AE_NOT_ACQUIRED, ACPI: Unable to start the ACPI Interpreter
Date: Fri, 26 Mar 2004 16:24:24 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE055201D8C@orsmsx403.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Marc-Christian Petersen <m.c.p-dPKWvz6skTq4xZncNx1fdg@public.gmane.org>, 15444-hqaBeiJFMhqzQB+pC5nmwQ@public.gmane.org, gigerstyle-OI3hZJvNYWs@public.gmane.org, trond.myklebust-41N18TsMXrtuMpJDpNschA@public.gmane.org
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Rik van Ballegooijen <sleightofmind-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


This error has to come from inside this call:

    Status =3D AcpiOsInstallInterruptHandler ((UINT32)
AcpiGbl_FADT->SciInt,
                        AcpiEvSciXruptHandler,
AcpiGbl_GpeXruptListHead);



-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Brown, Len
Sent: Friday, March 26, 2004 4:20 PM
To: Marc-Christian Petersen; 15444-hqaBeiJFMhqzQB+pC5nmwQ@public.gmane.org; gigerstyle@gmx.ch;
trond.myklebust-41N18TsMXrtuMpJDpNschA@public.gmane.org
Cc: Marcel Holtmann; lkml; Andrew Morton; Linus Torvalds; Rik van
Ballegooijen; ACPI Developers
Subject: [ACPI] AE_NOT_ACQUIRED, ACPI: Unable to start the ACPI
Interpreter

On Fri, 2004-03-26 at 00:26, Len Brown wrote:
> > > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)
> >=20
> > > ACPI: SCI (IRQ22) allocation failed
> > >  ACPI-0133: *** Error: Unable to install System Control Interrupt
> > Handler, AE_NOT_ACQUIRED
> > > ACPI: Unable to start the ACPI Interpreter

If you encounter this issue on your hardware, can you help me fix it by
testing the latest patch at the URL below?  Either attach your dmesg and
/proc/interrupts to the bug report or send it to me, and let me know if
your power button works?

thanks,
-Len

> > http://bugzilla.kernel.org/show_bug.cgi?id=3D2366




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
