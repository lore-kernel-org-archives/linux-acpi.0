From: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: driver 8139too prevents swsusp.
Date: Sat, 8 Feb 2003 10:15:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030208091526.GA20891@lps.ens.fr>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I have been trying S4 sleep on a 2.5.59 + acpi0123 patch kernel on my
computer (Shuttle motherboard, i845 chipset). The motherboard has an
integrated Realtek  ``RTL-8139/8139C/8139C+ (rev 10)'' ethernet card,
so I am using the 8139too driver compiled in the kernel.

When I try to ``echo 4 > /proc/acpi/sleep'', I have messages like:

=3Dkdeinit entered refrigerator
=3Dkalarmd entered refrigerator
=3Dzsh entered refrigerator
=3Dsu entered refrigerator
=3D
[ wait a couple of seconds ]
 stopping tasks failed (1 tasks remaining)
Suspend failed: Not all processes stopped!
Restarting tasks...<6> Strange, eth0 not stopped
 done
init left refrigerator
pdflush left refrigerator
kswapd0 left refrigerator
kseriod left refrigerator

Indeed, I have a kernel thread called [eth0] in the ps output. I cannot
kill this process, but if I do ``ifconfig eth0 down'', the process
diseapear and the swsusp works better (see below). So it seems that
swsusp cannot put this [eth0] process in the refrigerator.

By the way, when I did my swsusp tests yesterday, I switched to runlevel =
1
to experiment. After shutting down eth0 with ifconfig, sleep level 4
worked great: the computer went down and resumed flawlessly. However, I
tried again today before writing this bug report and I stayed in
runlevel 5 (I just switched to VT1 to see kernel messages). And today
I couldn't suspend either, I hit the BUG_ON in driver/ide/ide-disk.c:1557
I didn't bother to hand write down the oops, as the machine was frozen
and as I reflected that the stack trace was probably perfectly known.
If this oops is of some importance, I can try to reproduce and write
it.

Thanks for all your work,

	=C9ric Brunet


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
