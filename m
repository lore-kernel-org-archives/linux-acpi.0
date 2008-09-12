From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI : Avoid bogus timeout about SMbus check
Date: Fri, 12 Sep 2008 09:38:49 +0800
Message-ID: <1221183530.3989.271.camel@yakui_zhao.sh.intel.com>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>
	 <20080904121820.GC18288@one.firstfloor.org>
	 <200809112149.43894.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5792 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbYILBYG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 21:24:06 -0400
In-Reply-To: <200809112149.43894.oldium.pro@seznam.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oldrich Jedlicka <oldium.pro@seznam.cz>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, lenb@kernel.org, astarikovskiy@suse.de

On Thu, 2008-09-11 at 21:49 +0200, Oldrich Jedlicka wrote:
> On Thursday 04 of September 2008 at 14:18:20, Andi Kleen wrote:
> > On Tue, Aug 26, 2008 at 01:57:34PM +0800, Zhao Yakui wrote:
> > > Subject: ACPI: Avoid bogus timeout about SMbus check
> > >
> > > >From :  Zhao Yakui <yakui.zhao@intel.com>
> > >
> > > In the function of wait_transaction_complete when the timeout happens,
> > > OS will try to check the status of SMbus again. If the status is what OS
> > > expected, it will be regarded as the bogus timeout. Otherwise it will be
> > > treated as ETIME.
> > >
> > > http://bugzilla.kernel.org/show_bug.cgi?id=10483
> >
> > I added it for 2.6.27 thanks (since it seems to be a regression)
> 
> Hi all,
> 
> the problem in bug 10483 isn't solved, unfortunately the patch applied to 
> 2.6.27 isn't the one I tested.
> 
> The problem I face is that wait_transaction_complete() in sbshc.c doesn't take 
> at most "timeout" time (=one second), but it rather often takes very long 
> time to complete on my system (several minutes) - notebook Acer TravelMate 
> 4502WLMi.
> To describe the problem I need to go into wait_event_timeout() macro as used 
> in wait_transaction_complete(): it first calls the user method 
> smb_check_done() to check if the loop should end and if not, it waits for at 
> most "timeout" time. The wait can be woken-up by a wake_up() method and if 
> so, it remembers the remaining "timeout", repeats the call to user method 
> smb_check_done() and possibly continues with wait (with the 
> remaining "timeout"). This is done in a loop.
> 
> Now my problem: the wait_event_timeout() loop takes several minutes instead of 
> one second (as specified by the parameter "timeout"). The reason for that - as 
> I think - is this:
> 
>   1. The smb_check_done() method called each loop takes some time to execute, 
> but this time is not included into the overall timeout.
What you said is right. It will take some time to execute the function
of smb_check_done. When the ec_read is called in smb_check_done, maybe
it will also sleep for some time in ec_read. But this time is not
accounted into the overall timeout.
Please use the following mechanism to replace the wait_event_timeout.

	unsigned long delay = jiffies + msecs_to_jiffies(timeout);

	while (time_before(jiffies, delay)) {
		if (smb_check_done(hc))
			return 0;
		msleep(1);
	}
>   2. The wait_event_timeout() is woken-up by smbus_alarm() very early each 
> loop, so the remaining "timeout" gets lower very slow (I think it is so, but 
> I haven't verified this hypothesis yet).

> 
> So my question is what I shoud do now? If you want to see some logs (and the 
> original patch), please go to my bug report:
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=10483
> 
> Thanks.
> 
> Note: I'm building my house after my normal work, so I don't have much time 
> left, but I will do my best to try whatever you suggest. And sorry for my 
> english :-)
> 
> Regards,
> Oldrich.
> 

