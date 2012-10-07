From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [bisected] PS/2 keyboard and mouse dead on resume on Intel D845BG
Date: Sun, 7 Oct 2012 21:00:09 +0200
Message-ID: <201210072100.09813.linux@rainbow-software.org>
References: <201210071513.27959.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-1-out2.atlantis.sk ([80.94.52.71]:46857 "EHLO
	mail.atlantis.sk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753319Ab2JGTBA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Oct 2012 15:01:00 -0400
In-Reply-To: <201210071513.27959.linux@rainbow-software.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sunday 07 October 2012 15:13:27 Ondrej Zary wrote:
> Hello,
> Intel D845BG board comes out of S3 with PS/2 keyboard and mouse completely
> dead. The machine works otherwise (with USB keyboard or over network). When
> rebooted in this state, the BIOS hangs with blank screen. I have the latest
> BIOS installed (P08).
>
> Old kernels worked. Bisection pointed to commit:
> b6dacf63e9fb2e7a1369843d6cef332f76fca6a3
> (ACPI: Unconditionally set SCI_EN on resume)
>
> Commenting out this line in drivers/acpi/sleep.c:
> 	acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
> fixes the problem.
>
> Any ideas why this breaks on this system?

Added acpi_read_bit_register there and it seems that SCI_EN is already set!

This patch fixes the problem here. I wonder how this affects systems that
require SCI_EN to be set.

--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -271,6 +271,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	acpi_status status = AE_OK;
 	u32 acpi_state = acpi_target_sleep_state;
 	int error;
+	u32 sci_enabled;
 
 	ACPI_FLUSH_CPU_CACHE();
 
@@ -289,7 +290,9 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	}
 
 	/* This violates the spec but is required for bug compatibility. */
-	acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
+	acpi_read_bit_register(ACPI_BITREG_SCI_ENABLE, &sci_enabled);
+	if (!sci_enabled)
+		acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
 
 	/* Reprogram control registers */
 	acpi_leave_sleep_state_prep(acpi_state);

-- 
Ondrej Zary
