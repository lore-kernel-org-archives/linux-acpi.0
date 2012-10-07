From: Ondrej Zary <linux@rainbow-software.org>
Subject: [bisected] PS/2 keyboard and mouse dead on resume on Intel D845BG
Date: Sun, 7 Oct 2012 15:13:27 +0200
Message-ID: <201210071513.27959.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,
Intel D845BG board comes out of S3 with PS/2 keyboard and mouse completely 
dead. The machine works otherwise (with USB keyboard or over network). When 
rebooted in this state, the BIOS hangs with blank screen. I have the latest 
BIOS installed (P08).

Old kernels worked. Bisection pointed to commit: 
b6dacf63e9fb2e7a1369843d6cef332f76fca6a3
(ACPI: Unconditionally set SCI_EN on resume)

Commenting out this line in drivers/acpi/sleep.c:
	acpi_write_bit_register(ACPI_BITREG_SCI_ENABLE, 1);
fixes the problem.

Any ideas why this breaks on this system?

-- 
Ondrej Zary
