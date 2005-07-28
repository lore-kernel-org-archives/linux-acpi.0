From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Re: [Alsa-devel] [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (1/2)
Date: Thu, 28 Jul 2005 13:18:56 +0200
Message-ID: <200507281318.57011.rjw@sisk.pl>
References: <200507261247.05684.rjw@sisk.pl> <200507281043.14697.rjw@sisk.pl> <1122540486.2903.8.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1122540486.2903.8.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
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
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, 28 of July 2005 10:48, Shaohua Li wrote:
> On Thu, 2005-07-28 at 10:43 +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Thursday, 28 of July 2005 10:06, Takashi Iwai wrote:
> > > At Wed, 27 Jul 2005 22:52:49 +0200,
> > > Pavel Machek wrote:
> > > > 
> > > > Hi!
> > > > 
> > > > > > The following patch adds free_irq() and request_irq() to the suspend and
> > > > > > resume, respectively, routines in the snd_intel8x0 driver.
> > > > > 
> > > > > The patch looks OK to me although I have some concerns.
> > > > > 
> > > > > - The error in resume can't be handled properly.
> > > > > 
> > > > >   What should we do for the error of request_irq()?
> > > > > 
> > > > > - Adding this to all drivers seem too much.
> > > > 
> > > > There's probably no other way. Talk to Len Brown.
> > > > 
> > > > >   We just need to stop the irq processing until resume, so something
> > > > >   like suspend_irq(irq, dev_id) and resume_irq(irq, dev_id) would be
> > > > >   more uesful?
> > > > 
> > > > Its more complex than that. Irq numbers may change during resume.
> > > 
> > > Hmm, then the patch looks wrong.  It assumes that the irq number is
> > > as same as before suspend.
> > 
> > Well, that''s the theory, but frankly I don't see a practical reason.  I have never
> > seen this happening.  Practically, for this to happen, you'll have to reconfigure
> > the BIOS accross suspend/resume which is dangerous anyway.
> From my understanding, we should not have such assumption. Say all
> device drivers with the same ioapic pin have freed irq. We might mask
> the ioapic pin and even free the vector. Then after you request_irq
> again, the interrupt might get different vector. If you enable MSI, then
> it's broken.
> In IA64, we already have such staff (mask ioapic pin and free vector).

All right then.  Still the patch is urgently needed for some systems that do
not have MSI and IMO the detection of the IRQ change can be implemented
on top of it.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
