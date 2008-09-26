From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC] [Patch 0/4]  ACPI : several patches for EC
Date: Fri, 26 Sep 2008 09:47:09 +0800
Message-ID: <1222393629.4023.157.camel@yakui_zhao.sh.intel.com>
References: <1222314812.4023.31.camel@yakui_zhao.sh.intel.com>
	 <48DB20DB.4080802@gmail.com>
	 <1222324860.4023.62.camel@yakui_zhao.sh.intel.com>
	 <48DB4C75.5090403@gmail.com>
	 <1222337155.4023.112.camel@yakui_zhao.sh.intel.com>
	 <48DB705C.2020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14990 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbYIZBmY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 21:42:24 -0400
In-Reply-To: <48DB705C.2020609@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, 2008-09-25 at 15:05 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > But I think that the spin_lock is overkill in the updated patch.
> > Assuming that 1000 EC transactions are done per second, the CPU
> > interrupt is disabled for 1ms. It is important that the normal laptops
> > will be affected by this.
> >   
> How do you arrive with these numbers? Where do you get this 1ms?
> Spinlock is around single inb/outb instruction plus several even simpler
> instructions. Do you claim it is going to take 1us? Do you claim that it 
> will
It is noted that inb/outb instruction is not memory read/write
operation. It will take some time to read/write the external peripheral
device.
For example: 
On intel platform : The EC is connected with ICH device through LPC bus.
For every LCP I/O read/write operation, it will take almost 0.7us.

When OS reads the SBS battery info, there will a lot of SCI interrupts,
most of which are related with EC transaction. 
> add anything to interrupts-disabled time of ACPI SCI interrupt handler
> itself?
Not included.

Why not explain the following ? The local function variable resides on
the process stack space. If the process that is doing EC transaction is
killed before it is finished, what will happen? Maybe the system will be
kernel panic. 
   At the same time the following source code looks so ugly.
>  The local variable in function is assigned to the global pointer
variable.
>      >struct transaction_data t = {.wdata = wdata, .rdata = rdata,
>                                      .wlen = wdata_len, .rlen =
rdata_len};
>       >ec->t = &t;
> 
    And this will be accessed by interrupt context. 
   
   Assuming that an application tries to access the battery info through
the /proc interface, maybe there will exist kernel panic if the
application is killed before it returns normally.(The battery info is
related with EC.)
In normal conditions it will be OK. But in some specific cases , maybe
there exists the problem.
> >    
> >    At the same time the following source code looks so ugly.
> >   
> It is a matter of taste and, probably, experience.
> 
>  
> 
> > Please look at the following source to see whether the bogus timeout
> > happens.
> >    >spin_unlock_irqrestore(&ec->spinlock, tmp);
> >    >	/* if we selected poll mode or failed in GPE-mode do a poll loop */  
> >    >	if (force_poll ||
> >    >	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
> >    >	    acpi_ec_wait(ec))
> >    >		ret = ec_poll(ec);
> > 		
> > 	When EC GPE storm happens, EC driver will work in polling mode. And it will
> > call the function of ec_poll after issuing the EC command.
> >    static int ec_poll(struct acpi_ec *ec)
> > {
> > 	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
> >         //If preempt schedule happens here, the timeout happens after it is rescheduled.
> >         // In such case how to issue the following EC command sequence?
> >   
> > 	while (time_before(jiffies, delay)) {
> > 		gpe_transaction(ec, acpi_ec_read_status(ec));
> > 		/* do a shortest sleep */
> > 		msleep(1);
> > 		if (ec_transaction_done(ec))
> >  			return 0;
> > 	        //If the preempt schedule happens here, maybe the timeout happens when it is rescheduled. 
> >                 // And the EC transaction is not finished. How to explain it?
> >  	}
> > -	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
> > -		acpi_ec_read_status(ec),
> > -		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
> >  	return -ETIME;
> >  }
> >        I don't care whether the above bogus timeout often happens.  What I cared is
> > how to explain it or process it. 
> >        Regarded it as Timeout or ignore it? Unreasonable.       
> >
> >   
> You seem to agree, that with working scheduler it is not possible that 
> this code will not be
> executed for half a second, right? Then, with broken scheduler (the one 
> with 120s sleeps),
I haven't  said anything about the scheduler.  
> you arrive at this code 120 seconds late and still want to continue 
> transaction?
Why not continue transaction? 
When timeout happens, the following EC command sequence can't be issued.
Maybe this will crash the EC internal working state.
If not,please help me explain why so many timeouts happen on the laptop
of bug 11141 after one bogus timeout happens.
    http://bugzilla.kernel.org/show_bug.cgi?id=11141

> 500msec here is _cut off_ after which we don't care about this 
> transaction. In normal
> conditions transaction should not _ever_ come close to 1/10th of this value.
Yes. I agree. In normal conditions transaction will be finished very
quickly. 
But in the exception conditions? What will happen?
Please give me a clear explanation. 
> >>>    b. How to deal with the laptop with "incorrect EC status before EC
> >>> GPE arrives". For example: bug 11309 (GPE storm happens and OS will
> >>> report the incorrect temperature while EC GPE is disabled.)
> >>>       
> >> This is _your guess_. None of your patches was reported to fix a situation,
> >> and submitter is not able to compile kernel.
> >>     
> > The bug reporter doesn't give response. But please pay attention to this
> > is a regression.
> >     The detect of EC GPE storm is not shipped in 2.6.24.x kernel.
> >     The detect of EC GPE storm is shipped in 2.6.26.x kernel.
> >     On the 2.6.24.x kernel there is no detection of EC GPE storm and EC
> > GPE is enabled. In such case the temperature is reported correctly.   
> >     And after EC GPE storm happens , sometimes it will report the
> > incorrect thermal zone temperature, which causes that the system will be
> > shutdown. (In such case EC GPE is disabled and EC will work in polling
> > mode).
> >     How to explain it? The possible cause is that EC status is incorrect
> > before EC GPE arrives.
> >
I only want to know why you raise the following commit?
    >commit 9e197219605513c14d3eae41039ecf1b82d1920d
    >Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    > Date:   Wed Mar 7 18:29:35 2007 -0500
      >ACPI: ec: fix race in status register access
   
   If your understanding is correct, why push it?
   Why give two different explanations about the same issue?
At the same time please confirm whether the laptop of bug 8110 is broken
again by your patch if the GPE storm happens ?
> >   
> It is easy to add same msleep(1) before the while() loop to overcome
> this, right? So, as soon as the submitter will be able to test patches,
> and if he finds his hardware still not working correctly, we could
> easily fix it with 1-liner patch.
> > The laptop of bug 8110 is fixed by the following commit.
> >     >commit 9e197219605513c14d3eae41039ecf1b82d1920d
> >      > Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
> >      > Date:   Wed Mar 7 18:29:35 2007 -0500
> >         >ACPI: ec: fix race in status register access
> >    
> >    If the EC GPE storm happens on this laptop, I believe that this
> > laptop will be broken by your proposed patch again.
> >   
> Do you want me to insert the above msleep(1) now, or do you want
> me to drop my patch and instead go with yours?
> 

