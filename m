From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC] [Patch 0/4]  ACPI : several patches for EC
Date: Thu, 25 Sep 2008 18:05:55 +0800
Message-ID: <1222337155.4023.112.camel@yakui_zhao.sh.intel.com>
References: <1222314812.4023.31.camel@yakui_zhao.sh.intel.com>
	 <48DB20DB.4080802@gmail.com>
	 <1222324860.4023.62.camel@yakui_zhao.sh.intel.com>
	 <48DB4C75.5090403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31230 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbYIYKBN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 06:01:13 -0400
In-Reply-To: <48DB4C75.5090403@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, 2008-09-25 at 12:31 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> >   
> I gave you explanations for two weeks already. Enough is enough.
Please send you explanation to Linux ACPI mailing list. OK?
    If my patch has the possibility to break some laptops or cause some
regression, please also give some bug number.
> > Otherwise it is unconvincing if you NAK my patch only because it is
> > conflicted with your patch.
> >
> > Now the patch proposed by your patch is already reverted in acpi_test
> > tree. There are a lot of errors in it.
On 9/4 you sent the patch to Andi. And there are a lot of errors.
   a. t->command is always zero.
   b. GPE_STORM mode is always set.
   c. There is no synchronization while t is accessed in different
routines.

   Of course the above three errors are fixed in the updated patch of
    http://bugzilla.kernel.org/show_bug.cgi?id=11549#C3.
   
   But I think that the spin_lock is overkill in the updated patch.
   Assuming that 1000 EC transactions are done per second, the CPU
interrupt is disabled for 1ms. It is important that the normal laptops
will be affected by this.
   
   At the same time the following source code looks so ugly.
>  The local variable in function is assigned to the global pointer variable.
>      >struct transaction_data t = {.wdata = wdata, .rdata = rdata,
>                                      .wlen = wdata_len, .rlen = rdata_len};
>       >ec->t = &t;
> 
    And this will be accessed by interrupt context. 
   
   Assuming that an application tries to access the battery info through the /proc 
interface,maybe there will exist kernel panic if the application is killed before it returns normally.
(The battery info is related with EC.)
In normal conditions it will be OK. But in some specific cases , maybe there exists the problem.

> This is a lie.
> > At the same time I raise two issues about your proposed patch. But there
> > is no explanation.
> >    a. Bogus timeout>   
> You are referring to bug report, there system was stalling to 120 seconds
> due to broken HPET.  While there is no need to try to workaround such 
> things,
> changing to udelay() from msleep() in poll mode will fix it.
Please look at the following source to see whether the bogus timeout
happens.
   >spin_unlock_irqrestore(&ec->spinlock, tmp);
   >	/* if we selected poll mode or failed in GPE-mode do a poll loop */  
   >	if (force_poll ||
   >	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
   >	    acpi_ec_wait(ec))
   >		ret = ec_poll(ec);
		
	When EC GPE storm happens, EC driver will work in polling mode. And it will
call the function of ec_poll after issuing the EC command.
   static int ec_poll(struct acpi_ec *ec)
{
	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
        //If preempt schedule happens here, the timeout happens after it is rescheduled.
        // In such case how to issue the following EC command sequence?
	while (time_before(jiffies, delay)) {
		gpe_transaction(ec, acpi_ec_read_status(ec));
		/* do a shortest sleep */
		msleep(1);
		if (ec_transaction_done(ec))
 			return 0;
	        //If the preempt schedule happens here, maybe the timeout happens when it is rescheduled. 
                // And the EC transaction is not finished. How to explain it?
 	}
-	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
-		acpi_ec_read_status(ec),
-		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
 	return -ETIME;
 }
       I don't care whether the above bogus timeout often happens.  What I cared is
how to explain it or process it. 
       Regarded it as Timeout or ignore it? Unreasonable.       

> >    b. How to deal with the laptop with "incorrect EC status before EC
> > GPE arrives". For example: bug 11309 (GPE storm happens and OS will
> > report the incorrect temperature while EC GPE is disabled.)
> This is _your guess_. None of your patches was reported to fix a situation,
> and submitter is not able to compile kernel.
The bug reporter doesn't give response. But please pay attention to this
is a regression.
    The detect of EC GPE storm is not shipped in 2.6.24.x kernel.
    The detect of EC GPE storm is shipped in 2.6.26.x kernel.
    On the 2.6.24.x kernel there is no detection of EC GPE storm and EC
GPE is enabled. In such case the temperature is reported correctly.   
    And after EC GPE storm happens , sometimes it will report the
incorrect thermal zone temperature, which causes that the system will be
shutdown. (In such case EC GPE is disabled and EC will work in polling
mode).
    How to explain it? The possible cause is that EC status is incorrect
before EC GPE arrives.

The laptop of bug 8110 is fixed by the following commit.
    >commit 9e197219605513c14d3eae41039ecf1b82d1920d
     > Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
     > Date:   Wed Mar 7 18:29:35 2007 -0500
        >ACPI: ec: fix race in status register access
   
   If the EC GPE storm happens on this laptop, I believe that this
laptop will be broken by your proposed patch again.
   
> It is not, and I explained to you why.

