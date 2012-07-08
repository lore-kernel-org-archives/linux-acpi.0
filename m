From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [3.4-rc5 -> 3.4-rc6 regression] Asus P5NSLI: lockup on resume
 from suspend
Date: Sun, 8 Jul 2012 04:04:32 -0500
Message-ID: <20120708090432.GF4625@burratino>
References: <op.wg3en6ij6g6bxc@localhost.localdomain>
 <Pine.LNX.4.44L0.1207072208270.508-100000@netrider.rowland.org>
 <20120708025730.GE2961@burratino>
 <op.wg30yabp6g6bxc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51860 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2GHJEh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2012 05:04:37 -0400
Received: by obbuo13 with SMTP id uo13so18500708obb.19
        for <linux-acpi@vger.kernel.org>; Sun, 08 Jul 2012 02:04:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <op.wg30yabp6g6bxc@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Octavio Alvarez <alvarezp@alvarezp.com>
Cc: Bob Moore <robert.moore@intel.com>, 680707@bugs.debian.org, linux-acpi@vger.kernel.org

Octavio Alvarez wrote:

> The problem is a full system lock-up on resume.
[...]
> I bisected the problem as requested by Alan Stern, and tracked it
> down to the following commit:
>
> commit 2feec47d4c5f80b05f1650f5a24865718978eea4
[...]
>     ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepControl registers

Parsing that commit:

 * new ACPICA-internal functions:
   acpi_hw_execute_SST, acpi_hw_extended_sleep, acpi_hw_legacy_sleep,
   acpi_hw_extended_wake_prep, acpi_hw_extended_wake,
   acpi_hw_legacy_wake_prep, acpi_hw_legacy_wake.

 * Various functions moved to hwxfsleep.c.

 * acpi_enter_sleep_state_s4bios was moved to before
   acpi_enter_sleep_state and acpi_enter_sleep_state_prep for no
   apparent reason.  Unchanged.

 * acpi_enter_sleep_state_prep: factored out execution of _SST
   (which sets System Status) into a helper.  No functional change.

 * acpi_enter_sleep_state: in the !(ACPI 5) case, just checks that
   the sleep types are not out of bounds and calls
   acpi_hw_legacy_sleep().  Functional change:

   - disable bus master arbitration when entering sleep states other
     than S5

   No other functional change.  _GTS ("Going To Sleep" hook) call
   factored out into a helper.

 * acpi_leave_sleep_state_prep: in the !(ACPI 5) case, just calls
   acpi_hw_legacy_wake_prep().  _BFS ("Back From Sleep" method) call
   factored out into a helper.  No functional change.

 * acpi_leave_sleep_state: in the !(ACPI 5) case, just calls
   acpi_hw_legacy_wake().  _SST calls factored out.  _WAK call
   factored out.  Functional change:

   - enable bus master arbitaration

   No other functional change.

So presumably it's the new writes to the ACPI_BITREG_ARB_DISABLE
register that cause trouble.  The patch below tests that guess.

Now for a complaint.  This would have been a lot easier if cleanups
that do not change behavior were split into separate commits --- one
commit per change.  That makes it easy to verify that each patch
correctly does what it promises with no unintended side effects.

Though I understand that hacking ACPICA is hard, and there is probably
a lot to the story of its development I don't know.

Thanks,
Jonathan

diff --git i/drivers/acpi/acpica/hwsleep.c w/drivers/acpi/acpica/hwsleep.c
index 0ed85cac3231..615996a36bed 100644
--- i/drivers/acpi/acpica/hwsleep.c
+++ w/drivers/acpi/acpica/hwsleep.c
@@ -95,18 +95,6 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state, u8 flags)
 		return_ACPI_STATUS(status);
 	}
 
-	if (sleep_state != ACPI_STATE_S5) {
-		/*
-		 * Disable BM arbitration. This feature is contained within an
-		 * optional register (PM2 Control), so ignore a BAD_ADDRESS
-		 * exception.
-		 */
-		status = acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 1);
-		if (ACPI_FAILURE(status) && (status != AE_BAD_ADDRESS)) {
-			return_ACPI_STATUS(status);
-		}
-	}
-
 	/*
 	 * 1) Disable/Clear all GPEs
 	 * 2) Enable all wakeup GPEs
@@ -364,16 +352,6 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state, u8 flags)
 				    [ACPI_EVENT_POWER_BUTTON].
 				    status_register_id, ACPI_CLEAR_STATUS);
 
-	/*
-	 * Enable BM arbitration. This feature is contained within an
-	 * optional register (PM2 Control), so ignore a BAD_ADDRESS
-	 * exception.
-	 */
-	status = acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
-	if (ACPI_FAILURE(status) && (status != AE_BAD_ADDRESS)) {
-		return_ACPI_STATUS(status);
-	}
-
 	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
 	return_ACPI_STATUS(status);
 }
