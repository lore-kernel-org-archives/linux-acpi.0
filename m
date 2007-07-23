From: TJ <linux@tjworld.net>
Subject: Re: Any known issues of premature suspend?
Date: Mon, 23 Jul 2007 14:36:39 +0100
Message-ID: <1185197799.9798.4.camel@bagoas>
References: <S1761554AbXGVXPI/20070722231508Z+217@vger.kernel.org>
	 <1185153966.1346.29.camel@bagoas>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pella.tjworld.net ([72.249.12.25]:56673 "EHLO tjworld.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143AbXGWNgn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 09:36:43 -0400
In-Reply-To: <1185153966.1346.29.camel@bagoas>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Mon, 2007-07-23 at 02:26 +0100, TJ wrote:
> I'm currently debugging a weird issue where the PC appears to be
> attempting to S3 suspend prematurely in acpi_enter_sleep_state().

I added further debug messages to acpi_enter_sleep_state() and found
that the issue occurs when ACPI_FLUSH_CPU_CACHE() is called.

The log shows:

kernel: [  251.532000]  hwsleep-0285 [03] enter_sleep_state     :
Entering sleep state [S3]
kernel: [  251.532000]  hwsleep-0308 [03] enter_sleep_state     :
Writing PM1A (SLP_TYP data) 1401
kernel: [  251.532000]  hwsleep-0319 [03] enter_sleep_state     :
Writing PM1B (SLP_TYP data) 1401
kernel: [  251.532000]  hwsleep-0326 [03] enter_sleep_state     : Just
written PM1B (SLP_TYP data). status=0x0
kernel: [  251.532000]  hwsleep-0343 [03] enter_sleep_state     : About
to flush CPU cache
kernel: [  251.532000] Back to C!

The standard kernel build uses CONFIG_PARAVIRT so it appears that
paravirt_ops.wbinvd() is used to handle the flush.

I'm building a kernel without PARAVIRT now to see if it is the issue,
but I'm still in the dark as to why this would happen.

TJ.

---drivers/acpi/hardware/hwsleep.c::acpi_enter_sleep_state()----

	/* Write #2: SLP_TYP + SLP_EN */
#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "About to flush CPU cache\n"));
#endif

	ACPI_FLUSH_CPU_CACHE();

#ifdef DEBUG_RESUME
 ACPI_DEBUG_PRINT((ACPI_DB_INIT, "Writing PM1A (SLP_TYP + SLP_EN) %x\n",
PM1Acontrol));
#endif
 

