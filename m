From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: mpparse.c APIC/ACPI support
Date: Sat, 1 Mar 2003 21:29:57 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E41A@cceexc19.americas.cpqcorp.net>
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
Cc: mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm glad you got your system working with ACPI again.  Regarding
Windows, I've heard that it may|will remap just about everything to its
liking, so it doesn't surprise me that it's different.

I'm not an expert on APICs, but it seems that the
mp_config_acpi_legacy_irqs() routine shouldn't blindly set IRQs 0..15 to
ISA conforming mode (edge triggered).  I know for a fact that many
systems will have PCI devices using/sharing these IRQs, which will
require the IRQ to be level-triggered.

Perhaps Paul, Ingo or Alan could comment?

Thanks,
John

--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux

> -----Original Message-----
> From: DPR [mailto:info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org]=20
> Sent: Friday, February 28, 2003 8:46 PM
> To: Cagle, John (ISS-Houston); acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] APIC, USB mouse and errors
>=20
>=20
> Hi John,
>=20
> YOU GOT IT - GREAT JOB !!!
> I made an ugly but working hack in=20
> "mp_config_acpi_legacy_irqs" - I simply forced the trigger=20
> mode to "level" for my USB-IRQs. And now everything works=20
> fine !!! If you find another way to fix it - let me know ;)
>=20
> Besides, do you know why the high IRQs (>17) are not used at=20
> all ? I'm just wondering why M$ Windows produces such a=20
> different IRQ-mapping - take a look at the attached file=20
> (IRQs 0,1,4,6,8,9,13,15-19,21,23 are used).
>=20
> Thanks for your professional help,
>=20
> HOLGER
>=20
>=20
> > Holger,
> >=20
> > I think that your APIC IRQs (0..15) aren't getting programmed
> > properly.
> >=20
> > PCI is using IRQs 10, 11, 12 & 14, but I think the kernel=20
> has made an=20
> > incorrect assumption that these are ISA IRQs and set them to be=20
> > edge-triggered.  PCI IRQs are always level-triggered.
> >=20
> > Take a look at arch/i386/kernel/mpparse.c in the
> > mp_config_acpi_legacy_irqs() routine.  It sets  interrupts
> > 0..15 to ISA
> > bus conforming behavior (edge).
> >=20
> > You might try forcing the kernel to do the right thing and see what=20
> > happens.
> >=20
> > Regards,
> > John
>=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
