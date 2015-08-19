From: Andreas Mohr <andi@lisas.de>
Subject: Re: pm: record / retain actual reason of last system wakeup??
Date: Wed, 19 Aug 2015 19:50:30 +0200
Message-ID: <20150819175030.GA4846@rhlx01.hs-esslingen.de>
References: <20150602190702.GA9112@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150602190702.GA9112@rhlx01.hs-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-acpi@vger.kernel.org

Hi,

[lkml.org info remains broken --> "special" reply rather than proper chain :(]

On Tue, Jun 02, 2015 at 09:07:02PM +0200, Andreas Mohr wrote:
> Hi,
> 
> I'm wondering whether we're actually recording / retaining
> any info about the precise reason for the machine wakeup
> that was responsible for having woken up the current (continued) session
> (e.g. WOL, RTC, configured keyboard wakeup, ...).

I was very happy to find that you are now actually working
on this remaining deficiency (kudos!):
"Re: [PATCH v5] Report interrupt(s) that caused system wakeup"
  https://lkml.org/lkml/2015/8/17/607

> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index d22786a6dbde..46068a1e0e07 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -21,7 +21,7 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
>                 desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
>                 desc->depth++;
>                 irq_disable(desc);
> -               pm_system_wakeup();
> +               pm_system_irq_wakeup(irq_desc_get_irq(desc));
>                 return true;
>         }
>         return false;


The way I see it is that perhaps the call interface
(various kernel layers to central pm layer)
could be something like
supplying minimal info
(performance!! no string handling, no complications, just numeric crap)
to central info layer (i.e., pm) -
proposed pm_system_irq_wakeup() signature
sounds exactly right here, BUT:
I would correct naming to use pm_system_wakeup_by_FOO() instead,
to properly retain the known prefix (pm_system_wakeup(), anyone?).
I.e.
pm_system_wakeup_by_irq()
pm_system_wakeup_by_timer() (which would be _by_irq() instead in most cases,
but perhaps sometimes not...).
and perhaps then still a
pm_system_wakeup_by_specific(const char *subsystem, const char *specifics).



And pm would then be able to publish this raw minimal information
submitted by various sub systems
in a sufficiently cooked, verbose, strictly defined future-proof manner
(originating subsystem info of wakeup source,
special identifier of wakeup source / specifics, ...).
And this cooked data
assembled upon user space query time only ideally
(cook up info strings from pre-submitted literals once requested).



Rather than using
/sys/power/ named:pm_last_wakeup_irqs
( https://lkml.org/lkml/2015/8/17/607 )

one could name it more generically e.g.
pm_last_wakeup_source
or possibly better
pm_last_wakeup_reason
or
pm_last_wakeup_reason_info
only,
with content format then being something like

[subsystem description]: [subsystem specifics]

, e.g.:

ACPI IRQ: 13

platform IRQ: 72

GPIO button: 13
   (would usually be configured/notified via IRQ subsystem instead though)

However the question then could be
whether its content would remain simple enough,
else necessitating higher parser complexity on clients' side
(or should instead split sysfs interface
into pm_last_wakeup_reason_type [or ..._info?]
and pm_last_wakeup_reason_details nodes?
- c.f. sysfs node design guidelines somewhere below Documentation/ or so...).


Anyway, we probably should not use
per-subsystem nodes such as pm_last_wakeup_irqs
since we might then end up having to offer *multiple* nodes
with the user then having to figure out
which particular node
actually currently provides info about last wakeup.

Thanks,

Andreas Mohr
