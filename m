From: TJ <linux@tjworld.net>
Subject: Any known issues of premature suspend?
Date: Mon, 23 Jul 2007 02:26:06 +0100
Message-ID: <1185153966.1346.29.camel@bagoas>
References: <S1761554AbXGVXPI/20070722231508Z+217@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pella.tjworld.net ([72.249.12.25]:38619 "EHLO tjworld.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758118AbXGWBcv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 21:32:51 -0400
In-Reply-To: <S1761554AbXGVXPI/20070722231508Z+217@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm currently debugging a weird issue where the PC appears to be
attempting to S3 suspend prematurely in acpi_enter_sleep_state().

The PC is a Sony Vaio PCG-SRX51P/B notebook (Intel 850MHz, 384MB, kernel
2.6.20-16) with Ubuntu 7.04 Feisty 32-bit with CONFIG_ACPI_DEBUG.

I added some additional debug messages to acpi_enter_sleep_state() and
find that after the 1st write to "PM1B (SLP_TYP data)" but before
writing "PM1A (SLP_TYP + SLP_EN)" the PC appears to suspend prematurely,
and then instantly comes back with "Back to C!".

It doesn't seem to fail via the ACPI_FAILURE()... return_ACPI_STATUS()
logic as far as I can tell.

Here's the log entries:

kernel: [  328.044000]  hwsleep-0285 [03] enter_sleep_state     :
Entering sleep state [S3]
kernel: [  328.044000]  hwsleep-0308 [03] enter_sleep_state     :
Writing PM1A (SLP_TYP data) 1401
kernel: [  328.044000]  hwsleep-0319 [03] enter_sleep_state     :
Writing PM1B (SLP_TYP data) 1401
kernel: [  328.044000]  hwsleep-0326 [03] enter_sleep_state     : Just
written PM1B (SLP_TYP data). status=0x0
kernel: [  328.044000] Back to C!

Any ideas?

TJ.

-----drivers/acpi/hardware/hwsleep.c::acpi_enter_sleep_state()----
	/* Write #1: fill in SLP_TYP data */
 
#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "Writing PM1A (SLP_TYP data) %x\n",
PM1Acontrol));
#endif

	status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
					ACPI_REGISTER_PM1A_CONTROL,
					PM1Acontrol);
	if (ACPI_FAILURE(status)) {
		return_ACPI_STATUS(status);
	}

#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "Writing PM1B (SLP_TYP data) %x\n",
PM1Bcontrol));
#endif

  status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
					ACPI_REGISTER_PM1B_CONTROL,
					PM1Bcontrol);
#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "Just written PM1B (SLP_TYP data).
status=0x%x\n", status));
#endif
	if (ACPI_FAILURE(status)) {
#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "Failed writing PM1B (SLP_TYP data).
status=0x%x\n", status));
#endif

		return_ACPI_STATUS(status);
	}

	/* Insert SLP_ENABLE bit */

	PM1Acontrol |= sleep_enable_reg_info->access_bit_mask;
	PM1Bcontrol |= sleep_enable_reg_info->access_bit_mask;

	/* Write #2: SLP_TYP + SLP_EN */
#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "About to flush CPU cache\n"));
#endif

	ACPI_FLUSH_CPU_CACHE();

#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "Writing PM1A (SLP_TYP + SLP_EN) %x\n",
PM1Acontrol));
#endif
 
	status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
					ACPI_REGISTER_PM1A_CONTROL,
					PM1Acontrol);
	if (ACPI_FAILURE(status)) {
		return_ACPI_STATUS(status);
	}

#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "Writing PM1B (SLP_TYP + SLP_EN) %x\n",
PM1Bcontrol));
#endif
 
	status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
					ACPI_REGISTER_PM1B_CONTROL,
					PM1Bcontrol);
	if (ACPI_FAILURE(status)) {
		return_ACPI_STATUS(status);
	}

#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "Just done sleep S3\n"));
#endif


