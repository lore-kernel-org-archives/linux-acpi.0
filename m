From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPICA  20040211 released
Date: 15 Feb 2004 01:15:28 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076825728.25351.98.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Please note that the latest ACPI patch contains an update to the ACPICA
core interpreter.  Please let me know if you notice any regressions.

thanks,
-Len

Plain patches:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
BK trees: (this is in both the test and release trees)
http://linux-acpi.bkbits.net/

---
11 February 2004.  Summary of changes for version 20040211:

1) ACPI CA Core Subsystem:

Completed investigation and implementation of the call-by-reference
mechanism for control method arguments.

Fixed a problem where a store of an object into an indexed package could
fail if the store occurs within a different method than the method that
created the package.

Fixed a problem where the ToDecimal operator could return incorrect
results.

Fixed a problem where the CopyObject operator could fail on some of the
more obscure objects (e.g., Reference objects.)

Improved the output of the Debug object to display buffer, package, and
index objects.

Fixed a problem where constructs of the form "RefOf (ArgX)" did not
return the expected result.

Added permanent ACPI_REPORT_ERROR macros for all instances of the
ACPI_AML_INTERNAL exception.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
