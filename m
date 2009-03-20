From: Alessio Igor Bogani <abogani@texware.it>
Subject: Fwd: [PATCH] sony-laptop: Kill the BKL
Date: Fri, 20 Mar 2009 19:08:49 +0100
Message-ID: <63a49ef40903201108u38cb2956pbb0c3e2f9806d406@mail.gmail.com>
References: <1237572165-6494-1-git-send-email-abogani@texware.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63277 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbZCTSIw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Mar 2009 14:08:52 -0400
Received: by fxm2 with SMTP id 2so1013043fxm.37
        for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2009 11:08:49 -0700 (PDT)
In-Reply-To: <1237572165-6494-1-git-send-email-abogani@texware.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it, linux-acpi@vger.kernel.org

---------- Forwarded message ----------
=46rom: Alessio Igor Bogani <abogani@texware.it>
Date: 2009/3/20
Subject: [PATCH] sony-laptop: Kill the BKL
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alessio Igor Bogani <abogani@texware.it>


Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
=A0drivers/platform/x86/sony-laptop.c | =A0 12 ++++++++----
=A01 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c
b/drivers/platform/x86/sony-laptop.c
index 537959d..15f940b 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -46,7 +46,6 @@
=A0#include <linux/module.h>
=A0#include <linux/moduleparam.h>
=A0#include <linux/init.h>
-#include <linux/smp_lock.h>
=A0#include <linux/types.h>
=A0#include <linux/backlight.h>
=A0#include <linux/platform_device.h>
@@ -1934,10 +1933,15 @@ static int sonypi_misc_release(struct inode
*inode, struct file *file)
=A0static int sonypi_misc_open(struct inode *inode, struct file *file)
=A0{
=A0 =A0 =A0 =A0/* Flush input queue on first open */
- =A0 =A0 =A0 lock_kernel();
+ =A0 =A0 =A0 unsigned long flags;
+
+ =A0 =A0 =A0 spin_lock_irqsave(sonypi_compat.fifo->lock, flags);
+
=A0 =A0 =A0 =A0if (atomic_inc_return(&sonypi_compat.open_count) =3D=3D =
1)
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfifo_reset(sonypi_compat.fifo);
- =A0 =A0 =A0 unlock_kernel();
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __kfifo_reset(sonypi_compat.fifo);
+
+ =A0 =A0 =A0 spin_unlock_irqrestore(sonypi_compat.fifo->lock, flags);
+
=A0 =A0 =A0 =A0return 0;
=A0}

--
1.6.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
