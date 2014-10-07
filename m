From: Thomas Richter <thor@math.tu-berlin.de>
Subject: =?UTF-8?B?W1BBVENIXcKgRnVqaXRzdSBleHRyYSBidXR0b25zIG5vdCB3b3JraW4=?=
 =?UTF-8?B?ZyBvbiBTNjAxMCwgVGhpbmtwYWQgRXh0cmEgYnV0dG9ucyBub3Qgd29ya2luZyA=?=
 =?UTF-8?B?b24gUjMx?=
Date: Tue, 07 Oct 2014 16:17:36 +0200
Message-ID: <5433F600.6010002@math.tu-berlin.de>
References: <29964_1412366647_542F0137_29964_4513_9_542EFC10.7020508@math.tu-berlin.de> <5432A957.2030205@math.tu-berlin.de> <29964_1412634435_54331741_29964_16384_1_8031540.z3p2ny3Gns@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-2.alumni.tu-berlin.de ([130.149.5.29]:33897 "EHLO
	mail-2.alumni.tu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753921AbaJGORm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Oct 2014 10:17:42 -0400
In-Reply-To: <29964_1412634435_54331741_29964_16384_1_8031540.z3p2ny3Gns@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: tianyu.lan@intel.com, paul.s.diefenbaugh@intel.com, jun.nakajima@intel.com, gjohnson@austin.ibm.com, lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org

Hi Rafael,

> And can you please actually post a patch?  The above is just a piece of C code
> entirely out of context.
Actually, it was rather supposed to start a discussion because I have 
almost no experience with the ACPI subsystem.

Anyhow, here is the same in a (hopefully) well-formed patch file, tested 
on a Fujitsu S6010 and an IBM R31 running
the 3.17 kernel.

Thanks,
     Thomas


Signed-off-by: Thomas Richter <thor@math.tu-berlin.de>
--- linux-3.17/arch/x86/kernel/acpi/boot.c.old  2014-10-07 
15:43:44.000000000 +0200
+++ linux-3.17/arch/x86/kernel/acpi/boot.c      2014-10-07 
16:04:33.000000000 +0200
@@ -609,9 +609,23 @@
         if (irq >= 0) {
                 *irqp = irq;
                 return 0;
-       }
+       } else {
+               unsigned int i;
+
+               for (i = 0; i < NR_IRQS_LEGACY; i++) {
+                       if (isa_irq_to_gsi[i] == gsi) {
+                               *irqp = i;
+                               return 0;
+                       }
+               }
+
+               if (gsi >= NR_IRQS_LEGACY)
+                       *irqp = gsi;
+               else
+                       *irqp = gsi_top + gsi;

-       return -1;
+               return 0;
+       }
  }
  EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);

