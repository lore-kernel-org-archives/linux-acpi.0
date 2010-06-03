From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Fix the incorrect calculation about C-state idle
 time
Date: Thu, 03 Jun 2010 01:42:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006030140000.4060@localhost.localdomain>
References: <1275447849-25761-1-git-send-email-yakui.zhao@intel.com>
 <AANLkTikacbr_8PnevNPE7smvpOv1PEAa9vsqjUXAxiO_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1450428054-1275543754=:4060"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:8998 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0FCFmw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2010 01:42:52 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3F00GXCBUZHM10@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 03 Jun 2010 00:42:41 -0500 (CDT)
In-reply-to: <AANLkTikacbr_8PnevNPE7smvpOv1PEAa9vsqjUXAxiO_@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venkatesh Pallipadi <venki@google.com>
Cc: yakui.zhao@intel.com, linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1450428054-1275543754=:4060
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



thanks,
Len Brown, Intel Open Source Technology Center

On Wed, 2 Jun 2010, Venkatesh Pallipadi wrote:

> On Tue, Jun 1, 2010 at 8:04 PM,  <yakui.zhao@intel.com> wrote:
> > From: Zhao Yakui <yakui.zhao@intel.com>
> >
> > The C-state idle time is not calculated correctly, which will return the wrong
> > residency time in C-state. It will have the following effects:
> >   1.  The system can't choose the deeper C-state when it is idle next time.
> > Of course the system power is increased. E.g. On one server machine about 40W
> > idle power is increased.
> >   2.  The powertop shows that it will stay in C0 running state about 95% time
> > although the system is idle at most time.
> 
> This was a bug from my recent patch here :-(
> http://marc.info/?l=linux-acpi&m=127198016715509&w=2
> 
> Thanks for catching this..
> 
> Acked-by: Venkatesh Pallipadi <venki@google.com>

Another question about that patch...
regarding sched_clock_idle_wakeup_event().
Why do we call it for _simple and _bm, but not for _c1?
Why do we bother calculating its sleep_ticks*PM_TIMER_TICK_NS
argument, when that argument is never accessed?

thanks,
Len Brown, Intel Open Source Technology Center

--8323328-1450428054-1275543754=:4060--
