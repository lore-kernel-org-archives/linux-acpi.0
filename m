From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Thu, 16 Nov 2006 08:53:48 -0800
Message-ID: <200611160853.48748.david-b@pacbell.net>
References: <200611142303.47325.david-b@pacbell.net> <200611160803.04152.david-b@pacbell.net> <455C907A.8080600@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:6569 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031200AbWKPQxy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Nov 2006 11:53:54 -0500
In-Reply-To: <455C907A.8080600@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thursday 16 November 2006 8:23 am, Alexey Starikovskiy wrote:
> David Brownell wrote:
> > On Thursday 16 November 2006 7:41 am, Alexey Starikovskiy wrote:
> >   
> >> Looks like either EC GPE or whole ACPI irq got disabled... Could you 
> >> check that ACPI interrupts still arrive after
> >> you notice AE_TIME?
> >>     
> >
> > If I unplug AC, /proc/interrrupts reports 2 IRQs going to ACPI.
> > Then on replug, it reports 10-12 IRQs going to ACPI.
> >   
> What is the state of kacpid and kacpid_notify ?

Not clear what you mean by this, but:

$ ps ax | grep acpi
   51 ?        S<     0:00 [kacpid]
   52 ?        S<     0:00 [kacpi_notify]
 2971 ?        Ss     0:00 /usr/sbin/acpid -c /etc/acpi/events.ignore
19240 pts/2    R+     0:00 grep acpi
$ 


> >
> >   
> >> Also, may be attached patch will help?
> >>     
> >
> > I'l give it a try next time I can reboot (presumably by this PM).
> >
> > - Dave
> >
> >
> >   
> >> Regards,
> >>     Alex.
> >>
> >> David Brownell wrote:
> >>     
> >>> On Wednesday 15 November 2006 1:56 pm, David Brownell wrote:
> >>>   
> >>>       
> >>>> On Wednesday 15 November 2006 6:48 am, Alexey Starikovskiy wrote:
> >>>>     
> >>>>         
> >>>>> ec1.patch
> >>>>>
> >>>>>
> >>>>> Always enable GPE after return from notify handler.
> >>>>>
> >>>>> From:  Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> >>>>>
> >>>>>
> >>>>> ---
> >>>>>       
> >>>>>           
> >>>> Yes, this seems to resolve the regression as well as Len's ec_intr=0 boot param.
> >>>>     
> >>>>         
> >>> Whoops, I spoke too soon.  It does get rid of SOME of the AE_TIME errors.  But
> >>> the system is still confused about whether or not the AC is connected, and
> >>> whether the battery is charging or not; and the CPU is still relatively hot.
> >>> Even with this patch I later got:
> >>>
> >>> ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
> >>> ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [2006070
> >>> 7]
> >>> ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE
> >>> _TIME
> >>>
> >>> In short, better but evidently not yet good enough...
> >>>
> >>> - Dave
> >>>
> >>>
> >>>
> >>>   
> >>>       
> >>>> IMO this should get merged into 2.6.19 ASAP ...
> >>>>
> >>>>
> >>>>     
> >>>>         
> >>>>>  drivers/acpi/ec.c |    2 --
> >>>>>  1 files changed, 0 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> >>>>> index e6d4b08..937eafc 100644
> >>>>> --- a/drivers/acpi/ec.c
> >>>>> +++ b/drivers/acpi/ec.c
> >>>>> @@ -465,8 +465,6 @@ static u32 acpi_ec_gpe_handler(void *dat
> >>>>>  
> >>>>>         if (value & ACPI_EC_FLAG_SCI) {
> >>>>>                 status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> >>>>> -               return status == AE_OK ?
> >>>>> -                   ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
> >>>>>         }
> >>>>>         acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
> >>>>>         return status == AE_OK ?
> >>>>>       
> >>>>>           
> >>     
> 
