From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Problems with ACPI and IO-APIC on KT400 (kernel 2.6.0-test11)
Date: Sat, 29 Nov 2003 23:48:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC887D@hdsmsx402.hd.intel.com>
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
To: Claas Langbehn <claas-YJlxJerscEeELgA04lAiVw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org, robbe-+Ldrc6GXUki9ZAADn/7PZw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Re: why use IOAPIC instead of PIC.

I must admit, if PIC-mode correctly supports the features you want and
you notice no performance degradation, then it is in your own immediate
best interest to simply run in PIC mode.

On the other hand, it is in the greater good to fix it so we can run the
hardware the way it was designed to run -- in IOAPIC mode.  IOAPIC mode
will perform better for two reasons, though you might not notice it on
lightly loaded systems where the interrupt load is low.

1. more IRQs available, so less IRQ sharing.
2. reduced overhead and reduced performance side effects of taking each
interrput.

The benefit of the 1st one is probably overblown, unless you have tons
of devices.  The benefit of the 2nd, however, is something that gets
worse over time as hardware designers continue to assume that nobody in
their right mind would run a high performance system in PIC mode.  An
interrupt acknowledge cycle over the bus is a tragic thing to witness;-)

I'd love to have your help debugging this IOAPIC-mode failure -- please
add yourself to the cc: for 1351 if you're willing.  Probably we should
start by simply trying the 4 possible polarity/trigger modes for the SCI
-- and if 1 or two of them work then we know that the issue.  I've seen
this be the case on less modern systems where the BIOS was simply
incorrect, and the fix there was to recognize that the BIOS was broken
and run in pci=3Dnoacpi mode.  However, in that case there was MPS
available to program the IOAPIC -- I'm not sure that is the case on your
system.  If the SCI polarity/trigger is the issue and there is no MPS,
then we may need to add a cmdline option to over-ride what a broken BIOS
tells us to do -- unless there is a chip-set specific quirk we can use
to fix it automatically.

Thanks,
-Len
Ps. It would be interesting to know if Windows runs in IOAPIC mode and
takes ACPI events on this box.



> -----Original Message-----
> From: Claas Langbehn [mailto:claas-YJlxJerscEeELgA04lAiVw@public.gmane.org]=20
> Sent: Thursday, November 27, 2003 5:22 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org; Brown, Len; robbe@orcus.priv.at
> Subject: Problems with ACPI and IO-APIC on KT400 (kernel 2.6.0-test11)
>=20
>=20
> Hello Andrew,
>=20
>=20
> thanks to your patches... since -test4, I have got IO-APIC=20
> and ACPI running now.
> But until today (-test11), ACPI does not detect the power button.
> When I boot with "noapic" then it does work.
>=20
> It seems to be this bug:=20
> http://bugzilla.kernel.org/show_bug.cgi?id=3D> 1351
>=20
> I can also=20
> confirm, that pressing the power button=20
> does not trigger an
> acpi interrupt when using apic.
>=20
>=20
> Is there already a patch to get it working?
>=20
> What makes IO-APIC better compared to "noapic" so that I would prefer
> using apic and not having the power button?
>=20
> I can provide more debugging info if needed.
>=20
>=20
> Regards, Claas
>=20
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
