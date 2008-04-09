From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Wed, 09 Apr 2008 15:46:07 +0800
Message-ID: <1207727167.27304.20.camel@acpi-hp-zz.sh.intel.com>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com>
	 <200804090034.42339.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21356 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbYDIIHm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 04:07:42 -0400
In-Reply-To: <200804090034.42339.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org


On Wed, 2008-04-09 at 15:34 +0800, David Brownell wrote:
> On Tuesday 08 April 2008, Zhao Yakui wrote:
> > Subject: ACPI: Allow to override the RTC alarm time
> > >From : Zhao Yakui <yakui.zhao@intel.com>
> >
> > In current kernel when RTC alarm time is set and not fired,
> > it is impossible to set RTC alarm again. But it is more
> > reasonable that the RTC alarm time can be overrided.
> 
> I'll disagree.  The problem is that if some task is waiting
> for the alarm at the specified time, you've just trashed the
> alarm it was relying on.
Hmm, what if the wakealarm is set by mistake?
is there any chance that user can fix it?
If not, we can add another prefix so that user can override
the wakealarm file if really needed, just like what we do in patch 3.

thanks,
rui
> 
> 
> > --- linux-2.6.orig/drivers/rtc/rtc-sysfs.c
> > +++ linux-2.6/drivers/rtc/rtc-sysfs.c
> > @@ -163,8 +163,6 @@ rtc_sysfs_set_wakealarm(struct device *d
> 
> The comment explains much of this ... and if this patch
> were deemed to be good, you should have changed that comment
> rather than making it a lie:
> 
>                 /* Avoid accidentally clobbering active alarms; we
> can't
>                  * entirely prevent that here, without even the
> minimal
>                  * locking from the /dev/rtcN api.
>                  */
>                 retval = rtc_read_alarm(rtc, &alm);
> 
> 
> >               retval = rtc_read_alarm(rtc, &alm);
> >               if (retval < 0)
> >                       return retval;
> > -             if (alm.enabled)
> > -                     return -EBUSY;
> > 
> >               alm.enabled = 1;
> >       } else {
> >
> >
> 
> 
> 
> 

