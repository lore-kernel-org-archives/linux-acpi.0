From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: Thread mutex errors / out of memory errors
Date: Mon, 11 Nov 2002 17:17:43 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E308@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andy,

In my testing of the power button support in your 2.4 acpi tree,
I occasionally encounter errors similar to these:

utmisc-0700 [03] Ut_acquire_mutex      : Thread 41B could not acquire
Mutex [ACPI_MTX_Caches] AE_ERROR
utmisc-0700 [-2] Ut_acquire_mutex      : Thread 420 could not acquire
Mutex [ACPI_MTX_Caches] AE_ERROR
dsutils-0463: *** Error: Could not allocate an object descriptor
dsutils-0549 [-5] Ds_create_operands    : While creating Arg 1 -
AE_NO_MEMORY
evevent-0816: *** Error: AE_NO_MEMORY while evaluating GPE4 method
utmisc-0700 [-13] Ut_acquire_mutex      : Thread 437 could not acquire
Mutex [ACPI_MTX_Caches] AE_ERROR
utmisc-0700 [-5] Ut_acquire_mutex      : Thread 43F could not acquire
Mutex [ACPI_MTX_Caches] AE_ERROR
utmisc-0700 [-146] Ut_acquire_mutex      : Thread 497 could not acquire
Mutex [ACPI_MTX_Caches] AE_ERROR

These errors typically occur during event processing (ie. when
I press the power button while cat'ing /proc/acpi/event).  The
Mutex errors do not appear to affect button events, but the
AE_NO_MEMORY errors are fatal (all button event processing
dies).

BTW, my kernel has your ACPI_WAIT_FOREVER mutex patch applied.

Have you seen these errors before?  I am happy to do further
testing if you can suggest where I should add debug code...

Thanks,
John
--------------------------------
John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
Principal Member Technical Staff
   Industry Standard Servers
    Hewlett-Packard Company
    http://www.hp.com/linux


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
