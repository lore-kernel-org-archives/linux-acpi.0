From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI source release updated (20020815)
Date: Fri, 16 Aug 2002 10:41:52 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDA6@orsmsx119.jf.intel.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

First, I've sent the 0725 2.4 patch to Marcelo for inclusion in 2.4. He has
asked that Alan stick it in -ac for a while to see if it is stable enough.
If all goes well, it will be, and future patches against 2.4 will hopefully
be incremental and small.

Second, the Linux 2.5 patch is up on sf.net/projects/acpi, and includes the
changes listed below. Unfortunately, due to a BK error on my part (I merged
the ACPI patch onto the tip of the 2.4 BK tree, instead of 2.4.19) the 2.4
patch is going to have to wait until Marcelo releases 2.4.20-pre3.

Lastly, other source releases will be available by tonight at:
http://developer.intel.com/technology/iapc/acpi/downloads.htm .


----------------------------------------
15 August 2002.  Summary of changes for this release.

1) ACPI CA Core Subsystem Version 20020815:

Fixed a reported problem where a Store to a method argument
that contains a reference did not perform the indirect store
correctly.  This problem was created during the conversion
to the new reference object model - the indirect store to a
method argument code was not updated to reflect the new
model.

Reworked the ACPI mode change code to better conform to ACPI
2.0, handle corner cases, and improve code legibility (Kochi
Takayoshi)

Fixed a problem with the pathname parsing for the carat (^)
prefix.  The heavy use of the carat operator by the new
namepath optimization in the iASL compiler uncovered a
problem with the AML interpreter handling of this prefix.
In the case where one or more carats precede a single
nameseg, the nameseg was treated as standalone and the
search rule (to root) was inadvertently applied.  This could
cause both the iASL compiler and the interpreter to find the
wrong object or to miss the error that should occur if the
object does not exist at that exact pathname.

Found and fixed the problem where the HP Pavilion DSDT would
not load.  This was a relatively minor tweak to the table
loading code (a problem caused by the unexpected encounter
with a method invocation not within a control method), but
it does not solve the overall issue of the execution of AML
code at the table level.  This investigation is still
ongoing.

2) Linux

Remove redundant slab.h include (Brad Hards)

Fix several bugs in thermal.c (Herbert Nachtnebel)

Make CONFIG_ACPI_BOOT work properly (Pavel Machek)

Change acpi_system_suspend to use updated irq functions
(Pavel Machek)

Export acpi_get_firmware_table (Matthew Wilcox)

Use proper root proc entry for ACPI (Kochi Takayoshi)

Fix early-boot table parsing (Bjorn Helgaas)


3) iASL Compiler/Disassembler

Reworked the compiler options to make them more consistent
and to use two-letter options where appropriate.  We were
running out of sensible letters.   This may break some
makefiles, so check the current options list by invoking the
compiler with no parameters.

Completed the design and implementation of the ASL namepath
optimization option for the compiler.  This option optimizes
all references to named objects to the shortest possible
path.  The first attempt tries to utilize a single nameseg
(4 characters) and the "search-to-root" algorithm used by
the interpreter.  If that cannot be used (because either the
name is not in the search path or there is a conflict with
another object with the same name), the pathname is
optimized using the carat prefix (usually a shorter string
than specifying the entire path from the root.)

Implemented support to obtain the DSDT from the Windows
registry (when the disassembly option is specified with no
input file).  Added this code as the implementation for
AcpiOsTableOverride in the Windows OSL.  Migrated the 16-bit
code (used in the AcpiDump utility) to scan memory for the
DSDT to the AcpiOsTableOverride function in the DOS OSL to
make the disassembler truly OS independent.

Implemented a new option to disassemble and compile in one
step.  When used without an input filename, this option will
grab the DSDT from the local machine, disassemble it, and
compile it in one step.

Added a warning message for invalid escapes (a backslash
followed by any character other than the allowable escapes).
This catches the quoted string error "\_SB_" (which should
be "\\_SB_" ).  Also, there are numerous instances in the
ACPI specification where this error occurs.

Added a compiler option to disable all optimizations.  This
is basically the "compatibility mode" because by using this
option, the AML code will come out exactly the same as other
ASL compilers.

Added error messages for incorrectly ordered dependent
resource functions.  This includes: missing EndDependentFn
macro at end of dependent resource list, nested dependent
function macros (both start and end), and missing
StartDependentFn macro.  These are common errors that should
be caught at compile time.

Implemented _OSI support for the disassembler and compiler.
_OSI must be included in the namespace for proper
disassembly (because the disassembler must know the number
of arguments.)

Added an "optimization" message type that is optional (off
by default).  This message is used for all optimizations -
including constant folding, integer optimization, and
namepath optimization.

Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
