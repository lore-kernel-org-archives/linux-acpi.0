From: Philipp <philipp.buechel-EOsNSARiLbg@public.gmane.org>
Subject: Re: Hang on booting 2.6.3 at "Edge set to Level Trigger"
Date: Fri, 19 Mar 2004 15:32:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403191532.53941.philipp.buechel@gmx.li>
References: <200403181845.46394.philipp.buechel@gmx.li> <1079689606.5242.11.camel@rh10.fe.up.pt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079689606.5242.11.camel-DSl92WGJowabUe/Hp89tnA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org




Am Freitag, 19. M=E4rz 2004 10:46 schrieb S=E9rgio "M. Basto":
> easy one, disable SMP and APIC in kernel configuration or boot with
> something like this: noloapic

Unfortunately, booting with noapic or noloapic takes no effect. dmesg alway=
s=20
shows something like

Local APIC disabled by BIOS -- reenabling.
=46ound and enabled local APIC!

And if I boot with "noapic acpi=3Don" or "noloapic acpi=3Don" the boot proc=
ess=20
hangs on the "Edge set to Level Trigger"-Point.

I guess I have to recompile the kernel with APIC disabled, right?


>
> On Thu, 2004-03-18 at 17:45, Philipp wrote:
> > Hi there
> >
> > I got an ACPI problem on my Compaq Presario 700.
> > When I boot Mandrake 10.0 with its 2.6.3-4mdk kernel and ACPI enabled t=
he
> > bootprocess hangs here:
> > [...]
> > ACPI: Subsystem revision 20040211
> > Looking for DSDT initrd...not found!
> > ACPI: IRQ10 SCI: Edge set to Level Trigger
> >
> > This happens wether noapic was given as kernel parameter or not. The
> > system just boots properly with ACPI disabled. Can anybody help me with
> > that problem? Thank you for suggestions.
> >
> > Regards
> > Philipp



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
