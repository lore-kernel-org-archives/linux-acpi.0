From: Stephan Krings <stephan-6/4LMolCrz7QLMG2gba6HQ@public.gmane.org>
Subject: CPU performance states on Compaq Evo N800c
Date: Sun, 26 Jan 2003 22:26:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15924.21116.735811.815362@hotzenplotz.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


Hello,

with a modified DSDT I can get most of the ACPI features in /proc/acpi
to work for my Evo N800c. However one issue remains: It's not really
possible to manually toggle the performance states using
/proc/acpi/processor/C000/performance. This applies to kernel 2.4.20
and the ACPI patch 20021212. The CPU in this machine is reported as
"Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz", stepping 4.

The notebooks behaves as follows: When offline from power the CPU will
automatically switch to state P1. I notice this because the
temperature of the CPU drops almost immediatly and some programs run
slightly slower (transcode is nice for monitoring that, because it
displays a frame rate). However the values in /proc/acpi do not
reflect this change. They remain at P0. Reenabling power will switch
the CPU to P0 automatically, again.

When manually toggling the P-states using "echo 1 >
/proc/acpi/processor/C000/power" strange behaviour occurs: The CPU
does in fact run slower (as I notice from temperature and frame rate),
but the ACPI drivers reports:

Jan 26 12:48:50 hotzenplotz kernel: acpi_processor-1095 [62] acpi_processor_set_per: Transition failed

although the transition did in fact work. When looking at the code for
the processor module I find a loop at the end of
acpi_processor_set_performance where the code will poll 1 ms for a
state change. This part doesn't seem to work for me.

Switching state a second time will not work also, but this is because
of the following check in processor.c:

        if (state == pr->performance.state) {
		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
			"Already at target state (P%d)\n", state));
		return_VALUE(0);
	}

So, anyone any idea, why a state change is not recognized for this
machine?

Apart from that I'm really impressed how much of the ACPI stuff is
actually working now quite nicely for me. Good work!

Kind regards,

Stephan


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
