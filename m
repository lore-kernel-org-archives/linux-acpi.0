From: David Brownell <david-b@pacbell.net>
Subject: Re: RTC_DRV_CMOS can break userspace interface
Date: Mon, 28 May 2007 14:06:52 -0700
Message-ID: <200705281406.57396.david-b@pacbell.net>
References: <8pwhX-46n-3@gated-at.bofh.it> <8pCQo-5QL-7@gated-at.bofh.it> <87abvogbdp.fsf@buer.dfakt.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:42628 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751823AbXE1VJA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 May 2007 17:09:00 -0400
In-Reply-To: <87abvogbdp.fsf@buer.dfakt.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: frank paulsen <frank.paulsen@gmx.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Monday 28 May 2007, frank paulsen wrote:
> David Brownell <david-b@pacbell.net> writes:
> 
> > On Sunday 27 May 2007, Matthew Garrett wrote:
> >> f5f72b46c349fefcfd4421b2213c6ffb324c5e56 appears to break the userspace 
> >> interface to the CMOS alarm. This could previously be accessed via 
> >> /proc/acpi/alarm ...
> >
> > I was a bit surprised the ACPI team didn't have more comments on
> > that issue, myself.  Thing is, all of /proc/acpi/* is deprecated
> > (scheduled for removal in barely over one month!) and nobody had
> > found any actual users of that "alarm" file when they searched for
> > them a while ago.  I suppose the conclusion then was that there
> > are no applications using it.
> 
> sorry for breaking the CC:, but i am currently not subscribed to lkml.

I restored both lkml and linux-acpi to the CC list.  :)


> please have a look at at http://www.mythtv.org/wiki/index.php/ACPI_Wakeup
> 
> i think there is quite a number of users, but most of them won't ever
> look into LKML :)

That seems to be true.  And those particular users should learn the
portable /sys/class/rtc/rtc0/wakealarm syntax ... e.g. using numeric
seconds-since-epoch ("date '+%s'") instead of strings the kernel needs
to parse.  That way, they can start converting usage sooner.

Someone with edit privs on that wiki should update those docs, and
tell folk to switch to that interface since the other one is going...


I'm suspecting that there should be a CONFIG_ACPI_SLEEP_PROC_ALARM
not the current internal (acpi/sleep/proc.c) HAVE_ACPI_LEGACY_ALARM,
and some way should be found that the two interfaces can coexist for
a while.  But I can't quite make sense of the strategy for getting
rid of the /proc/acpi/* files ... for example, I see one entry
saying the ACPI procfs as a whole vanishes July 2007, and the next
one says that /proc/acpi/button stays until August 2007.

- Dave
 


