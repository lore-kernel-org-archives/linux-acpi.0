From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI source release updated (20030424)
Date: Fri, 25 Apr 2003 16:31:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A27C@orsmsx401.jf.intel.com>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

A new ACPI source release is now available from
http://sf.net/projects/acpi . Due to most of the improvements already
being in the latest 2.5 bk snapshots, there is only a 2.4 patch up there
for the moment. Non-Linux source releases will be available
hopefully by Monday morning, definitely by Monday evening.

Regards -- Andy

----------------------------------------
24 April 2003.  Summary of changes for version 20030424.

1) ACPI CA Core Subsystem:

Support for big-endian systems has been implemented.  Most of the
support has been invisibly added behind big-endian versions of
the ACPI_MOVE_* macros.

Fixed a problem in AcpiHwDisableGpeBlock() and
AcpiHwClearGpeBlock() where an incorrect offset was passed to the
low level hardware write routine.  The offset parameter was
actually eliminated from the low level read/write routines
because they had become obsolete.

Fixed a problem where a handler object was deleted twice during
the removal of a fixed event handler.


2) Linux:

A fix for SMP systems with link devices was contributed by
Compaq's Dan Zink.

(2.5) Return whether we handled the interrupt in our IRQ handler.
(Linux ISRs no longer return void, so we can propagate the
handler return value from the ACPI CA core back to the OS.)


3) Documentation:

The ACPI CA Programmer Reference has been updated to reflect new
interfaces and changes to existing interfaces.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
