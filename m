From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: Re: Re: 2.6.0-pre4 hangs if acpi enabled
Date: Tue, 26 Aug 2003 16:39:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030826143931.GA12993@lps.ens.fr>
References: <20030825113313.GA10691@lps.ens.fr> <1061813912.710.18.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1061813912.710.18.camel-uj2ycw1wlRUpU4hxjYRcxzD7d47T8nGG@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Felipe Alfaro Solana <felipe_alfaro-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 25, 2003 at 02:18:33PM +0200, Felipe Alfaro Solana wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D1123
>=20
> During boot, the kernel checks for i8042 AUX/MUX ports, tries
> registering IRQ #12 and then hangs. I fixed the problem on my i845DE
> motherboard by flashing a new BIOS with APIC and IOAPIC support. Then, =
I
> recompiled 2.6.0-test4 with APIC and IOAPIC support and the hangs went
> away.

Indeed, compiling in APIC and IO-APIC hides the problem and lets the
computer boot and work.

By the way, why should people use APIC and IO-APIC on UP computers ? Is
it faster or more efficient in some way ? Kernel documentation says that
the APIC is a ``replacement for PC-style interrupt controller''. Is there
anything the APIC can do that the traditionnal interupt controller can't
do ? Kernel documentation is not very incentive for wasting an extra 7.5
ko in the kernel image...
>=20
> you have the time, please, attach your "dmidecode" and "acpidmp" to the
> bug report at the above URL.
>=20
I don't have any dmi and the output of acpidmp is now on the web page
given in my bug report.

=C9ric


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
