From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI source release updated (20021002)
Date: Wed, 2 Oct 2002 14:01:38 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEF9@orsmsx119.jf.intel.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

There is a new release available at http://sf.net/projects/acpi . It
incorporates many fixes from people on this list (thanks to everyone) as
well as some interpreter enhancements. Non-Linux source releases and iasl
binaries will be available at
http://developer.intel.com/technology/iapc/acpi/downloads.htm by tomorrow
evening at the latest.

Regards -- Andy

----------------------------------------

02 October 2002.  Summary of changes for this release.

1) Linux

Initialize thermal driver's timer before it is used. (Knut
Neumann)

Allow handling negative celsius values. (Kochi Takayoshi)

Fix thermal management and make trip points. R/W (Pavel
Machek)

Fix /proc/acpi/sleep. (P. Christeas)

IA64 fixes. (David Mosberger)

Fix reversed logic in blacklist code. (Sergio Monteiro Basto)

Replace ACPI_DEBUG define with ACPI_DEBUG_OUTPUT. (Dominik
Brodowski)

2) ACPI CA Core Subsystem version 20021002:

Fixed a problem where a store/copy of a string to an existing
string did not always set the string length properly in the
String object.

Fixed a reported problem with the ToString operator where the
behavior was identical to the ToHexString operator instead of
just simply converting a raw buffer to a string data type.

Fixed a problem where CopyObject and the other "explicit"
conversion operators were not updating the internal namespace
node type as part of the store operation.

Fixed a memory leak during implicit source operand conversion
where the original object was not deleted if it was converted
to a new object of a different type.

Enhanced error messages for all problems associated with
namespace lookups.  Common procedure generates and prints the
lookup name as well as the formatted status.

Completed implementation of a new design for the Alias support
within the namespace.  The existing design did not handle the
case where a new object was assigned to one of the two names
due to the use of an explicit conversion operator, resulting
in the two names pointing to two different objects.  The new
design simply points the Alias name to the original name node
- not to the object.  This results in a level of indirection
that must be handled in the name resolution mechanism.

Code and Data Size: Current core subsystem library sizes are
shown below.  These are the code and data sizes for the
acpica.lib produced by the Microsoft Visual C++ 6.0 compiler,
and these values do not include any ACPI driver or OSPM code.
The debug version of the code includes the debug output trace
mechanism and has a larger code and data size.  Note that
these values will vary depending on the efficiency of the
compiler and the compiler options used during generation.

  Previous Release
    Non-Debug Version:  69.6K Code,   8.3K Data,   77.9K Total
    Debug Version:     150.0K Code,  61.7K Data,  211.7K Total
  Current Release:
    Non-Debug Version:  70.7K Code,   8.6K Data,   79.3K Total
    Debug Version:     151.7K Code,  62.4K Data,  214.1K Total


3) iASL Compiler/Disassembler

Clarified some warning/error messages.

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
