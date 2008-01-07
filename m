From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Sun, 6 Jan 2008 23:18:48 -0800
Message-ID: <20080106231848.762e93c1.akpm@linux-foundation.org>
References: <20071130142058.816d1693.akpm@linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>
	<4750CC78.9070105@rtr.ca>
	<20071130190227.1976e682@laptopd505.fenrus.org>
	<4750D180.6080001@rtr.ca>
	<20071130191816.3e744205@laptopd505.fenrus.org>
	<4750D585.1030200@rtr.ca>
	<477C2143.8090406@rtr.ca>
	<924EFEDD5F540B4284297C4DC59F3DEE4FC485@orsmsx423.amr.corp.intel.com>
	<477C622F.6010304@rtr.ca>
	<20080104021619.GA15409@linux-os.sc.intel.com>
	<47814958.3070208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755551AbYAGHTv@vger.kernel.org>
In-Reply-To: <47814958.3070208@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@infradead.org>, abelay@novell.com, lenb@kernel.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

On Sun, 06 Jan 2008 16:34:16 -0500 Mark Lord <lkml@rtr.ca> wrote:

> Venki Pallipadi wrote:
> > Reintroduce run time configurable max_cstate for !CPU_IDLE case.
> > 
> > Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > 
> > Index: linux-2.6.24-rc/drivers/acpi/processor_idle.c
> > ===================================================================
> > --- linux-2.6.24-rc.orig/drivers/acpi/processor_idle.c
> > +++ linux-2.6.24-rc/drivers/acpi/processor_idle.c
> > @@ -76,7 +76,11 @@ static void (*pm_idle_save) (void) __rea
> >  #define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
> >  
> >  static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
> > +#ifdef CONFIG_CPU_IDLE
> >  module_param(max_cstate, uint, 0000);
> > +#else
> > +module_param(max_cstate, uint, 0644);
> > +#endif
> >  static unsigned int nocst __read_mostly;
> >  module_param(nocst, uint, 0000);
> >  
> ..
> 
> Can we get this patch upstream so that a stock 2.6.24 will work here?
> 

umm, OK, I queued it for 2.6.24.  I'll give people a day or so to comment
on this.

I had to invent some silly changlelog for it.  Please review it for
accuracy and completeness?

It isn't complete, really.  How come we only make max_cstate writeable if
CONFIG_CPU_IDLE=n?  What happens to people who were reliant upon writeable
max_cstate who now enable CPU_IDLE?  Things still break?  What is the
rationale behind this?  What constraints led us to this decision?




From: Venki Pallipadi <venkatesh.pallipadi@intel.com>

This was writeable in 2.6.23 but the cpuidle merge made it read-only.  But
some people's scripts (ie: Mark's) were writing to it.

As an unhappy compromise, make max_cstate writeable again if the kernel was
configured without CONFIG_CPU_IDLE.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Mark Lord <lkml@rtr.ca>
Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_idle.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN drivers/acpi/processor_idle.c~reintroduce-run-time-configurable-max_cstate-for-cpu_idle-case drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~reintroduce-run-time-configurable-max_cstate-for-cpu_idle-case
+++ a/drivers/acpi/processor_idle.c
@@ -76,7 +76,11 @@ static void (*pm_idle_save) (void) __rea
 #define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
+#ifdef CONFIG_CPU_IDLE
 module_param(max_cstate, uint, 0000);
+#else
+module_param(max_cstate, uint, 0644);
+#endif
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
 
_

