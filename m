From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI patches updated (20021111)
Date: Tue, 12 Nov 2002 12:48:45 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

New patches are up on sf.net/projects/acpi. Non-Linux-specific releases will
be available by tomorrow evening at
http://developer.intel.com/technology/iapc/acpi/downloads.htm .

If you've been having problems with reading battery or other information
being very slow, please try this release and report if problems persist.

Regards -- Andy

----------------------------------------
11 November 2002.  Summary of changes for version 20021111.


0) ACPI Specification 2.0B is released and is now available
at:  http://www.acpi.info/index.html

1) Linux

Module loading/unloading fixes (John Cagle)

Other minor fixes

2) ACPI CA Core Subsystem:

Implemented support for the ACPI 2.0 SMBus Operation Regions.
This includes the early detection and handoff of the request
to the SMBus region handler (avoiding all of the complex field
support code), and support for the bidirectional return packet
from an SMBus write operation.  This paves the way for the
development of SMBus drivers in each host operating system.

Fixed a problem where the semaphore WAIT_FOREVER constant was
defined as 32 bits, but must be 16 bits according to the ACPI
specification.  This had the side effect of causing ASL
Mutex/Event timeouts even though the ASL code requested a wait
forever.  Changed all internal references to the ACPI timeout
parameter to 16 bits to prevent future problems.  Changed the
name of WAIT_FOREVER to ACPI_WAIT_FOREVER.



-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: 
To learn the basics of securing your web site with SSL, 
click here to get a FREE TRIAL of a Thawte Server Certificate: 
http://www.gothawte.com/rd522.html
