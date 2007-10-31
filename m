From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH 1/2] Sonypi: use synchronize_irq instead of sycnronize_sched
Date: Wed, 31 Oct 2007 00:41:54 -0400
Message-ID: <200710310041.54252.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxsf00.insightbb.com ([74.128.0.70]:25624 "EHLO
	mxsf00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbXJaEmM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2007 00:42:12 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

Hi Mattia,

It looks like you are also looking after sonypi...

-- 
Dmitry

Subject: Sonypi: use synchronize_irq instead of sycnronize_sched
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We know exactly what IRQ we are using, so synchronize_irq()
suits much better. Plus synchronize_sched() will not work
for us in -rt kernels.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/char/sonypi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/char/sonypi.c
===================================================================
--- linux.orig/drivers/char/sonypi.c
+++ linux/drivers/char/sonypi.c
@@ -1432,7 +1432,7 @@ static int __devexit sonypi_remove(struc
 {
 	sonypi_disable();
 
-	synchronize_sched();  /* Allow sonypi interrupt to complete. */
+	synchronize_irq(sonypi_device.irq);
 	flush_scheduled_work();
 
 	if (useinput) {
