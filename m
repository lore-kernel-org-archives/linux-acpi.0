From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: gericom notebook reboots instead of poweroff
Date: Wed, 3 Nov 2004 15:30:14 +0100
Message-ID: <20041103143014.GF1002@elf.ucw.cz>
References: <20041026194029.GA10954@pooh> <20041102203243.GA996@openzaurus.ucw.cz> <20041103071833.GA12510@pooh> <20041103124045.GC1002@elf.ucw.cz> <20041103141213.GA29645@pooh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041103141213.GA29645@pooh>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > I would greatly appreciate any help how to handle BitKeeper to get those
> > > changesets individualy.
> > 
> > It should be possible to download individual patches from bkbits.net,
> > but it is likely to be pretty tedious process.....
>  It is. :( I have already tried that approach (from
> http://linux-acpi.bkbits.net:8080/26-stable-release/tags?nav=index.html ),
> but simply clicking on 'later CSets' in the v2.6.8.1 line does not work
> for two fold: 1) you can't be sure that ACPI changes are synced on each
> release, so some 2.6.9-bk1 ACPI changes may come from older times and 2)
> not all CSets accepted by Andrew/Linus, they are selective.
> But thanks for your BK/ChangeLog proposal, that detailed changelog you
> described would help a lot.

This should be list of all things andrew accepted just after
2.6.8.1. Hope this helps...
									Pavel

----------------------------
revision 1.20860
date: 2004-08-18 23:10:48 +0000;  author: overby;  state: Exp;  lines: +0 -0
[XFS] Permit buffered writes to the real-time subvolume.

SGI Modid: xfs-linux:xfs-kern:174094a
Signed-off-by: Nathan Scott <nathans-sJ/iWh9BUns@public.gmane.org>

BKrev: 4123e1f8yFHs5gUyBaaaAU3uX0xtXA
----------------------------
revision 1.20859
date: 2004-08-14 10:56:40 +0000;  author: torvalds;  state: Exp;  lines: +0 -0
Merge ppc970.osdl.org:/home/torvalds/v2.6/v2.6.8.1
into ppc970.osdl.org:/home/torvalds/v2.6/linux

2004/08/14 03:44:08-07:00 torvalds
Fix stupid thinkos in the fcntl f_op removal code.

Tssk.

2004/08/14 03:24:55-07:00 torvalds
Make 'WRITE_BUFFER' require CAP_RAWIO capability

Pointed out by Kai Makisara.

2004/08/14 02:41:01-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/14 02:32:45-04:00 len.brown
merge

2004/08/14 01:11:05-04:00 len.brown
[ACPI] Enter ACPI mode earlier
Fixes two common boot failures due to buggy SMM BIOS code

SMP boot crash if SMI_CMD=ACPI written from CPU1
http://bugzilla.kernel.org/show_bug.cgi?id=2941

laptop crash due to LAPIC timer before SMI_CMD=ACPI
http://bugzilla.kernel.org/show_bug.cgi?id=1269

2004/08/13 18:06:49-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/13 17:52:32-04:00 len.brown
[ACPI] clean out blacklist entries that do nothing

2004/08/12 11:56:29-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/11 12:05:47-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/09 13:03:19-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/09 12:43:20-04:00 len.brown
[ACPI] init wakeup devcies only if ACPI enabled (David Shaohua Li)

2004/08/09 12:23:17-04:00 len.brown
[ACPI] acpi_bus_register_driver() now return a count
consistent with pnp_register_driver() and pci_register_driver()

All existing callers of acpi_bus_register_driver() either ignore the
return value or check only for negative (error) return values.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

2004/08/09 12:11:05-04:00 len.brown
[ACPI] acpi for asus update from Karol Kozimor

support for L4R and M5N, moves some bits for M6N
and restores WLED functionality for M2N
comment and whitespace cleanups
fix get/set typo from /proc patch, delete trailing spaces

2004/08/09 12:00:52-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/08 01:28:20-04:00 len.brown
[ACPI] acpi_system_write_wakeup_device() has the wrong return type
and is missing the __user attribution from its buffer argument.
This patch shuts up the resulting warnings on x86-64.

From: William Lee Irwin III <wli-tGiaVUSOoeej7qYf8Sx8sA@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>

2004/08/07 22:26:00-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/07 02:36:11-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/06 14:35:16-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/06 00:40:33-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/04 17:14:35-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/04 17:06:43-04:00 nbryant
[ACPI] restore PCI Interrupt Link Devices upon resume

* register as as a sys_device so that we can get resume callbacks and restore
  interrupt routing state.
* add acpi_pci_link_resume(), which will be called when resuming from a suspend
  state that needs IRQ routing to be restored. This fixes issues reported on
  the mailing lists, e.g.:
http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
* rename setonboot --> initialized
* change to test acpi_noirq in init

We want to initialize everything on S3 resume in case the BIOS points an
interrupt link somewhere we didn't expect. (Doing so avoids "missing interrupt"
or "irq x: nobody cared" problems.) According to Len, past experience has shown
that it's a good idea to initialize only devices that exist or were explicitly
asked for, so we try to initialize only the IRQ's that were previously
initialized at some point before suspend, by checking the "initialized" flag.
This corresponds to links that have PCI devices attached.  Everything else, we
leave alone. Assuming the BIOS does the same thing on resume that it did on
boot, this will leave all the unused links in the same state that they were on
boot.

We are registered as a sysdev in order to do this work fairly early during
resume, before devices are resumed; some devices may not call
pci_device_enable.

Previous "setonboot once" behavior is left in place, to be conservative.

2004/08/03 23:44:57-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/03 23:13:00-04:00 len.brown
[ACPI] BIOS workaround allowing devices to use reserved IO ports
Author: David Shaohua Li
http://bugzilla.kernel.org/show_bug.cgi?id=3049

2004/08/03 22:07:40-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/03 11:50:39-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/08/02 14:08:40-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/31 21:06:44-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/31 01:47:15-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/30 17:44:41-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/29 11:57:15-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/28 15:44:31-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/28 15:24:34-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/28 15:17:02-04:00 len.brown
[ACPI] fix build warning (Andrew Morton)

2004/07/28 14:48:50-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/28 14:46:34-04:00 len.brown
[ACPI] synchronize_kernel for idle-loop unload (Zwane Mwaikambo)
http://bugzilla.kernel.org/show_bug.cgi?id=1716

2004/07/28 14:42:35-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/28 14:40:03-04:00 len.brown
[ACPI] S3 is independent of CONFIG_X86_PAE (David Shaohua Li)

2004/07/26 16:47:18-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/17 01:52:49-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/17 01:37:59-04:00 len.brown
[ACPI] ACPICA 20040715 from Bob Moore

Restructured the internal HW GPE interfaces to pass/track
the current state of interrupts (enabled/disabled) in
order to avoid possible deadlock and increase flexibility
of the interfaces.

Implemented a "lexicographical compare" for String and
Buffer objects within the logical operators -- LGreater,
LLess, LGreaterEqual, and LLessEqual -- as per further
clarification to the ACPI specification.  Behavior is
similar to C library "strcmp".

Completed a major reduction in CPU stack use for the
acpi_get_firmware_table external function.  In the 32-bit
non-debug case, the stack use has been reduced from 168
bytes to 32 bytes.

Deployed a new run-time configuration flag,
acpi_gbl_enable_interpeter_slack, whose purpose is to allow
the AML interpreter to forgive certain bad AML constructs.
Default setting is FALSE.

Implemented the first use of acpi_gbl_enable_interpeter_slack
in the Field IO support code.  If enabled, it allows field
access to go beyond the end of a region definition if the
field is within the region length rounded up to the next
access width boundary (a common coding error.)

Renamed OSD_HANDLER to acpi_osd_handler, and
OSD_EXECUTION_CALLBACK to acpi_osd_exec_callback for
consistency with other ACPI symbols.  Also, these symbols
are lowercased by the latest version of the acpisrc tool.

The prototypes for the PCI interfaces in acpiosxf.h
have been updated to rename "register" to simply "reg"
to prevent certain compilers from complaining.

2004/07/15 17:13:57-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/15 16:18:44-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/15 15:17:42-04:00 len.brown
[ACPI] Enable run-time CM button/LID events (David Shaohua Li)
http://bugzilla.kernel.org/show_bug.cgi?id=1415

2004/07/15 02:20:47-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/15 02:05:38-04:00 len.brown
Merge

2004/07/15 00:39:15-04:00 len.brown
[ACPI] Create /proc/acpi/wakeup to allow enabling
the optional wakeup event sources. (David Shaohua Li)
http://bugzilla.kernel.org/show_bug.cgi?id=1415

2004/07/15 00:37:33-04:00 len.brown
[ACPI] ACPI bus support for wakeup GPE (David Shaohua Li)
http://bugzilla.kernel.org/show_bug.cgi?id=1415

2004/07/15 00:27:33-04:00 len.brown
[ACPI] IOAPIC suspend/resume (David Shaohua Li)
http://bugzilla.kernel.org/show_bug.cgi?id=3037

2004/07/14 15:47:04-04:00 len.brown
[ACPI] Tell the BIOS Linux can handle
Enhanced Speed Step (EST). (Venkatesh Pallipadi)
http://bugzilla.kernel.org/show_bug.cgi?id=2712

2004/07/14 15:39:55-04:00 len.brown
[ACPI] add SMP suport to processor driver (Venkatesh Pallipadi)
http://bugzilla.kernel.org/show_bug.cgi?id=2615

2004/07/14 15:35:54-04:00 len.brown
[ACPI] save/restore ELCR on suspend/resume (David Shaohua Li)
http://bugzilla.kernel.org/show_bug.cgi?id=2643

2004/07/14 14:47:30-04:00 len.brown
[ACPI] /proc/acpi/thermal_zone/THRM/cooling_mode
Add concept of (mandatory) "critical", when (optional)
"passive" and "active" are not present.  (Zhenyu Z Wang)
http://bugzilla.kernel.org/show_bug.cgi?id=1770

2004/07/14 12:43:29-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/14 01:21:43-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/14 00:34:54-04:00 len.brown
[ACPI] fix ability to set thermal trip points (Hugo Haas, Stefan Seyfried)
eg. # echo -n "100:90:80:70:60:50" > /proc/acpi/thermal_zone/THRM/trip_points
http://bugzilla.kernel.org/show_bug.cgi?id=2588

2004/07/13 16:49:41-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/13 16:39:21-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/11 22:05:34-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/07 13:53:29-04:00 len.brown
[ACPI] reserve EBDA for Dell BIOS that neglects to. (David Shaohua Li)
http://bugme.osdl.org/show_bug.cgi?id=2990

2004/07/07 13:47:23-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/06 00:41:36-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/03 13:05:08-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/07/02 23:13:23-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/06/29 16:42:19-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/06/29 03:35:42-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/06/24 03:27:39-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/06/24 03:17:03-04:00 len.brown
Merge intel.com:/home/lenb/bk/linux-2.6.8
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/06/24 01:43:06-04:00 len.brown
[ACPI] reserve IOPORTS for ACPI (David Shaohua Li)
http://bugzilla.kernel.org/show_bug.cgi?id=2641

2004/06/24 00:56:32-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/06/24 00:53:45-04:00 len.brown
[ACPI] enable GPE for ECDT (David Shaohua Li)

2004/06/23 20:25:40-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/src/linux-acpi-test-2.6.8

2004/06/23 17:01:29-04:00 len.brown
[ACPI] enable Embedded Controller (EC)'s
General Purpose Event (GPE) from David Shaohua Li

2004/06/23 01:23:32-04:00 len.brown
Merge intel.com:/home/lenb/src/linux-acpi-test-2.6.7
into intel.com:/home/lenb/bk/linux-acpi-test-2.6.7

2004/06/23 01:22:23-04:00 len.brown
[ACPI] fix return-from-sleep PM/ACPI state conversion bug (David Shaohua Li)

2004/06/22 16:27:51-04:00 len.brown
merge ACPICA

2004/06/22 15:56:16-04:00 len.brown
[ACPI] update EC GPE handler to new ACPICA handler type

2004/06/22 13:48:26-04:00 len.brown
[ACPI] ACPICA 20040615 from Bob Moore

Implemented support for Buffer and String objects (as
per ACPI 2.0) for the following ASL operators: LEqual,
LGreater, LLess, LGreaterEqual, and LLessEqual.

2004/06/22 13:42:17-04:00 len.brown
[ACPI] ACPICA 20040527 from Bob Moore

Completed a new design and implementation for EBDA
(Extended BIOS Data Area) support in the RSDP scan code.
The original code improperly scanned for the EBDA by simply
scanning from memory location 0 to 0x400.  The correct
method is to first obtain the EBDA pointer from within
the BIOS data area, then scan 1K of memory starting at the
EBDA pointer.  There appear to be few if any machines that
place the RSDP in the EBDA, however.
http://bugme.osdl.org/show_bug.cgi?id=2415

Integrated a fix for a possible fault during evaluation
of BufferField arguments.  Obsolete code that was causing
the problem was removed. (Asus laptop boot crash)
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121760

Found and fixed a problem in the Field Support Code
where data could be corrupted on a bit field read that
starts on an aligned boundary but does not end on an
aligned boundary.  Merged the read/write "datum length"
calculation code into a common procedure.

2004/06/22 13:15:18-04:00 len.brown
[ACPI] ACPICA 20040514 from Bob Moore

Fixed a problem where hardware GPE enable bits sometimes
not set properly during and after GPE method execution.
Result of ACPICA 20040427 changes.

Removed extra "clear all GPEs" when sleeping/waking.

Removed acpi_ht_enable_gpe and acpi_hw_disable_gpe, replaced
by the single acpi_hw_write_gpe_enable_reg. Changed a couple
of calls to the functions above to the new acpi_ev* calls
as appropriate.

ACPI_OS_NAME was removed from the OS-specific headers.
The default name is now "Microsoft Windows NT" for maximum
compatibility. However this can be changed by modifying
the acconfig.h file.  Fixes EHCI probe issue:
http://bugme.osdl.org/show_bug.cgi?id=1762

Allow a single invocation of acpi_install_notify_handler
for a handler that traps both types of notifies (System,
Device). Use ACPI_ALL_NOTIFY flag.

Run _INI methods on ThermalZone objects. This is against
the ACPI specification, but there is apparently ASL code
in the field that has these _INI methods, and apparently
"other" AML interpreters execute them.

Performed a full 16/32/64 bit lint that resulted in some
small changes.

2004/05/07 17:24:44-04:00 len.brown
[ACPI] ACPICA 20040427 from Bob Moore

Completed a major overhaul of the GPE handling within ACPI CA.
There are now three types of GPEs:
wake-only; runtime-only; combination wake/run.

The only GPEs allowed to be combination wake/run are for
button-style devices such as a control-method power button,
control-method sleep button, or a notebook lid switch.
GPEs that have an _Lxx or _Exx method and are not referenced
by any _PRW methods are marked for "runtime" and hardware enabled.

Any GPE that is referenced by a _PRW method is marked for "wake"
(and disabled at runtime).  However, at sleep time, only those
GPEs that have been specifically enabled for wake via the
acpi_enable_gpe() interface will actually be hardware enabled.

A new external interface has been added, acpi_set_gpe_type()
that is meant to be used by device drivers to force a GPE
to a particular type.  It will be especially useful for the
drivers for the button devices mentioned above.

Completed restructuring of the ACPI CA initialization sequence
so that default operation region handlers are installed
before GPEs are initialized and the _PRW methods are executed.
This will prevent errors when the _PRW methods attempt to
access system memory or I/O space.

GPE enable/disable no longer reads the GPE enable register.
We now keep the enable info for runtime and wake separate
and in the GPE_EVENT_INFO.  We thus no longer depend on
the hardware to maintain these bits.

Always clear the wake status and fixed/GPE status bits
before sleep, even for state S5.

Improved the AML debugger output for displaying the
GPE blocks and their current status.

Added new strings for the _OSI method, of the form
"Windows 2001 SPx" where x = 0,1,2,3,4.

Fixed a problem where the physical address was incorrectly
calculated when the Load() operator was used to directly
load from an Operation Region (vs. loading from a Field object.)
Also added check for minimum table length for this case.

Fix for multiple mutex acquisition.  Restore original thread
SyncLevel on mutex release.

Added ACPI_VALID_SXDS flag to the acpi_get_object_info interface
for consistency with the other fields returned.

Shrunk the ACPI_GPE_EVENT_INFO structure by 40%.
There is one such structure for each GPE in the system,
so the size of this structure is important.

CPU stack requirement reduction:
Cleaned up the method execution and object evaluation paths
so that now a parameter structure is passed, instead of copying
the various method parameters over and over again.

In evregion.c:
Correctly exit and reenter the interpreter region if and only
if dispatching an operation region request to a user-installed
handler. Do not exit/reenter when dispatching to a default
handler (e.g., default system memory or I/O handlers)

2004/05/07 17:21:19-04:00 len.brown
[ACPI] ACPICA 20040402 from Bob Moore

Fixed an interpreter problem where an indirect store through an
ArgX parameter was incorrectly applying the "implicit conversion
rules" during the store.  From the ACPI specification: "If the
target is a method local or argument (LocalX or ArgX), no
conversion is performed and the result is stored directly to the
target".  The new behavior is to disable implicit conversion
during ALL stores to an ArgX.

Changed the behavior of the _PRW method scan to ignore any and
all errors returned by a given _PRW.  This prevents the scan from
aborting from the failure of any single _PRW.

Moved the runtime configuration parameters from the global init
procedure to static variables in acglobal.h.  This will allow the
host to override the default values easily.

2004/05/03 12:31:49-04:00 len.brown
Cset exclude: torvalds-4GjXnd2cE15g9hUCZPvPmw@public.gmane.org|ChangeSet|20040401021818|60003

BKrev: 411defe8sbxIh2vfnPAM8r0e1cvGIg
----------------------------
revision 1.20858
date: 2004-08-14 10:54:09 +0000;  author: torvalds;  state: Exp;  lines: +0 -0
Linux 2.6.8.1

BKrev: 411def51bM_ces6kbPby7agFdSgYoA


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
