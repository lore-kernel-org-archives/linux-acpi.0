From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: APIC, USB mouse and errors
Date: Fri, 28 Feb 2003 17:47:04 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E418@cceexc19.americas.cpqcorp.net>
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

Holger,

I think that your APIC IRQs (0..15) aren't getting programmed properly.

PCI is using IRQs 10, 11, 12 & 14, but I think the kernel has made an
incorrect assumption that these are ISA IRQs and set them to be
edge-triggered.  PCI IRQs are always level-triggered.

Take a look at arch/i386/kernel/mpparse.c in the
mp_config_acpi_legacy_irqs() routine.  It sets  interrupts 0..15 to ISA
bus conforming behavior (edge).

You might try forcing the kernel to do the right thing and see what
happens.

Regards,
John

> -----Original Message-----
> From: DPR [mailto:info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org]=20
> Sent: Friday, February 28, 2003 4:47 PM
> To: Cagle, John (ISS-Houston); acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] APIC, USB mouse and errors
>=20
>=20
> Here are the messages the ACPI/APIC system produces during=20
> the boot process. Perhaps this will provide the information=20
> you need to fix my problem :) I don't understand why there're=20
> no IRQs above 17 ! Windows maps the IRQs 18, 19, 21 and 23=20
> for my audio/IEEE 1394/USB and ethernet devices.
>=20
> Besides - the latest "20030228" version doesn't fix my=20
> problem. Same "APIC error on CPU0 40(40)" messages if I use=20
> the "noapic" parameter and "USB device not accepting new=20
> address" error if I don't use "noapic".
>=20
> Thanks for any answer in advance,
>=20
> HOLGER
>=20
> > What does 'cat /proc/interrupts' show when your running this
> > new kernel?
> >=20
> > Regards,
> > John
> > --------------------------------
> > John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
> > Principal Member Technical Staff
> >    Industry Standard Servers
> >     Hewlett-Packard Company
> >     http://www.hp.com/linux
>=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
