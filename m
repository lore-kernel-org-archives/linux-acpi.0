From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Wed, 9 Apr 2008 03:13:34 -0700
Message-ID: <200804090313.34805.david-b@pacbell.net>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com> <200804090127.35037.david-b@pacbell.net> <1207760125.4056.30.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:39048 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751376AbYDIKNg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2008 06:13:36 -0400
In-Reply-To: <1207760125.4056.30.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Wednesday 09 April 2008, Zhao Yakui wrote:
> > > Hmm, what if the wakealarm is set by mistake?
> > > is there any chance that user can fix it?
> > 
> > Certainly; there are several ways to turn an alarm off.
> > With sysfs, just write a time in the past, as I recall...
> > 
> > If you're concerned about accidents, think of it this way:
> > the proposed patch would make it *REALLY EASY* to have
> > accidents with sysfs that bork the alarm state, which can
> > have been set by some task that's relying on it.
> 
> But how to solve the following case?
> 
> It is assumed that the RTC alarm is set by some task and not fired (It
> will be fired after 20 minutes). The system enters the sleeping state
> and is required to be resumed after some time(For example: ten minutes).
> 
> How to set the RTC alarm?

You mean, how to decide which alarm setting should "win"?
If sysfs accidents aren't going to trump everything else.

That's a fair question.  I don't think there's a good answer
to that with today's infrastructure.  Arguably, there should
be the notion of a number of clients, each of which get told
when the alarm they request fires.  But today, there's only
a single alarm, and a single client.

- Dave



