From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI bug/patch flow, and current RESOLVED bug list
Date: 04 Nov 2004 18:11:02 -0500
Message-ID: <1099609861.13837.422.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

When a bug is marked RESOLVED in bugzilla,
http://bugzilla.kernel.org/buglist.cgi?product=ACPI
it means that there is a patch available in the bug report.

If the patch looks good and has seen some review
and unit testing, I check it into our test tree:
http://linux-acpi.bkbits.net/26-latest-test
You are encouraged to run this tree and report any issues
you find.

Andrew Morton periodically pulls that tree into the -mm
patch where it sees broader testing.

If nothing breaks, then I push 26-latest-test into
http://linux-acpi.bkbits.net/26-latest-release
export a plain patch here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
and request Linus pull it into his tree.

Note that these plain patches for 26-latest-release are
obsolete as soon as Linus pulls into his tree, but the
plain patches under 26-stable-release directory are available
to allow running the latest ACPI patch on the latest released
kernel.org kernel.

(currently 26-stable-release is 2.6.8.1 based, but momentarily
 i'll be updating it to be 2.6.9-based since that has been
 the latest release for a few days now)

After a patch is in the Linus's tree, I CLOSE the bug.

-----------

I've just CLOSED all the RESOLVED bugs that shipped in 2.6.9.

There are 16 RESOLVED bugs left, listed below.  Some need
review and unit test.  Others I've already checked into
26-latest-test and are already in the -mm tree.  Please be
aware of these patches and be encouraged to test, review,
and comment on them.

I understand and appreciate some people's preference to
conduct all debugging and patch activity on the mailing
list.  However, with the broad scope and high volume on the
Linux/ACPI effort, bugzilla's ability to focus and
archive debugging sessions as well as track patch origin
and status is extremely useful.

If you'd like to stay appraised of the activity in bugzilla
there are several methods.  You can have your bugzilla
account "watch" the activity of the default category
owners.  eg. acpi_config-other-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
owns category ACPI, component "config-other".  Or you
can subscribe to acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
which watches all components in category ACPI,
and is added to the cc: list when an individual
takes ownership of a bug from the default owner.
http://lists.sourceforge.net/lists/listinfo/acpi-bugzilla

Thanks for your help in constantly improving Linux/ACPI!
-Len
---

1744 AE_BAD_PARAMETER returned from ec address space handler.
     needs review

1944 ACPI Extensions for Display Adapters
     applied

2109 poweroff regression @ hwsleep 1.21 - ACPICA 20031203
     needs review & root cause

2280 C1 uses "halt" instead of "monitor/mwait"
     applied

2495 ACPI_BOOT should be disabled even if SMP is selected
     needs to be updated and re-applied

2560 C3 state with smp kernel results in APIC timer interrupt ...
     needs review

2842 enable C3 without using ARB_DIS feature
     needs review

3161 acpi processor module needs to stay loaded for powernow-k8
     applied, but I don't like it

3164 remove dmi blacklists for HP machines
     applied

3175 irq 9: nobody cared! (audio related - via82xx)
     applied

3333 Problem reading /proc/acpi/battery/BAT0/info
     needs review and test

3336 ACPI_FUNCTION_TRACE() missing return's
     applied

3390 S3 wake fails: phys vs. virtual wake vector - IBM X40
     applied

3518 disable event LID blocks SLPB and vice versa on wakeup fr...
     needs review

3549 add option/dmi to disable c2/c3 in processor.c
     applied, but needs to be re-written for ipw2100

3551 disable ACPI timer override on Nvidia i386
     needs review





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
