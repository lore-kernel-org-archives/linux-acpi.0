From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ACPI update (20030122)
Date: Thu, 23 Jan 2003 14:44:55 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

The latest ACPI patch is now available at http://sf.net/projects/acpi .
Non-Linux packages will be available within 24 hours from
http://developer.intel.com/technology/iapc/acpi/downloads.htm .

The patches are big primarily because we finally got with the program
and moved our headers from drivers/acpi/include to include/acpi.

Regards -- Andy

22 January 2003.  Summary of changes for version 20030122.


1) ACPI CA Core Subsystem:

Added a check for constructs of the form:  Store (Local0,
Local0) where Local0 is not initialized.  Apparently, some
BIOS programmers believe that this is a NOOP.  Since this
store doesn't do anything anyway, the new prototype behavior
will ignore this error.  This is a case where we can relax the
strict checking in the interpreter in the name of
compatibility.


2) Linux

The AcpiSrc Source Conversion Utility has been released with
the Unix package for the first time.  This is the utility
that is used to convert the ACPI CA base source code to the
Linux version.

(Both) Handle P_BLK lengths shorter than 6 more gracefully

(Both) Move more headers to include/acpi, and delete an unused
header.

(Both) Move drivers/acpi/include directory to include/acpi

(Both) Boot functions don't use cmdline, so don't pass it
around

(Both) Remove include of unused header (Adrian Bunk)

(Both) acpiphp.h includes both linux/acpi.h and acpi_bus.h.
Since the former now also includes the latter, acpiphp.h only needs the
one, now.

(2.5) Make it possible to select method of bios restoring
after S3 resume. [=> no more ugly ifdefs] (Pavel Machek)

(2.5) Make proc write interfaces work (Pavel Machek)

(2.5) Properly init/clean up in cpufreq/acpi (Dominik
Brodowski)

(2.5) Break out ACPI Perf code into its own module, under
cpufreq (Dominik Brodowski)

(2.4) S4BIOS support (Ducrot Bruno)

(2.4) Fix acpiphp_glue.c for latest ACPI struct changes
(Sergio Visinoni)


3) iASL Compiler:

Added support to disassemble SSDT and PSDTs.

Implemented support to obtain SSDTs from the Windows registry
if available.

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
