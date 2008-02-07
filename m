From: Len Brown <lenb@kernel.org>
Subject: [PATCH 092/112] PM: documentation cleanups
Date: Thu,  7 Feb 2008 04:34:54 -0500
Message-ID: <23b168d425ca0ca25257ff8205a39f1c2d1b0f27.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758405AbYBGJgx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:53 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, Pavel Machek <pavel@suse.cz>, Len Brown <len.brown@intel.com>

From: Pavel Machek <pavel@ucw.cz>

Signed-off-by: Pavel Machek <pavel@suse.cz>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    6 ++++--
 Documentation/power/swsusp.txt      |    5 +++++
 drivers/acpi/hardware/hwsleep.c     |    2 +-
 drivers/acpi/sleep/main.c           |    2 +-
 kernel/power/Kconfig                |    9 ++++++---
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 8fd5aa4..8ea41b6 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -147,8 +147,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			default: 0
 
 	acpi_sleep=	[HW,ACPI] Sleep options
-			Format: { s3_bios, s3_mode }
-			See Documentation/power/video.txt
+			Format: { s3_bios, s3_mode, s3_beep }
+			See Documentation/power/video.txt for s3_bios and s3_mode.
+			s3_beep is for debugging; it makes the PC's speaker beep
+			as soon as the kernel's real-mode entry point is called.
 
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index aea7e92..9d60ab7 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -386,6 +386,11 @@ before suspending; then remount them after resuming.
 There is a work-around for this problem.  For more information, see
 Documentation/usb/persist.txt.
 
+Q: Can I suspend-to-disk using a swap partition under LVM?
+
+A: No. You can suspend successfully, but you'll not be able to
+resume. uswsusp should be able to work with LVM. See suspend.sf.net.
+
 Q: I upgraded the kernel from 2.6.15 to 2.6.16. Both kernels were
 compiled with the similar configuration files. Anyway I found that
 suspend to disk (and resume) is much slower on 2.6.16 compared to
diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index fd1c4ba..058d0be 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -286,13 +286,13 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	}
 
 	/*
+	 * 1) Disable/Clear all GPEs
 	 * 2) Enable all wakeup GPEs
 	 */
 	status = acpi_hw_disable_all_gpes();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-
 	acpi_gbl_system_awake_and_running = FALSE;
 
 	status = acpi_hw_enable_all_wakeup_gpes();
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 485de13..c9a733f 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -170,7 +170,7 @@ static int acpi_pm_enter(suspend_state_t pm_state)
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(acpi_state);
 
-	/* ACPI 3.0 specs (P62) says that it's the responsabilty
+	/* ACPI 3.0 specs (P62) says that it's the responsibility
 	 * of the OSPM to clear the status bit [ implying that the
 	 * POWER_BUTTON event should not reach userspace ]
 	 */
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index ef9b802..7983317 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -74,8 +74,8 @@ config PM_TRACE_RTC
 	RTC across reboots, so that you can debug a machine that just hangs
 	during suspend (or more commonly, during resume).
 
-	To use this debugging feature you should attempt to suspend the machine,
-	then reboot it, then run
+	To use this debugging feature you should attempt to suspend the
+	machine, reboot it and then run
 
 		dmesg -s 1000000 | grep 'hash matches'
 
@@ -123,7 +123,10 @@ config HIBERNATION
 	  called "hibernation" in user interfaces.  STD checkpoints the
 	  system and powers it off; and restores that checkpoint on reboot.
 
-	  You can suspend your machine with 'echo disk > /sys/power/state'.
+	  You can suspend your machine with 'echo disk > /sys/power/state'
+	  after placing resume=/dev/swappartition on the kernel command line
+	  in your bootloader's configuration file.
+
 	  Alternatively, you can use the additional userland tools available
 	  from <http://suspend.sf.net>.
 
-- 
1.5.4.23.gef5b9

