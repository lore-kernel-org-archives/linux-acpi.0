From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] make arch/i386/kernel/acpi/boot.c:acpi_force static
Date: Mon, 7 Aug 2006 17:49:38 +0200
Message-ID: <20060807154938.GC3691@stusta.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7439 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932178AbWHGPtk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Aug 2006 11:49:40 -0400
Content-Disposition: inline
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

acpi_force can become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc3-mm2-full/arch/i386/kernel/acpi/boot.c.old	2006-08-07 15:56:19.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/arch/i386/kernel/acpi/boot.c	2006-08-07 15:56:28.000000000 +0200
@@ -37,7 +37,7 @@
 #include <asm/io.h>
 #include <asm/mpspec.h>
 
-int __initdata acpi_force = 0;
+static int __initdata acpi_force = 0;
 
 #ifdef	CONFIG_ACPI
 int acpi_disabled = 0;

