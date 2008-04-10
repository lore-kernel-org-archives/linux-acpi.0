From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Thu, 10 Apr 2008 19:08:43 +0800
Message-ID: <1207825723.8704.26.camel@yakui_zhao.sh.intel.com>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com>
	 <200804090127.35037.david-b@pacbell.net>
	 <1207760125.4056.30.camel@yakui_zhao.sh.intel.com>
	 <200804090313.34805.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27356 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495AbYDJDYL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 23:24:11 -0400
In-Reply-To: <200804090313.34805.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Wed, 2008-04-09 at 03:13 -0700, David Brownell wrote:
> On Wednesday 09 April 2008, Zhao Yakui wrote:
> > > > Hmm, what if the wakealarm is set by mistake?
> > > > is there any chance that user can fix it?
> > > 
> > > Certainly; there are several ways to turn an alarm off.
> > > With sysfs, just write a time in the past, as I recall...
> > > 
> > > If you're concerned about accidents, think of it this way:
> > > the proposed patch would make it *REALLY EASY* to have
> > > accidents with sysfs that bork the alarm state, which can
> > > have been set by some task that's relying on it.
> > 
> > But how to solve the following case?
> > 
> > It is assumed that the RTC alarm is set by some task and not fired (It
> > will be fired after 20 minutes). The system enters the sleeping state
> > and is required to be resumed after some time(For example: ten minutes).
> > 
> > How to set the RTC alarm?
> 
> You mean, how to decide which alarm setting should "win"?
> If sysfs accidents aren't going to trump everything else.
Yes. IMO Sysfs I/F should have more priority than other.

At the same time there is another question about this.
alm.enabled is related with AIE flag. When alarm is fired, the AIE flag
won't be cleared automatically. If we want to set alarm again, should we
turn off the alarm firstly?  

> That's a fair question.  I don't think there's a good answer
> to that with today's infrastructure.  Arguably, there should
> be the notion of a number of clients, each of which get told
> when the alarm they request fires.  But today, there's only
> a single alarm, and a single client.
Agree. Now there is only one alarm and current infrastruture can't
support more than two clients.
> 
> - Dave
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

