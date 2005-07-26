From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (1/2)
Date: Tue, 26 Jul 2005 12:51:47 +0200
Message-ID: <200507261251.48291.rjw@sisk.pl>
References: <200507261247.05684.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507261247.05684.rjw-KKrjLPT3xs0@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The following patch adds free_irq() and request_irq() to the suspend and
resume, respectively, routines in the snd_intel8x0 driver.

Signed-off-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>

--- linux-2.6.13-rc3-git5/sound/pci/intel8x0.c	2005-07-23 19:26:43.000000000 +0200
+++ patched/sound/pci/intel8x0.c	2005-07-25 18:21:36.000000000 +0200
@@ -2373,6 +2373,8 @@ static int intel8x0_suspend(snd_card_t *
 	for (i = 0; i < 3; i++)
 		if (chip->ac97[i])
 			snd_ac97_suspend(chip->ac97[i]);
+	if (chip->irq >= 0)
+		free_irq(chip->irq, (void *)chip);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -2384,7 +2386,14 @@ static int intel8x0_resume(snd_card_t *c
 
 	pci_enable_device(chip->pci);
 	pci_set_master(chip->pci);
-	snd_intel8x0_chip_init(chip, 0);
+	if (request_irq(chip->irq, snd_intel8x0_interrupt, SA_INTERRUPT|SA_SHIRQ, card->shortname, (void *)chip)) {
+		snd_printk("unable to grab IRQ %d\n", chip->irq);
+		chip->irq = -1;
+		pci_disable_device(chip->pci);
+		return -EBUSY;
+	}
+	synchronize_irq(chip->irq);
+	snd_intel8x0_chip_init(chip, 1);
 
 	/* refill nocache */
 	if (chip->fix_nocache)


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
