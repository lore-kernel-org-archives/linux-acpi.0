From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: does cpu_idle() halt CPU?
Date: Fri, 28 Mar 2003 14:28:41 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A23A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Jun Sun <jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Jun Sun [mailto:jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org] 
> I am new to acpi, but I figure this question is probably
> beyond acpi-support list.
> 
> I instrumented acpi_processor_idle() routine to see
> what states the CPU is in.  It turns out it spent most
> of the time in C2 state and some times in C1, but never
> in C3.
> 
> However, acpi_processor_power_activate() routine  does not
> do anything if the new state is _not_ C3.  So is that true
> CPU still keep spinning all the time?
> 
> I did a rough comparison.  It appears my battery life
> under Linux is about 75%  of that under Windows, even after
> I installed acpi, did a bunch of other stuff (swapoff,
> EXT3 -> EXT2, etc).

What power states does your CPU support?
- What does a cat of /proc/acpi/processor/*/power say?
- What does the ACPI: Processor line say in your dmesg say?

What kind of laptop do you have? Does it support SpeedStep, PowerNow, or
the like?
Do you have any USB devices attached?

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
