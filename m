From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Possible bug in ACPI
Date: Mon, 04 Dec 2006 00:24:00 +0300
Message-ID: <45734070.6040305@linux.intel.com>
References: <20060919214724.GB2073@panelnet.cz>	<20061109140416.db12bcbe.akpm@osdl.org>	<20061202205140.GA12447@panelnet.cz>	<20061202192632.d1815e5f.akpm@osdl.org>	<457293AE.2060701@linux.intel.com>	<20061203021216.e15b1d5d.akpm@osdl.org>	<4572994C.6020603@linux.intel.com> <20061203122731.c9a514aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040009070202070204040507"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40986 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1760102AbWLCVYG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Dec 2006 16:24:06 -0500
In-Reply-To: <20061203122731.c9a514aa.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Dalibor Straka <dast@panelnet.cz>, jikos@jikos.cz, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------040009070202070204040507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> On Sun, 03 Dec 2006 12:30:52 +0300
> Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:
>
>   
>> Andrew Morton wrote:
>>     
>>> On Sun, 03 Dec 2006 12:06:54 +0300
>>> Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:
>>>
>>>   
>>>       
>>>> This is a patch reverted by Linus from rc6-git2 because it broke his 
>>>> Compaq n620c, it refers to #5534 bug. Basically, kacpid deadlocks on 
>>>> some new HP notebooks, and all incoming requests would be queued until 
>>>> memory is over if this patch is not applied. On a bright side -- it's 
>>>> not a memory leak...
>>>> Patch, which works for Linus laptop and "looks acceptable" to Linus is 
>>>> the last in #5534 list.
>>>>     
>>>>         
>>> hm, if you say so.
>>>       
>> I forwarded Linus' mail to you...
>>     
>
> I didn't receive it.
>   
Please see attached.
>   
>>>   The description in that patch is nowhere near complete
>>> enough for me to be able to work out what it does.
>>>
>>>   
>>>       
>> Will update.
>>
>>     
>>> The sys_sched_yield() is particularly incomprehensible and needs good
>>> commenting.  You are, I hope, aware of the severe problems which yield()
>>> causes when the system is busy?  The process which calls it will get
>>> practically no CPU at all.
>>>
>>>   
>>>       
>> On Linus' machine, as soon as we execute deferred work, it's GPE becomes 
>> enabled again and BIOS sends us a new event.
>> So kacpid is always ready to run, while kacpi_notify don't have a chance 
>> to run. sys_sched_yield() was added to
>> give kacpi_notify a chance to run.
>> I was thinking about lowering the priority of kacpid, is it better?
>>     
>
> It all sounds horridly hacky, but I don't understand the problem well
> enough to be able to recommend any solutions.  That's why I was hoping for
> a decent description of the patch.
>
>   
HP nx6125/nx6325/... machines have a _GPE handler with an infinite loop 
sending Notify() events to different ACPI subsystems.
Notify handler in ACPI driver is a C-routine, which may call ACPI 
interpreter again to get access to some ACPI variables (acpi_evaluate_xxx).
On these HP machines such an evaluation changes state of some variable 
and lets the loop above break.
In the current ACPI implementation Notify requests are being deferred to 
the same kacpid workqueue on which the above GPE handler with infinite 
loop is executing. Thus we have a deadlock -- loop will continue to 
spin, sending notify events, and at the same time preventing these 
notify events from being run on a workqueue. All notify events are 
deferred, thus we see increase in memory consumption noticed by author 
of the thread. Also as GPE handling is bloked, machines overheat. 
Eventually by external poll of the same acpi_evaluate, kacpid is 
released and all the queued notify events are free to run, thus 100% cpu 
utilization by kacpid for several seconds or more.

To prevent all these horrors it's needed to not put notify events to 
kacpid workqueue by either executing them immediately or putting them on 
some other thread.
It's dangerous to execute notify events in place, as it will put several 
ACPI interpreter stacks on top of each other (at least 4 in case of 
nx6125), thus causing kernel  stack overflow.
First attempt to create a new thread was done by /Peter Wainwright 
<mailto:prw@ceiriog.eclipse.co.uk>: he created a bunch of threads which 
were stealing work from a kacpid workqueue.
This patch appeared in 2.6.15 kernel shipped with Ubuntu 6.06 LTS.
Second attempt was done by me,  I  created a new  thread for each Notify 
event. This worked OK on HP nx machines, but broke Linus' Compaq n620c, 
by producing threads with a speed what they stopped the machine 
completely. Thus this patch was reverted from 18-rc2 as I remember.
I re-made the patch to create second workqueue just for notify events, 
thus hopping it will not break Linus' machine. Patch was tested on the 
same HP nx machines in #5534 and #7122, but I did not received reply 
from Linus on a test patch sent to him.
Patch went to 19-rc and was rejected with much fanfare again.
There was 4th patch, which inserted schedule_timeout(1) into deferred 
execution of kacpid if we had any notify requests pending, but Linus 
decided that it was too complex (involved either changes to workqueue to 
see if it's empty or atomic inc/dec).
Now you see last variant which adds yield() to every GPE execution.
/
> How does it relate to this? http://lkml.org/lkml/2006/8/8/336
>
>   
In both cases GPE (General Purpose Events) are involved.
There are two types of GPE -- level and edge triggered, they are 
described as _Lxx or _Exx methods under _GPE namespace of ACPI 
interpreter (DSDT). Both should be disabled, then we receive them until 
they are handled by methods above. Level should be cleared after 
execution of handler, while Edge should be cleared immediately. In this 
post DSDT was written with error and edge method was described as level, 
thus requiring changing clearing of level events as soon as edge ones. 
The solution for this problem is changing DSDT to declare method in 
question as _Exx and not _Lxx.
>>> Minor point: that patch has several unneded (and undesirable) casts of void*:
>>>
>>> +static void acpi_os_execute_notify(void *context)
>>> +{
>>> +	struct acpi_os_dpc *dpc = (struct acpi_os_dpc *)context;
>>> 	
>>> please remove those.
>>>   
>>>       
>
> I'll take that as an "OK" ;)
>   
Sorry, yes, OK. :)

Regards,
    Alex.

--------------040009070202070204040507
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Return-Path: <torvalds@osdl.org>
X-Original-To: alexey.y.starikovskiy@linux.intel.com
Delivered-To: alexey.y.starikovskiy@linux.intel.com
Received: from fmsmga001.fm.intel.com (fmsmga001.fm.intel.com [10.253.24.23])
	by linux.intel.com (Postfix) with ESMTP id 6D8166A401C
	for <alexey.y.starikovskiy@linux.intel.com>; Mon, 20 Nov 2006 10:56:19 -0800 (PST)
Received: from fw.osdl.org (HELO fmsmga101.fm.intel.com) ([65.172.181.6])
  by fmsmga001.fm.intel.com with ESMTP; 20 Nov 2006 10:56:18 -0800
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAANWIYUVBrLUGiWdsb2JhbACBRosGAQEJDio
Received: from smtp.osdl.org ([65.172.181.25])
  by fmsmga101.fm.intel.com with ESMTP; 20 Nov 2006 10:10:53 -0800
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.09,440,1157353200";
   d="scan'208"; a="100474110:sNHT183012687"
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAKI7fix019458
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <alexey.y.starikovskiy@linux.intel.com>; Mon, 20 Nov 2006 10:07:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAKI7dnB027071
	for <alexey.y.starikovskiy@linux.intel.com>; Mon, 20 Nov 2006 10:07:39 -0800
Date: Mon, 20 Nov 2006 10:07:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
In-Reply-To: <456043F7.1030105@linux.intel.com>
Message-ID: <Pine.LNX.4.64.0611201003540.3692@woody.osdl.org>
References: <B41635854730A14CA71C92B36EC22AAC5AD485@mssmsx411>
 <Pine.LNX.4.64.0611181104030.3692@woody.osdl.org> <455FB44C.8050103@linux.intel.com>
 <Pine.LNX.4.64.0611182048560.3692@woody.osdl.org> <456043F7.1030105@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-0.545 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.105__
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36



On Sun, 19 Nov 2006, Alexey Starikovskiy wrote:
>
> I agree to all your comments with one exception, please see below. Attached is
> the reworked patch against latest git. Please test.

Ok, this one works for me too, and looks much simpler.

> Linus Torvalds wrote:
> > And we might as well do it when we add an entry to the _deferred_ queue, no? 
>   
> acpi_os_execute() is called from interrupt context for insertion into
> _deferred_ queue, so it's not possible to yield in it, no?

Hmm. Yes. Anyway, the new patch looks acceptable, and certainly much 
simpler than trying to count events.

It probably causes tons of new unnecessary scheduling events, but I doubt 
we really care.

That said, what we _really_ want here is a "priority queue" for the 
events, and some way to put an event back on the queue while running it 
(eg ACPI "Sleep" event). But I guess the ACPI interpreter isn't done that 
way (ie you can't just push and pop ACPI state).

		Linus

--------------040009070202070204040507--
