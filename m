From: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Subject: Re: [BK PATCH] ACPI updates
Date: Fri, 22 Nov 2002 12:33:56 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0211221231120.10169-100000@penguin.transmeta.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A51A@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A51A-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Andrew,
 did you see the attached report?

Basically, it appears that the ACPI irq routing returns entries that are 
bigger than NR_IRQS, which is a no-no.

Admittedly the IDE layer is also doing bad things (it shouldn't disable 
irq's that it hasn'e registered yet, and it would have failed to register 
a bad irq number), but it looks like (a) there are bad ACPI tables around 
(big surprise, not!) and (b) Linux acpi doesn't sanity-test the values 
properly.

		Linus

---
From: OGAWA Hirofumi <hirofumi-UIVanBePwB70ZhReMnHkpc8NsWr+9BEh@public.gmane.org>
Date: Fri Nov 22 06:53:33 PST 2002

It seems ACPI assigned 255 to IRQ, so disable_irq() did oops.
The following is my stupid patch. I hope this info helps.

--- linux-2.5.47/drivers/ide/ide-probe.c~ide-kludge     2002-11-14 02:41:40.000000000 +0900
+++ linux-2.5.47-hirofumi/drivers/ide/ide-probe.c       2002-11-14 02:41:40.000000000 +0900
@@ -654,6 +654,8 @@ void probe_hwif (ide_hwif_t *hwif)
         * We must always disable IRQ, as probe_for_drive will assert IRQ, but
         * we'll install our IRQ driver much later...
         */
+       if (hwif->irq == 255)
+               hwif->irq = 0;
        irqd = hwif->irq;
        if (irqd)
                disable_irq(hwif->irq);




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
