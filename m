From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI source release updated (20020725)
Date: Thu, 25 Jul 2002 17:13:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <59885C5E3098D511AD690002A5072D3C07990D88@orsmsx111.jf.intel.com>
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
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Patches of this release are available now at http://sf.net/projects/acpi.
The compiler and non-Linux source releases will be available at:
http://developer.intel.com/technology/iapc/acpi/downloads.htm by tomorrow
evening.

Regards -- Andy

----------------------------------------
25 July 2002.  Summary of changes for this release.


1) ACPI CA Core Subsystem Version 20020725:

The AML Disassembler has been enhanced to produce compilable
ASL code and has been integrated into the iASL compiler (see
below) as well as the single-step disassembly for the AML
debugger and the disassembler for the AcpiDump utility.  All
ACPI 2.0A opcodes, resource templates and macros are fully
supported.  The disassembler has been tested on over 30
different AML files, producing identical AML when the
resulting disassembled ASL file is recompiled with the same
ASL compiler.

Modified the Resource Manager to allow zero interrupts and
zero dma channels during the GetCurrentResources call.  This
was causing problems on some platforms.

Added the AcpiOsRedirectOutput interface to the OSL to
simplify output redirection for the AcpiOsPrintf and
AcpiOsVprintf interfaces.

2) Linux

Fixed a panic in the EC driver (Dominik Brodowski)

Implemented checksum of the R/XSDT itself during Linux table
scan (Richard Schaal)


3) iASL compiler

The AML disassembler is integrated into the compiler.  The "-
d" option invokes the disassembler  to completely
disassemble an input AML file, producing as output a text
ASL file with the extension ".dsl" (to avoid name collisions
with existing .asl source files.)  A future enhancement will
allow the disassembler to obtain the BIOS DSDT from the
registry under Windows.

Fixed a problem with the VendorShort and VendorLong resource
descriptors where an invalid AML sequence was created.

Implemented a fix for BufferData term in the ASL parser.  It
was inadvertently defined twice, allowing invalid syntax to
pass and causing reduction conflicts.

Fixed a problem where the Ones opcode could get converted to
a value of zero if "Ones" was used where a byte, word or
dword value was expected.  The 64-bit value is now truncated
to the correct size with the correct value.

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
