From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: More experiences with 2.6.13-rc3 with ec_polling patch
Date: Mon, 25 Jul 2005 18:46:55 +0200
Message-ID: <200507251846.55852.rjw@sisk.pl>
References: <20050723133726.GA2079@miro.sinus.cz> <200507251407.55454.rjw@sisk.pl> <20050725152653.GA18227@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/dR5CkefSyN1xhj"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050725152653.GA18227-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_/dR5CkefSyN1xhj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday, 25 of July 2005 17:26, Pavel Troller wrote:
> > Hi,
> > 
> > The problem you describe is not related to the ec_polling patch (see below).
> I know. Sorry for bad formulation of the subject, I simply wanted to tell
> "more experiences with -rc3 after fixing that one with EC :-)".
> > 
> > 
> > This happens because the sound card should drop the IRQ during
> > suspend but it doesn't.  Please try to apply the patch at
> > 
> > http://bugzilla.kernel.org/attachment.cgi?id=5371&action=view
> > 
> > and let me know if that helps.
> It seems to help just a little:
> 1) The "Nobody cared" message with the backtrace is still there the same

Is the message:

handlers:
[<dc86e850>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])

still present in the backtrace with the patch?

> 2) ohci-hcd no more complains about wrong IRQ and inserts/removes OK
> .. but nevertheless, neither soundcard now USB is working.

That would mean the patch is needed anyway ...

> Of course I verified that the patch is there in the i8x0 code.

Can you please use the attached patch instead and put printk()s right before
free_irq() in intel8x0_suspend() and request_irq() in intel8x0_resume(),
and retest?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_/dR5CkefSyN1xhj
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.13-rc3-git5-intel8x0-suspend_resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.13-rc3-git5-intel8x0-suspend_resume.patch"

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

--Boundary-00=_/dR5CkefSyN1xhj--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
