From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: mutexes and preemption
Date: Wed, 3 Mar 2004 17:08:53 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CFF522B18982EA4481D3A3E23B83141C01C988CE@orsmsx407.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Seifert <lathander-Mmb7MZpHnFY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Therien, Guy" <guy.therien-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Looking at the timestamps in the debug output, I suspect that the real
issue here is this line:

Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
: Failed to acquire semaphore[dffd8680|1|36863], AE_TIME

Because this wait should have been for 37 seconds (36863 milliseconds),
yet not one second has gone by on the wall clock.

A close look at the Linux implementation of os_wait_semaphore may again
be in order.

I have long advocated that anything less than full support of timed-wait
semaphores in the Linux kernel is simply a hack that cannot be trusted.
Perhaps the time has come to implement this support properly.

Bob





Mar  2 23:03:10 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 1370
(55A)=20
Mar  2 23:03:10 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 3 (3)
Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
: Failed to acquire semaphore[dffd8680|1|0], AE_TIME
Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
: Failed to acquire semaphore[dffd8680|1|36863], AE_TIME
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2054] acpi_ec_read
: Read [30] from address [9c]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2054] acpi_ec_read
: Read [28] from address [9d]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2054] acpi_ec_read
: Read [3c] from address [9e]
Mar  2 23:03:10 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 3 (3)=20
Mar  2 23:03:10 tenshi kernel:  exmutex-0264: *** Error: Thread 3 cannot
release Mutex [MUT1] acquired by thread 55A=20
Mar  2 23:03:10 tenshi kernel:  psparse-1120: *** Error: Method
execution failed [\_TZ_.THZN._TMP] (Node dff61c48), AE_AML_NOT_OWNER=20


-----Original Message-----
From: Moore, Robert=20
Sent: Wednesday, March 03, 2004 3:59 PM
To: 'Sebastian Seifert'; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Grover, Andrew
Subject: RE: [ACPI] mutexes and preemption



One of these ACQUIRE ops timed out:                     =20

Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0x8FFF)

As witnessed by this debug output:

Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
: Failed to acquire semaphore[dffd8680|1|0], AE_TIME
Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
: Failed to acquire semaphore[dffd8680|1|36863], AE_TIME

Notice that the ASL code does not handle the AE_TIME error case but just
plows ahead.

Bob






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
