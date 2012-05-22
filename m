From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH resend] rtc-cmos: report wakeup event on ACPI RTC alarm
Date: Tue, 22 May 2012 17:12:07 +0200
Message-ID: <201205221712.07797.rjw@sisk.pl>
References: <20120509231845.0301C9D401E@zog.reactivated.net> <201205102206.42891.rjw@sisk.pl> <4FBADFFE.7030508@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:58927 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737Ab2EVPHI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 May 2012 11:07:08 -0400
In-Reply-To: <4FBADFFE.7030508@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Daniel Drake <dsd@laptop.org>, Len Brown <lenb@kernel.org>, a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, pgf@laptop.org

On Tuesday, May 22, 2012, John Stultz wrote:
> On 05/10/2012 01:06 PM, Rafael J. Wysocki wrote:
> > On Thursday, May 10, 2012, Daniel Drake wrote:
> >> When the ACPI-driven RTC alarm wakes the system, report it as a wakeup
> >> event. This allows userspace to determine that the reason for system
> >> wakeup was RTC alarm.
> >>
> >> Signed-off-by: Daniel Drake<dsd@laptop.org>
> > Len, John, any objections to this or may I take it for v3.5?
> Seems reasonable. Although could this maybe be done more generically at 
> the rtc infrastructure level instead of in the rtc-cmos driver?

I think it could, but it can be moved to the RTC layer later too.

Thanks,
Rafael
