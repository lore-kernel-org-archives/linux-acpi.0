From: Alexander Nyberg <alexn@telia.com>
Subject: Re: [PATCH] ACPI build fix for 2.6.12-rc5
Date: Fri, 27 May 2005 12:48:50 +0200
Message-ID: <1117190930.949.20.camel@localhost.localdomain>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
	 <20050527085326.GA29767@toshiba.hsd1.ma.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262433AbVE0Ksz@vger.kernel.org>
In-Reply-To: <20050527085326.GA29767@toshiba.hsd1.ma.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@toshiba.hsd1.ma.comcast.net>
Cc: ak@suse.de, torvalds@osdl.org, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

fre 2005-05-27 klockan 04:53 -0400 skrev Len Brown:
> Linus,
> Please apply this CONFIG_ACPI=n build fix to 2.6.12-rc5
> 
> thanks,
> Len
> 
> Fix 2.6.12 CONFIG_ACPI=n build regression.
> CONFIG_ACPI_BOOT shall be set only if CONFIG_ACPI.
>

You can still set CONFIG_ACPI_BOOT && !CONFIG_ACPI by choosing
CONFIG_PCI => CONFIG_PCI_MMCONFIG (doesn't build very well either).

Make CONFIG_ACPI_BOOT fully depend on CONFIG_ACPI

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: linux-2.6/arch/i386/Kconfig
===================================================================
--- linux-2.6.orig/arch/i386/Kconfig	2005-05-17 23:14:51.000000000 +0200
+++ linux-2.6/arch/i386/Kconfig	2005-05-27 12:33:42.000000000 +0200
@@ -1163,7 +1163,7 @@
 
 config PCI_MMCONFIG
 	bool
-	depends on PCI && (PCI_GOMMCONFIG || (PCI_GOANY && ACPI))
+	depends on PCI && ACPI && (PCI_GOMMCONFIG || PCI_GOANY)
 	select ACPI_BOOT
 	default y
 
Index: linux-2.6/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86_64/Kconfig	2005-05-17 23:14:53.000000000 +0200
+++ linux-2.6/arch/x86_64/Kconfig	2005-05-27 12:32:59.000000000 +0200
@@ -421,7 +421,7 @@
 
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access"
-	depends on PCI
+	depends on PCI && ACPI
 	select ACPI_BOOT
 
 config UNORDERED_IO
