From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Hang on booting 2.6.3 at "Edge set to Level Trigger"
Date: 19 Mar 2004 12:39:52 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079717992.7274.23.camel@dhcppc4>
References: <200403181845.46394.philipp.buechel@gmx.li>
	 <1079689606.5242.11.camel@rh10.fe.up.pt>
	 <200403191532.53941.philipp.buechel@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200403191532.53941.philipp.buechel-EOsNSARiLbg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Philipp <philipp.buechel-EOsNSARiLbg@public.gmane.org>
Cc: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-03-19 at 09:32, Philipp wrote:
>=20
> Am Freitag, 19. M=E4rz 2004 10:46 schrieb S=E9rgio "M. Basto":
> > easy one, disable SMP and APIC in kernel configuration or boot with
> > something like this: noloapic
>=20
> Unfortunately, booting with noapic or noloapic takes no effect. dmesg a=
lways=20
> shows something like
>=20
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

In 2.6.3, "nolapic" should be effective at disabling detect_init_APIC()
which is doing this.  Check that there has not been some modification to
arch/i386/kernel/apic.c

> And if I boot with "noapic acpi=3Don" or "noloapic acpi=3Don" the boot =
process=20
> hangs on the "Edge set to Level Trigger"-Point.
>=20
> I guess I have to recompile the kernel with APIC disabled, right?

I guess so.
CONFIG_X86_LOCAL_APIC=3Dn

-Len




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
