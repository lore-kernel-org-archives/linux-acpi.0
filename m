From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI 20020918 release - interpreter changelog
Date: Thu, 19 Sep 2002 09:29:24 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE85@orsmsx119.jf.intel.com>
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

Hi,

The 0918 release also included these interpreter changes:

18 September 2002.  Summary of changes for this release.

1) ACPI CA Core Subsystem version 20020918:

Fixed a reported problem with reference chaining (via the Index() and
RefOf() operators) in the ObjectType() and SizeOf() operators.  The
definition of these operators includes the dereferencing of all chained
references to return information on the base object.

Fixed a problem with stores to indexed package elements - the existing code
would not complete the store if an "implicit conversion" was not performed.
In other words, if the existing object (package element) was to be replaced
completely, the code didn't handle this case.

Relaxed typechecking on the ASL "Scope" operator to allow the target name to
refer to an object of type Integer, String, or Buffer, in addition to the
scoping object types (Device, predefined Scopes, Processor, PowerResource,
and ThermalZone.)  This allows existing AML code that has workarounds for a
bug in Windows to function properly.  A warning is issued, however.  This
affects both the AML interpreter and the iASL compiler. Below is an example
of this type of ASL code:

      Name(DEB,0x00)
      Scope(DEB)
      {

Fixed some reported problems with 64-bit integer support in the local
implementation of C library functions (clib.c)

2) iASL Compiler/Disassembler version 20020918:

Fixed a problem where the typechecking code didn't know that an alias could
point to a method.  In other words, aliases were not being dereferenced
during typechecking.

Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
