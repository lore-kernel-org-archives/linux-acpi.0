From: "John Wilkinson1" <WILKINJ-ygUJEDcBm8rQT0dZR+AlfA@public.gmane.org>
Subject: ASF! tables unsupported
Date: Tue, 24 Sep 2002 12:00:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF21E99D4B.66D14E4D-ON80256C3E.00365E1C@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Using a new IBM server that supports the Alert Standard Format
(http://www.dmtf.org/standards/documents/ASF/DSP0114.pdf), ACPI gets
disabled. Hopefully someone on this list can fix this, or redirect this to
someone who can.

It seems to be because ASF-compliant machines have an ACPI table with a
title of "ASF!" (see section 4.1.2 in above document). When booting kernel
version 2.4.18, the messages

        ACPI-0202: Invalid table signature ASF! found
        ACPI-0094: *** Error: Acpi_load_tables: Error getting required
tables (DSDT/FADT/FACS): AE_BAD_SIGNATURE
        ACPI-0115: *** Error: Acpi_load_tables: Could not load tables:
AE_BAD_SIGNATURE
ACPI: System description table load failed
are logged.

In acpi_ut_valid_acpi_name (drivers/acpi/utilities/utmisc.c), the test for
whether the characters in a table signature are valid is

if (!((name_ptr[i] == '_') ||
  (name_ptr[i] >= 'A' && name_ptr[i] <= 'Z') ||
  (name_ptr[i] >= '' && name_ptr[i] <= '9'))) {

So the "ASF!" signature fails because of the '!'.

Changing the above code to

if (!((name_ptr[i] == '_') || (name_ptr[i] == '!') ||
...

lets the kernel boot correctly with ACPI enabled. Obviously, changing this
is fine for personal compiles, but it would be great if this could be
brought into the official patches. This will become more of a hurdle as ASF
becomes more common, as it is a recent standard.

John Wilkinson

Software Engineer
SSG, IBM Hursley
Internet Mail: wilkinj-ygUJEDcBm8rQT0dZR+AlfA@public.gmane.org




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
