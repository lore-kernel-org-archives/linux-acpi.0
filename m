From: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Subject: S4 sleep woes
Date: Fri, 30 Jul 2004 13:06:15 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040730050615.GA24597@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The following bug was observed when using Software Suspend 2
(softwaresuspend.berlios.de), but the bug itself lies in the ACPI
code (neither in-kernel suspend-to-disk implementations work on my
laptop, so I can't test it).

Recent versions of Software Suspend 2 have an option to use ACPI S4
support to halt the machine, that (indirectly) calls
acpi_pm_prepare(4) and acpi_pm_enter(4).

The problem is that by default, this makes my machine hang with the
sleep light flashing instead of powering off.

In 2.6.7:

>From drivers/acpi/sleep/main.c (acpi_sleep_init):

        if (i == ACPI_STATE_S4) {
            if (acpi_gbl_FACS->S4bios_f) {
                sleep_states[i] = 1;
                printk(" S4bios");
                acpi_pm_ops.pm_disk_mode = PM_DISK_FIRMWARE; <---
            } else if (sleep_states[i])
                acpi_pm_ops.pm_disk_mode = PM_DISK_PLATFORM; <---
        }

With reference to the lines pointed out, if the machine claims that
its BIOS supports S4 itself, then pm_disk_mode is set to
PM_DISK_FIRMWARE.

Later on, in acpi_pm_enter:
    case PM_SUSPEND_DISK:
        if (acpi_pm_ops.pm_disk_mode == PM_DISK_PLATFORM)
            status = acpi_enter_sleep_state(acpi_state);
        else
            do_suspend_lowlevel_s4bios();
        break;

Hence, if pm_disk_mode is PM_DISK_FIRMWARE (because the BIOS claims
it can do S4), then do_suspend_lowlevel_s4bios() is called.

Now, according to the ACPI spec (2.0c, section 9.1.4.2 - The S4BIOS
transition), "the BIOS then saves the appropriate memory and chip
set context, and then places the platform into the S4 state (power
off to all devices)."

In the pmdisk/swsusp/software-suspend-2 case, this clearly isn't
desirable, as we've just saved memory ourselves.

If I force pm_disk_mode = PM_DISK_PLATFORM, then my machine uses
acpi_enter_sleep_state in order to sleep, and all works well. It
does shutdown as intended, and even better, shaves about 10 seconds
off the 30 second BIOS boot time when resuming.

>From what I gather, with pmdisk or swsusp, pm_disk_mode should never
be PM_DISK_FIRMWARE, as that essentially asks the BIOS to do S4 for
us.

Thoughts?

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
