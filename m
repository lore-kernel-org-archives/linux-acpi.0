From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Wed, 9 Apr 2008 01:27:34 -0700
Message-ID: <200804090127.35037.david-b@pacbell.net>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com> <200804090034.42339.david-b@pacbell.net> <1207727167.27304.20.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:22013 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751785AbYDII1h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2008 04:27:37 -0400
In-Reply-To: <1207727167.27304.20.camel@acpi-hp-zz.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Wednesday 09 April 2008, Zhang, Rui wrote:
> > > In current kernel when RTC alarm time is set and not fired,
> > > it is impossible to set RTC alarm again. But it is more
> > > reasonable that the RTC alarm time can be overrided.
> >=20
> > I'll disagree. =A0The problem is that if some task is waiting
> > for the alarm at the specified time, you've just trashed the
> > alarm it was relying on.
> =20
> Hmm, what if the wakealarm is set by mistake?
> is there any chance that user can fix it?

Certainly; there are several ways to turn an alarm off.
With sysfs, just write a time in the past, as I recall...

If you're concerned about accidents, think of it this way:
the proposed patch would make it *REALLY EASY* to have
accidents with sysfs that bork the alarm state, which can
have been set by some task that's relying on it.

The current behavior doesn't prevent such borkage; it
can't, really, because of the alarm model.  What it does
instead is force whatever shell script is doing that to be
explicit about *intending* such borkage ... requiring it
to disable existing alarms, instead of allowing accidents.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
