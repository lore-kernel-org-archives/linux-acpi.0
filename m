From: Martin Siegert <siegert-z1KUqvL5UUQ@public.gmane.org>
Subject: ACPI problems on Athlon MP system
Date: Thu, 9 Jan 2003 19:07:41 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030110030741.GA2580@stikine.ucs.sfu.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi,

I am not sure whether this is the correct place to ask this question,
but hopefully you can point me in the right direction.

Here is the problem:
I am trying to get the "poweroff" command working on an Athlon MP
(Tyan S2462) system (linux-2.4.21-pre2; otherwise RedHat 7.3).

The machine has ACPI enabled in the bios. When I compile the kernel
with ACPI disabled, the poweroff command shuts down the system, but
does not shut off the power (it acts exactly like the halt command).
In order to shutoff the machine I must press the power switch.

When I compile the kernel with ACPI enabled the situation is worse:
the halt and poweroff commands still work in exactly the same way
(shutdown the system), but now I cannot switch off the machine
anymore: pressing the power switch has absolutely no effect
(regardless of how long I hold the switch). The only way to
switch off the machine is to either pull the power cord or to
press the reset button on then the power switch (which will then
switch off the machine when it reboots).

What am I doing wrong? Am I missing some kernel switches, options?
Do I need additional software?

Any help or suggestions, hints are appreciated!

Thanks in advance,

Martin

========================================================================
Martin Siegert
Academic Computing Services                        phone: (604) 291-4691
Simon Fraser University                            fax:   (604) 291-4242
Burnaby, British Columbia                          email: siegert-z1KUqvL5UUQ@public.gmane.org
Canada  V5A 1S6
========================================================================


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
