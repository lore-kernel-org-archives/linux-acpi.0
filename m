From: Len Brown <lenb@toshiba.hsd1.ma.comcast.net>
Subject: [PATCH] ACPI build fix for 2.6.12-rc5
Date: Fri, 27 May 2005 04:53:27 -0400
Message-ID: <20050527085326.GA29767@toshiba.hsd1.ma.comcast.net>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262355AbVE0Ise@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@osdl.org
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Linus,
Please apply this CONFIG_ACPI=n build fix to 2.6.12-rc5

thanks,
Len

Fix 2.6.12 CONFIG_ACPI=n build regression.
CONFIG_ACPI_BOOT shall be set only if CONFIG_ACPI.

Signed-off-by: Len Brown <len.brown@intel.com>

--- linux-2.6.12-rc5/drivers/acpi/Kconfig.orig	2005-05-27 04:34:21.000000000 -0400
+++ linux-2.6.12-rc5/drivers/acpi/Kconfig	2005-05-27 04:07:52.000000000 -0400
@@ -40,13 +40,12 @@ config ACPI
 	  available at:
 	  <http://www.acpi.info>
 
+if ACPI
+
 config ACPI_BOOT
 	bool
-	depends on ACPI || X86_HT
 	default y
 
-if ACPI
-
 config ACPI_INTERPRETER
 	bool
 	depends on !IA64_SGI_SN
