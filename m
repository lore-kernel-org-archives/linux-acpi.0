From: Jeff Chua <jeff89-xU4+foPaXuB6NlgSsqhgrkEOCMrvLtNR@public.gmane.org>
Subject: _slooow acpi suspend to disk
Date: Thu, 4 Mar 2004 09:09:31 +0800 (SGT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0403040858470.23978@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi Development <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


I noticed that the first (from fresh linux boot) suspend to disk runs
extremely slow (3 minutes) saving from memory to disk.

After the first suspense, subsequence suspenses are very fast ... less
than 15 seconds.

System is Linux 2.6.4-rc1, 1GB Ram (but highmem disabled), IBM X30 1.4GHz,
gcc 2.95.3, glibc 2.2.5-34.

Command to suspend ... "echo 4 >/proc/acpi/sleep".

Tried with/without preemptive, and even applied acpi-20040220-2.6.4.diff.


Another problem I noticed is vmware-4.0.5 runs very slowly with
"processor" module loaded, and runs fine without "processor".



Thanks,
Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
