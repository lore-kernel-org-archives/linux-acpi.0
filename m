From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPICA 20031002 released
Date: 06 Oct 2003 17:20:32 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1065475231.2511.33.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

ACPICA 20031002 has been integrated with others in the ACPI patch,
and is available for test now in these bitkeeper trees:

http://linux-acpi.bkbits.net/linux-acpi-test-2.4.22
http://linux-acpi.bkbits.net/linux-acpi-test-2.4.23
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0

It is also available as a plain patch "*-ACPICA_20031002.patch" here:

ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/

----------

02 October 2003.  Summary of changes for version 20031002:


1) ACPI CA Core Subsystem:

Fixed a problem with Index Fields where the index was not incremented
for fields that require multiple writes to the index/data registers
(Fields that are wider than the data register.)

Fixed a problem with all Field objects where a write could go beyond the
end-of-field if the field was larger than the access granularity and
therefore required multiple writes to complete the request.  An extra
write beyond the end of the field could happen inadvertently.

Fixed a problem with Index Fields where a BUFFER_OVERFLOW error would
incorrectly be returned if the width of the Data Register was larger
than the specified field access width.

Completed fixes for LoadTable() and Unload() and verified their
operation.  Implemented full support for the "DdbHandle" object
throughout the ACPI CA subsystem.

Implemented full support for the MADT and ECDT tables in the ACPI CA
header files.  Even though these tables are not directly consumed by
ACPI CA, the header definitions are useful for ACPI device drivers.

Integrated resource descriptor fixes posted to the Linux ACPI list.
This included checks for minimum descriptor length, and support for
trailing NULL strings within descriptors that have optional string
elements.

Fixed a problem where the SMI_CMD register could be written even if it
was not supported on the platform (when FADT.SMI_CMD is zero)

Code and Data Size: Current and previous core subsystem library sizes
are shown below.  These are the code and data sizes for the acpica.lib
produced by the Microsoft Visual C++ 6.0 compiler, and these values do
not include any ACPI driver or OSPM code.  The debug version of the code
includes the debug output trace mechanism and has a much larger code and
data size.  Note that these values will vary depending on the efficiency
of the compiler and the compiler options used during generation.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
