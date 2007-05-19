From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Workaround for _PPC (BIOS cpufreq limitations)
Date: Sat, 19 May 2007 14:41:57 -0500
Message-ID: <1179603717.16465.71.camel@sublime.suse.de>
References: <1179543568.16465.35.camel@sublime.suse.de>
	 <200705190055.58626.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58965 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758243AbXEST4h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 May 2007 15:56:37 -0400
In-Reply-To: <200705190055.58626.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk

On Sat, 2007-05-19 at 00:55 -0400, Len Brown wrote:
> On Friday 18 May 2007 22:59, Thomas Renninger wrote:
> > Len, can you apply this one, pls.
> > 
> > Workaround for _PPC (BIOS cpufreq limitations)
> > 
> > There have been fixes using _PPC, which seem to unhide a problem
> > on HP nx6125 (double cpufreq switch freezes the machine for
> > several seconds).
> > This one should provide a workaround for the nx6125 and for
> > possible other machines that show any weird _PPC behaviour.
> 
> I don't understand what the failure is, and why this workaround
> is effective.  Is this a clue here to a real bug
> that requires a real fix, rather than a workaround?
I am not sure what the real cause is, the machine hangs because
CPU freq is limited and then all freqs are allowed again at the same
time.

Also this is a SLES bug, not sure whether this also happens in mainline.
(I mentioned that so if someone else with this machine experience that
problem he has a pointer).
The reason why I think this should go into mainline is because there
were
three patches concerning _PPC in the last months:
  - one from Bruno Ducrot (which I expect unhided the other problems)
  - one from Ingo Molnar (Do not read _PPC on startup - fixes some
ThinkPads)
  - one from me to get highest freq again if booted on battery/limited
freq.

I expect more machines have problems here (or will have in future) and
this is a nice
and easy possibility to workaround such problems, without loosing
frequency
scaling functionality.

    Thomas
> 
> -Len
> 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > 
> > ---
> >  drivers/acpi/processor_perflib.c |   16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6.21/drivers/acpi/processor_perflib.c
> > ===================================================================
> > --- linux-2.6.21.orig/drivers/acpi/processor_perflib.c
> > +++ linux-2.6.21/drivers/acpi/processor_perflib.c
> > @@ -60,6 +60,11 @@ static DEFINE_MUTEX(performance_mutex);
> >   * policy is adjusted accordingly.
> >   */
> >  
> > +static unsigned int ignore_ppc = 0;
> > +module_param(ignore_ppc, uint, 0644);
> > +MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> > +		 "limited by BIOS, this should help");
> > +
> >  #define PPC_REGISTERED   1
> >  #define PPC_IN_USE       2
> >  
> > @@ -72,6 +77,9 @@ static int acpi_processor_ppc_notifier(s
> >  	struct acpi_processor *pr;
> >  	unsigned int ppc = 0;
> >  
> > +	if (ignore_ppc)
> > +		return 0;
> > +
> >  	mutex_lock(&performance_mutex);
> >  
> >  	if (event != CPUFREQ_INCOMPATIBLE)
> > @@ -130,7 +138,13 @@ static int acpi_processor_get_platform_l
> >  
> >  int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
> >  {
> > -	int ret = acpi_processor_get_platform_limit(pr);
> > +	int ret;
> > +
> > +	if (ignore_ppc)
> > +		return 0;
> > +
> > +	ret = acpi_processor_get_platform_limit(pr);
> > +
> >  	if (ret < 0)
> >  		return (ret);
> >  	else
> > 
> > 

