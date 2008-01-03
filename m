From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Wed, 2 Jan 2008 16:51:57 -0800
Message-ID: <20080102165157.2150f2d2.akpm@linux-foundation.org>
References: <200711302153.lAULrZ7n026255@imap1.linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE2FAE6A@orsmsx423.amr.corp.intel.com>
	<20071130142058.816d1693.akpm@linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>
	<4750CC78.9070105@rtr.ca>
	<20071130190227.1976e682@laptopd505.fenrus.org>
	<4750D180.6080001@rtr.ca>
	<20071130191816.3e744205@laptopd505.fenrus.org>
	<4750D585.1030200@rtr.ca>
	<477C2143.8090406@rtr.ca>
	<924EFEDD5F540B4284297C4DC59F3DEE4FC485@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34994 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760773AbYACAxt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 19:53:49 -0500
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE4FC485@orsmsx423.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Mark Lord <lkml@rtr.ca>, Arjan van de Ven <arjan@infradead.org>, abelay@novell.com, lenb@kernel.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 2 Jan 2008 16:06:20 -0800 "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

>  
> 
> >-----Original Message-----
> >From: Mark Lord [mailto:lkml@rtr.ca] 
> >Sent: Wednesday, January 02, 2008 3:42 PM
> >To: Arjan van de Ven
> >Cc: Pallipadi, Venkatesh; Andrew Morton; abelay@novell.com; 
> >lenb@kernel.org; Ingo Molnar; linux-kernel@vger.kernel.org; 
> >linux-acpi@vger.kernel.org
> >Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch 
> >added to -mm tree
> >
> >Arjan van de Ven wrote:
> >> On Fri, 30 Nov 2007 22:31:17 -0500
> >> Mark Lord <lkml@rtr.ca> wrote:
> >> 
> >>> Arjan van de Ven wrote:
> >>>> On Fri, 30 Nov 2007 22:14:08 -0500
> >>>> Mark Lord <lkml@rtr.ca> wrote:
> >>>>
> >>>>>> in -mm there is.. the QoS stuff allows you to set maximum
> >>>>>> tolerable
> >>>>> ..
> >>>>>
> >>>>> That's encouraging, I think, but not for 2.6.24.
> >>>>>
> >>>>>> latency. If your app cant take any latency, you should set
> >>>>>> those... and the side effect is that the kernel will not do
> >>>>>> long-latency C-states or P-state transitions..
> >>>>> ..
> >>>>>
> >>>>> I don't mind the cpufreq changing (actually, I want it to drop in
> >>>>> cpugfreq to save power and keep the fan off), but the 
> >C-states just
> >>>>> kill this app.
> >>>>>
> >>>>> The app is VMware.  I force the max_state=1 when launching,
> >>>> ah but then its' even easier... and can be done in 2.6.24 already.
> >>>> VMWare after all has a kernel module, and the latency stuff is in
> >>>> 2.6.23 and 2.6.24 available inside the kernel already.
> >>> ..
> >>>
> >>> Oh, I'm perfectly happy to write my own kernel module if that's what
> >> 
> >> all you need to do in your kernel module is call
> >> 
> >> add_latency_constraint("mark_wants_his_mouse", 5);
> >> 
> >> or so
> >..
> >
> >Dredging up an old regression again now:
> >
> >The "make my own module to replace /sys/.../max_cstate" doesn't work
> >for the single-core machine we use a lot around here.
> >
> >VMware is totally sluggish unless I go to another text window 
> >and do this:
> >
> >    while ( true ); do echo -n ; done
> >
> >At which point VMware performs well again,
> >the same as with "echo 1 > max_cstate" in 2.6.23.
> >
> >Anyone got any suggestions on how to fix this regression
> >or work around it for 2.6.24 ?
> >
> 
> Easiest and clean way to do it is to have a driver with
> set_acceptable_latency() for 1uS or so in init and
> remove_acceptable_latency() at exit.

err, you appear to be suggesting that Mark patch his kernel to make it work
as well as 2.6.23?  That would be a wrong answer.

This regression was known six weeks ago.  What do we need to do (or revert)
to fix it in 2.6.24?

