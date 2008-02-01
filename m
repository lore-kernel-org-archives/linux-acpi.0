From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Thu, 31 Jan 2008 22:40:46 -0500
Message-ID: <200801312240.47405.lenb@kernel.org>
References: <200801301116.44902.rjw@sisk.pl> <871w7x5utp.fsf@paris.hilman.org> <200802010240.36693.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32812 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbYBADlf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jan 2008 22:41:35 -0500
In-Reply-To: <200802010240.36693.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@mvista.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Applied w/ Rafael's comment fixes included.

thanks,
-Len

On Thursday 31 January 2008 20:40, Rafael J. Wysocki wrote:
> On Friday, 1 of February 2008, Kevin Hilman wrote:
> > OK, one more (last?) time.  :)
> 
> Er, no.
> 
> > Convert cpu_idle_wait() to cpuidle_kick_cpus() macro which is
> > SMP-only, and gives error on non supported CPU.
> > 
> > Signed-off-by: Kevin Hilman <khilman@mvista.com>
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 80b7ba4..a3e8ef4 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -105,6 +105,9 @@ config ARCH_HAS_ILOG2_U32
> >  config ARCH_HAS_ILOG2_U64
> >  	def_bool n
> >  
> > +config ARCH_HAS_CPU_IDLE_WAIT
> > +	def_bool y
> > +
> >  config GENERIC_CALIBRATE_DELAY
> >  	def_bool y
> >  
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index d2fabe7..794962d 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -82,7 +82,7 @@ void cpuidle_uninstall_idle_handler(void)
> >  {
> >  	if (enabled_devices && (pm_idle != pm_idle_old)) {
> >  		pm_idle = pm_idle_old;
> > -		cpu_idle_wait();
> > +		cpuidle_kick_cpus();
> >  	}
> >  }
> >  
> > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > index c4e0016..b1c7355 100644
> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -72,6 +72,19 @@ cpuidle_set_statedata(struct cpuidle_state *state, void *data)
> >  	state->driver_data = data;
> >  }
> >  
> > +#ifdef CONFIG_SMP
> > +#ifdef CONFIG_ARCH_HAS_CPU_IDLE_WAIT
> > +static inline void cpuidle_kick_cpus(void)
> > +{
> > +	cpu_idle_wait()
> > +}
> > +#else /* !ARCH_HAS_CPU_IDLE_WAIT */
> 
> Please add the CONFIG_ here too.
> 
> > +#error "Arch needs cpu_idle_wait() equivalent here"
> > +#endif /* !ARCH_HAS_CPU_IDLE_WAIT */
> 
> And here.
> 
> > +#else /* !CONFIG_SMP */
> > +static inline void cpuidle_kick_cpus(void) {}
> > +#endif /* !CONFIG_SMP */
> > +
> >  struct cpuidle_state_kobj {
> >  	struct cpuidle_state *state;
> >  	struct completion kobj_unregister;
> > 
> 
> Thanks,
> Rafael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
