From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Thu, 10 Apr 2008 00:55:25 +0800
Message-ID: <1207760125.4056.30.camel@yakui_zhao.sh.intel.com>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com>
	 <200804090034.42339.david-b@pacbell.net>
	 <1207727167.27304.20.camel@acpi-hp-zz.sh.intel.com>
	 <200804090127.35037.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36094 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbYDIJEs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 05:04:48 -0400
In-Reply-To: <200804090127.35037.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Wed, 2008-04-09 at 01:27 -0700, David Brownell wrote:
> On Wednesday 09 April 2008, Zhang, Rui wrote:
> > > > In current kernel when RTC alarm time is set and not fired,
> > > > it is impossible to set RTC alarm again. But it is more
> > > > reasonable that the RTC alarm time can be overrided.
> > > 
> > > I'll disagree.  The problem is that if some task is waiting
> > > for the alarm at the specified time, you've just trashed the
> > > alarm it was relying on.
> >  
> > Hmm, what if the wakealarm is set by mistake?
> > is there any chance that user can fix it?
> 
> Certainly; there are several ways to turn an alarm off.
> With sysfs, just write a time in the past, as I recall...
> If you're concerned about accidents, think of it this way:
> the proposed patch would make it *REALLY EASY* to have
> accidents with sysfs that bork the alarm state, which can
> have been set by some task that's relying on it.
But how to solve the following case?
It is assumed that the RTC alarm is set by some task and not fired (It
will be fired after 20 minutes). The system enters the sleeping state
and is required to be resumed after some time(For example: ten minutes).
How to set the RTC alarm?
> The current behavior doesn't prevent such borkage; it
> can't, really, because of the alarm model.  What it does
> instead is force whatever shell script is doing that to be
> explicit about *intending* such borkage ... requiring it
> to disable existing alarms, instead of allowing accidents.
> - Dave
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

