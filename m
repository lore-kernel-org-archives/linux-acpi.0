From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI Linux source releases updated (20030218)
Date: Wed, 19 Feb 2003 09:59:00 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A191@orsmsx401.jf.intel.com>
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
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

New patches against 2.4 and 2.5 are available at
http://sf.net/projects/acpi .

This is a Linux-only release. The core interpreter version has not been
incremented, but there are many Linux-specific updates that we wanted to
make available. Linus has already pulled the changes so you can also
just wait for 2.5.63.

ACPI: Toshiba ACPI device update (John Belmonte)

ACPI: Change license from GPL to dual GPL and BSD-style

ACPI: misc cleanups

ACPI: Misc interpreter improvements

ACPI: Fix printk output (Jochen Hein)

ACPI: Decrease size of override's static array, add a define for the
length,
 and print a msg if used

ACPI: Add ability to override predefined object values (Ducrot Bruno)

ACPI: Support translation attribute (Bjorn Helgaas)

ACPI: Eliminate use of acpi_gpl_gpe_number_info (Matthew Wilcox)

ACPI: Change NUMA maintainer email

ACPI: *really* fix ISO SCI override support (thanks again to John
Stultz)

ACPI: Factor common code out of an if/else

ACPI: Properly handle an ISO reassigning the ACPI interrupt. Big thanks
to
 John Stultz.

ACPI: Use extended IRQ resource type when setting IRQs on link devices
to more
 than IRQ 15 (Juan Quintela)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
