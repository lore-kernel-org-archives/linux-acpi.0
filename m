From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI source release updated (20020829)
Date: Thu, 29 Aug 2002 16:01:53 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDF1@orsmsx119.jf.intel.com>
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

Patches against 2.4.20-pre5 and 2.5.32 are up on http://sf.net/projects/acpi
now. iasl and other source releases will be updated by tomorrow on the
developer.intel.com site, as usual.

----------------------------------------
29 August 2002.  Summary of changes for this release.

1) ACPI CA Core Subsystem Version 20020829:

If the target of a Scope() operator already exists, it must
be an object type that actually opens a scope -- such as a
Device, Method, Scope, etc.  This is a fatal runtime error.
Similar error check has been added to the iASL compiler
also.

Tightened up the namespace load to disallow multiple names
in the same scope.  This previously was allowed if both
objects were of the same type.  (i.e., a lookup was the same
as entering a new name).


2) Linux

Ensure that the ACPI interrupt has the proper trigger and
polarity.

local_irq_disable is extraneous. (Matthew Wilcox)

Make "acpi=off" actually do what it says, and not use the
ACPI interpreter *or* the tables.

Added arch-neutral support for parsing SLIT and SRAT tables
(Kochi Takayoshi)


3) iASL Compiler/Disassembler  Version 20020829:

Implemented namepath optimization for name declarations.
For example, a declaration like "Method (\_SB_.ABCD)" would
get optimized to "Method (ABCD)" if the declaration is
within the \_SB_ scope.  This optimization is in addition to
the named reference path optimization first released in the
previous version. This would seem to complete all possible
optimizations for namepaths within the ASL/AML.

If the target of a Scope() operator already exists, it must
be an object type that actually opens a scope -- such as a
Device, Method, Scope, etc.

Implemented a check and warning for unreachable code in the
same block below a Return() statement.

Fixed a problem where the listing file was not generated if
the compiler aborted if the maximum error count was exceeded
(200).

Fixed a problem where the typechecking of method return
values was broken.  This includes the check for a return
value when the method is invoked as a TermArg (a return
value is expected.)

Fixed a reported problem where EOF conditions during a
quoted string or comment caused a fault.

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
