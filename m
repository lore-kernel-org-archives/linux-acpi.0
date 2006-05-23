From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH] -mm: make ACPI errata __read_mostly
Date: Tue, 23 May 2006 20:53:08 +0200
Message-ID: <20060523185308.GA10827@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:18616 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932264AbWEWSxJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 May 2006 14:53:09 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hello all,

this may be quite useful given frequent ACPI idle invocation...

i386 run-tested on 2.6.17-rc4-mm3.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/drivers/acpi/processor_core.c linux-2.6.17-rc4-mm3.my/drivers/acpi/processor_core.c
--- linux-2.6.17-rc4-mm3.orig/drivers/acpi/processor_core.c	2006-05-23 19:14:14.000000000 +0200
+++ linux-2.6.17-rc4-mm3/drivers/acpi/processor_core.c	2006-05-22 15:47:05.000000000 +0200
@@ -110,7 +110,7 @@
 };
 
 struct acpi_processor *processors[NR_CPUS];
-struct acpi_processor_errata errata;
+struct acpi_processor_errata errata __read_mostly;
 
 /* --------------------------------------------------------------------------
                                 Errata Handling
