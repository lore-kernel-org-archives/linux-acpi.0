From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: swsuspend in linux 2.6.0-pre4
Date: Tue, 26 Aug 2003 17:34:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030826153437.GA13129@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all,

I associate software suspend with ACPI, so I send this message on this
list, but maybe this is the wrong place...

I tried 2.6.0-pre4 on my computer.  First I was surprised to see that
/proc/acpi/sleep disapeared. Ok, there is probably a good reason, it is
not my place to contest anything.

To try to suspend my computer, I read the documentation, mounted
/sys and looked in /sys/power/state. Second surprise, the file only
contains an empty line. If I believe Documentation/power/interface.txt,
this file should contain "standby mem disk". Or does the kernel claim
that my computer is completely unable of any kind of suspend ? Is that
even possible ? On boot, the acpi subsystem proudly claims that my
computer supports S0 S1 S4 S5. (Ok, maybe sys/power/state should only
contain "standby disk".)

If I try to echo something to /sys/power/state (anything... Not just
standby, mem or disk), the screen goes blank a second and goes back to
normal, the computer fully alive. In the logs, two lines:
	Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D|
	Restarting tasks... done

In 2.6.0-pre1 (the last kernel I compiled before the present one), when I
echoed 1 or 4 to /proc/acpi/sleep, the computer did at least tried
something. For S1, after 5 seconds of putting task in the refrigerator,
the computer was back to normal operation. For S4, the computer achieved
suspend to disk sometimes (but never resumed) or oopsed trying. It was
comforting to know that, even if it was suicide for the computer, at
least it tried to suspend, and there was some hope that it would improve
in time. But now, nothing.

I tried also to boot 2.6.0-pre4 with acpi=3Doff. /sys/power/state is stil=
l
empty, but I had a oops and a complete hang of the computer when I tried
to echo disk (I think, I will try again) to it. Encouraging, in some way,
but is ACPI an obstacle to suspending ? Weird. (I didn't have enough
energy to copy the oops by hand. I'll do it, if you believe it is worth
it.)

The kernel is compiled with CONFIG_SOFTWARE_SUSPEND, CONFIG_ACPI,
CONFIG_ACPI_SLEEP and CONFIG_ACPI_DEBUG.

I have tried this with a kernel without APIC or IO-APIC and with
pci=3Dnoacpi, and again with a kernel with APIC and IO-APIC without the
command line option pci=3Dacpi.

The full .config file, boot messages, dsdt and many other information is
available on http://perso.nerim.net/~tudia/bug-reports

=C9ric Brunet


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
