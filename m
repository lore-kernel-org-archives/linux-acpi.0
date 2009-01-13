From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] : ACPI : Use clocksource to get the C-state time
	instead	of ACPI PM timer
Date: Tue, 13 Jan 2009 09:26:10 +0800
Message-ID: <1231809970.4026.83.camel@yakui_zhao.sh.intel.com>
References: <20081031184233.8588.42241.stgit@thinkpad>
	 <1231744070.4026.56.camel@yakui_zhao.sh.intel.com>
	 <20090112220941.GA1446@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42304 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756960AbZAMBPD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2009 20:15:03 -0500
In-Reply-To: <20090112220941.GA1446@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: LenBrown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-01-13 at 06:09 +0800, Pallipadi, Venkatesh wrote:
> 
> Patch looks ok in general. However, I am wonderng whether we reall need
> ktime_get() here or can we use getnstimeofday() directly. Using
It will also be OK to use the function of getnstimeofday(). 
In fact the main part of ktime_get is to call the function of
getnstimeofday.
And the monotonic time is returned by ktime_get. 

> getnstimeofday() should be cheaper, especially if we are doing frequent
> calls from multiple CPUs on every idle enter/exit. And I don't think we
> need to worry about monotonic clock from ktime here...

> 
> Thanks,
> Venki
> 
> On Sun, Jan 11, 2009 at 11:07:50PM -0800, Zhao, Yakui wrote:
> > Subject: ACPI: Use clocksource to get the C-state time instead of ACPI PM timer
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> >     On most boxes the ACPI PM timer is 24-bit counter that runs on 3.579545MHz
> > clock. In such case the max C-state sleep time should be less than 4687ms when
> > it is used to record C2/C3 duration time. 
> >     But on some boxes the max C-state sleep time is more than 4687ms. In such
> > case the overflow happens and the C-state duration time can't be counted
> > accurately.
> >     Use clocksource to get the C-state time instead of ACPI PM timer
> > 
> > Signed-off-by: Yakui Zhao <yakui.zhao@intel.com>
> > Signed-off-by: Alexs Shi <alex.shi@intel.com>
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > ---
> >  drivers/acpi/processor_idle.c |   68 +++++++++++++++++++++++++-----------------
> >  1 file changed, 42 insertions(+), 26 deletions(-)
> > 
> > Index: linux-2.6/drivers/acpi/processor_idle.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/processor_idle.c
> > +++ linux-2.6/drivers/acpi/processor_idle.c
> > @@ -397,8 +397,8 @@ static void acpi_processor_idle(void)
> >  	struct acpi_processor_cx *cx = NULL;
> >  	struct acpi_processor_cx *next_state = NULL;
> >  	int sleep_ticks = 0;
> > -	u32 t1, t2 = 0;
> > -
> > +	ktime_t kt1, kt2;
> > +	u64 sleep_interval;
> >  	/*
> >  	 * Interrupts must be disabled during bus mastering calculations and
> >  	 * for C2/C3 transitions.
> > @@ -543,23 +543,26 @@ static void acpi_processor_idle(void)
> >  		break;
> >  
> >  	case ACPI_STATE_C2:
> > -		/* Get start time (ticks) */
> > -		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > +		kt1 = ktime_get();
> >  		/* Tell the scheduler that we are going deep-idle: */
> >  		sched_clock_idle_sleep_event();
> >  		/* Invoke C2 */
> >  		acpi_state_timer_broadcast(pr, cx, 1);
> >  		acpi_cstate_enter(cx);
> >  		/* Get end time (ticks) */
> > -		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > -
> > +		kt2 = ktime_get();
> >  #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
> >  		/* TSC halts in C2, so notify users */
> >  		if (tsc_halts_in_c(ACPI_STATE_C2))
> >  			mark_tsc_unstable("possible TSC halt in C2");
> >  #endif
> > +		/*
> > +		 * Use the function of ktime_sub to get the time interval and
> > +		 * then convert it to microsecond
> > +		 */
> > +		sleep_interval = ktime_to_us(ktime_sub(kt2, kt1));
> >  		/* Compute time (ticks) that we were actually asleep */
> > -		sleep_ticks = ticks_elapsed(t1, t2);
> > +		sleep_ticks = US_TO_PM_TIMER_TICKS(sleep_interval);
> >  
> >  		/* Tell the scheduler how much we idled: */
> >  		sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
> > @@ -605,13 +608,13 @@ static void acpi_processor_idle(void)
> >  		}
> >  
> >  		/* Get start time (ticks) */
> > -		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > +		kt1 = ktime_get();
> >  		/* Invoke C3 */
> >  		/* Tell the scheduler that we are going deep-idle: */
> >  		sched_clock_idle_sleep_event();
> >  		acpi_cstate_enter(cx);
> >  		/* Get end time (ticks) */
> > -		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > +		kt2 = ktime_get();
> >  		if (pr->flags.bm_check && pr->flags.bm_control) {
> >  			/* Enable bus master arbitration */
> >  			atomic_dec(&c3_cpu_count);
> > @@ -623,8 +626,13 @@ static void acpi_processor_idle(void)
> >  		if (tsc_halts_in_c(ACPI_STATE_C3))
> >  			mark_tsc_unstable("TSC halts in C3");
> >  #endif
> > +		/*
> > +		 * Use the function of ktime_sub to get the time interval
> > +		 * and convert it to microsecond.
> > +		 */
> > +		sleep_interval = ktime_to_us(ktime_sub(kt2, kt1));
> >  		/* Compute time (ticks) that we were actually asleep */
> > -		sleep_ticks = ticks_elapsed(t1, t2);
> > +		sleep_ticks = US_TO_PM_TIMER_TICKS(sleep_interval);
> >  		/* Tell the scheduler how much we idled: */
> >  		sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
> >  
> > @@ -1455,7 +1463,8 @@ static inline void acpi_idle_do_entry(st
> >  static int acpi_idle_enter_c1(struct cpuidle_device *dev,
> >  			      struct cpuidle_state *state)
> >  {
> > -	u32 t1, t2;
> > +	ktime_t kt1, kt2;
> > +	u64 sleep_interval;
> >  	struct acpi_processor *pr;
> >  	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
> >  
> > @@ -1476,14 +1485,18 @@ static int acpi_idle_enter_c1(struct cpu
> >  	if (pr->flags.bm_check)
> >  		acpi_idle_update_bm_rld(pr, cx);
> >  
> > -	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > +	kt1 = ktime_get();
> >  	acpi_idle_do_entry(cx);
> > -	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > +	kt2 = ktime_get();
> >  
> >  	local_irq_enable();
> >  	cx->usage++;
> > -
> > -	return ticks_elapsed_in_us(t1, t2);
> > +	/*
> > +	 * Use the ktime_sub to get the time interval and then convert
> > +	 * it to microseconds
> > +	 */
> > +	sleep_interval = ktime_to_us(ktime_sub(kt2, kt1));
> > +	return sleep_interval;
> >  }
> >  
> >  /**
> > @@ -1496,7 +1509,8 @@ static int acpi_idle_enter_simple(struct
> >  {
> >  	struct acpi_processor *pr;
> >  	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
> > -	u32 t1, t2;
> > +	ktime_t kt1, kt2;
> > +	u64 sleep_interval;
> >  	int sleep_ticks = 0;
> >  
> >  	pr = __get_cpu_var(processors);
> > @@ -1533,18 +1547,19 @@ static int acpi_idle_enter_simple(struct
> >  	if (cx->type == ACPI_STATE_C3)
> >  		ACPI_FLUSH_CPU_CACHE();
> >  
> > -	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > +	kt1 = ktime_get();
> >  	/* Tell the scheduler that we are going deep-idle: */
> >  	sched_clock_idle_sleep_event();
> >  	acpi_idle_do_entry(cx);
> > -	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > +	kt2 = ktime_get();
> >  
> >  #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
> >  	/* TSC could halt in idle, so notify users */
> >  	if (tsc_halts_in_c(cx->type))
> >  		mark_tsc_unstable("TSC halts in idle");;
> >  #endif
> > -	sleep_ticks = ticks_elapsed(t1, t2);
> > +	sleep_interval = ktime_to_us(ktime_sub(kt2, kt1));
> > +	sleep_ticks = US_TO_PM_TIMER_TICKS(sleep_interval);
> >  
> >  	/* Tell the scheduler how much we idled: */
> >  	sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
> > @@ -1556,7 +1571,7 @@ static int acpi_idle_enter_simple(struct
> >  
> >  	acpi_state_timer_broadcast(pr, cx, 0);
> >  	cx->time += sleep_ticks;
> > -	return ticks_elapsed_in_us(t1, t2);
> > +	return sleep_interval;
> >  }
> >  
> >  static int c3_cpu_count;
> > @@ -1574,7 +1589,8 @@ static int acpi_idle_enter_bm(struct cpu
> >  {
> >  	struct acpi_processor *pr;
> >  	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
> > -	u32 t1, t2;
> > +	ktime_t  kt1, kt2;
> > +	u64 sleep_interval;
> >  	int sleep_ticks = 0;
> >  
> >  	pr = __get_cpu_var(processors);
> > @@ -1643,10 +1659,9 @@ static int acpi_idle_enter_bm(struct cpu
> >  	} else if (!pr->flags.bm_check) {
> >  		ACPI_FLUSH_CPU_CACHE();
> >  	}
> > -
> > -	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > +	kt1 = ktime_get();
> >  	acpi_idle_do_entry(cx);
> > -	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
> > +	kt2 = ktime_get();
> >  
> >  	/* Re-enable bus master arbitration */
> >  	if (pr->flags.bm_check && pr->flags.bm_control) {
> > @@ -1661,7 +1676,8 @@ static int acpi_idle_enter_bm(struct cpu
> >  	if (tsc_halts_in_c(ACPI_STATE_C3))
> >  		mark_tsc_unstable("TSC halts in idle");
> >  #endif
> > -	sleep_ticks = ticks_elapsed(t1, t2);
> > +	sleep_interval = ktime_to_us(ktime_sub(kt2, kt1));
> > +	sleep_ticks = US_TO_PM_TIMER_TICKS(sleep_interval);
> >  	/* Tell the scheduler how much we idled: */
> >  	sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
> >  
> > @@ -1672,7 +1688,7 @@ static int acpi_idle_enter_bm(struct cpu
> >  
> >  	acpi_state_timer_broadcast(pr, cx, 0);
> >  	cx->time += sleep_ticks;
> > -	return ticks_elapsed_in_us(t1, t2);
> > +	return sleep_interval;
> >  }
> >  
> >  struct cpuidle_driver acpi_idle_driver = {
> > 
> > 

