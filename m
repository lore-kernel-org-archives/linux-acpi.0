From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: BUG: power button doesn't generate events
Date: Sun, 20 Jul 2003 11:39:44 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2vftxghzj.fsf@tnuctip.rychter.com>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[I've sent a summarized bug report with several problems, but it seems
 to have gotten ignored, so I'll split it and report bugs one by one]

On a Toshiba Dynabook SS S7/290LNKW (Centrino-based), kernel 2.4.22-pre7
(also tested with pre5).

I get LID button events fine, but the power button doesn't seem to
generate any events

  button/lid LID 00000080 00000003
  button/lid LID 00000080 00000004
  battery BAT1 00000080 00000001
  ac_adapter ADP1 00000080 00000000
  processor CPU0 00000080 00000000
  ac_adapter ADP1 00000080 00000001
  processor CPU0 00000080 00000000
  battery BAT1 00000080 00000001
  battery BAT1 00000080 00000001

Does the following bit of DSDT mean the power button should generate
events?

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x08, 
                0x04
            })
            Name (_STA, 0x0B)
        }

DSDT at http://jan.rychter.com/acpi/toshiba.ss7.dsdt
bootup messages at http://jan.rychter.com/acpi/toshiba.dmesg

--J.


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
