From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI Source patches updated (20021022)
Date: Tue, 22 Oct 2002 19:19:33 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF60@orsmsx119.jf.intel.com>
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
List-Id: linux-acpi@vger.kernel.org

Hi all,

New ACPI patches are now available on http://sf.net/projects/acpi .
Non-Linux source releases will be up by Thursday evening.

Most notable about this release is the Scope operator changes. People who
have been modifying their DSDTs to get around previous versions' problems
with Scope(OKEC) or Scope(_SB) should find this is no longer necessary.
Please speak up if problems persist.

Regards -- Andy

----------------------------------------
22 October 2002.  Summary of changes for version 20021022.


1) Linux

EC Driver:  No longer attempts to acquire the Global Lock at
interrupt level.

Exported some additional functions needed for PCI hot plug (JI Lee)

Clear ARB_DIS when returning from S1 (Ducrot Bruno)

Rename acpi_power_off to acpi_power_off_device (Pavel Machek)

2) ACPI CA Core Subsystem:

Implemented a restriction on the Scope operator that the
target must already exist in the namespace at the time the
operator is encountered (during table load or method
execution).  In other words, forward references are not
allowed and Scope() cannot create a new object. This changes
the previous behavior where the interpreter would create the
name if not found.  This new behavior correctly enables the
search-to-root algorithm during namespace lookup of the target
name.  Because of this upsearch, this fixes the known Compaq
_SB_.OKEC problem and makes both the AML interpreter and iASL
compiler compatible with other ACPI implementations.

Completed a major overhaul of the internal ACPI object types
for the ACPI Namespace and the associated operand objects.
Many of these types had become obsolete with the introduction
of the two-pass namespace load.  This cleanup simplifies the
code and makes the entire namespace load mechanism much
clearer and easier to understand.

Improved debug output for tracking scope opening/closing to
help diagnose scoping issues.  The old scope name as well as
the new scope name are displayed.  Also improved error
messages for problems with ASL Mutex objects and error
messages for GPE problems.

Cleaned up the namespace dump code, removed obsolete code.

All string output (for all namespace/object dumps) now uses
the common ACPI string output procedure which handles escapes
properly and does not emit non-printable characters.

Fixed some issues with constants in the 64-bit version of the
local C library (utclib.c)

3) iASL Compiler/Disassembler

Implemented ACPI 2.0B grammar change that disallows all Type 1
and 2 opcodes outside of a control method.  This means that
the "executable" operators (versus the "namespace" operators)
cannot be used at the table level; they can only be used
within a control method.

Implemented the restriction on the Scope() operator where the
target must already exist in the namespace at the time the
operator is encountered (during ASL compilation). In other
words, forward references are not allowed and Scope() cannot
create a new object.  This makes the iASL compiler compatible
with other ACPI implementations and makes the Scope()
implementation adhere to the ACPI specification.

Fixed a problem where namepath optimization for the Alias
operator was optimizing the wrong path (of the two namepaths.)
This caused a "Missing alias link" error message.

Fixed a problem where an "unknown reserved name" warning could
be incorrectly generated for names like "_SB" when the
trailing underscore is not used in the original ASL.

Fixed a problem where the reserved name check did not handle
NamePaths with multiple NameSegs correctly.  The first nameseg
of the NamePath was examined instead of the last NameSeg.

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
