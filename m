From: "Robert C. Paulsen Jr." <robert-J3gkRE/D7QA8RZtLRHdnRF6hYfS7NtTn@public.gmane.org>
Subject: An embedded-Linux power-management framework
Date: Fri, 2 Aug 2002 12:28:02 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020802172802.GA32612@avalon.paulsen.org>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Linux Power Management Development <linux-pm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux APMD <apmd-list-+wEybqfU8vgCzWx7n4ubxQ@public.gmane.org>, CPU Frequency <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

An embedded-Linux power-management framework
============================================

A dynamic power management framework for Linux is necessary to support the
flexible and aggressive power management policies made possible by the new
class of dynamic voltage- and frequency-scalable embedded processors including
the IBM PowerPC 405LP and the Intel XScale PXA210 and PXA250.

We have recently started work in this and would appreciated feedback on the
direction we are headed, summarized as a set of requirements below. Once
we have a start at a specification and some code we will put everything on
Sourceforge as an Open Source project. Please let us know what you think!

Requirements
============

Since CPU power typically increases as the cube of voltage while CPU frequency
scales linearly with voltage, very significant power savings can be achieved by
selecting the correct operating point for the current application set.  For
example, playing an MP3 with madplay only takes about 30 Mhz of the 405LP CPU.
By running the system at the lowest operating point sufficient to play the MP3
(100 MHz @ 1.0 V) vs. the highest possible operating point (266 MHz @ 1.8 V) an
immediate system power reduction (CPU + memory) of 40% is realized.  Since the
405LP can scale CPU and bus frequencies with an OS overhead in the tens of
microseconds, it also makes sense to scale back the CPU and bus during idle.
The power reduction between idling at 33 MHz and 100 Mhz is about 20% in one
system, and is significant because scaling back the bus frequency also reduces
the SDRAM power.  The low overhead required to do this scaling means we can
achieve these power savings without impacting interrupt response time too much.
Even with more power-hungry applications like MPEG-4 playback, on the 405LP
we've found that voltage- and frequency-scaling the system to a low-power state
during the inter-frame gaps (i.e. 30 times per second) can reduce system power
consumption (extends battery life) by 10%, and has no visible impact on the
video playback.

In addition, devices using these newer processors continue to support the
traditional static power management using sleep, hibernate, (etc.)
power-saving states.

In summary, the requirements for a Linux power-management framework are:

1. Support dynamic power management by taking advantage of the dynamic
   scaling capabilities of new hardware.

2. Support traditional static power management.

3. Both static and dynamic power management need to be supported with a
   Linux-specific, BIOS-independent, architecture-independent design.
   This consolidated design must account for interactions between static
   and dynamic power management.

4. Support embedded systems with uni-processors and symmetric or
   asymmetric multiprocessors.

5. Support pluggable power management policies.  This allows end-users to
   install applications that benefit from unique power policies and
   supports the following requirement.

6. Allow applications to both choose and provide hints to power policies.

Thanks!

  From:
    Hollis Blanchard <hollis-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org> (IBM) 
    Bishop Brock <bcbrock-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org> (IBM) 
    Matthew Locke <mlocke-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> (MontaVista)
    Mark Orvek <morvek-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> (MontaVista)
    Robert Paulsen <rpaulsen-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org> (IBM)
    Karthick Rajamani <karthick-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org> (IBM)

-- 
Robert C. Paulsen, Jr.
robert-J3gkRE/D7QA8RZtLRHdnRF6hYfS7NtTn@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
