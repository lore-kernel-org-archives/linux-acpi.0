From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/140] i386: turn on CONFIG_PNP in defconfig
Date: Wed,  7 Feb 2007 13:50:38 -0500
Message-ID: <11708744062538-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:45778 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422733AbXBGSx2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:28 -0500
In-Reply-To: <11708744053556-git-send-email-lenb@kernel.org>
Message-Id: <10fccf5fda7529258325769e9da136064b481aab.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

I'm trying to remove drivers/acpi/motherboard.c, which is mostly
redundant with drivers/pnp/system.c.  So make sure that we include the
PNP driver in the default config.  Most distros enable this already.

Turning on CONFIG_PNP also causes the following options to be enabled:

    CONFIG_PNPACPI
    CONFIG_SERIAL_8250_PNP

CONFIG_SERIAL_8250_PNP causes legacy serial ports to be discovered
twice, which is ugly but harmless:

    serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
    00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/defconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/i386/defconfig b/arch/i386/defconfig
index 3265208..7792792 100644
--- a/arch/i386/defconfig
+++ b/arch/i386/defconfig
@@ -466,7 +466,8 @@ CONFIG_FW_LOADER=y
 #
 # Plug and Play support
 #
-# CONFIG_PNP is not set
+CONFIG_PNP=y
+CONFIG_PNPACPI=y
 
 #
 # Block devices
-- 
1.5.0.rc3.39.gec804
