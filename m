From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Tue, 02 Sep 2008 11:39:36 +0800
Message-ID: <1220326776.4039.153.camel@yakui_zhao.sh.intel.com>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>
	 <48BC57C9.2040409@suse.de>
	 <1220317387.4039.83.camel@yakui_zhao.sh.intel.com>
	 <20080902020302.GA12080@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47311 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbYIBDZp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Sep 2008 23:25:45 -0400
In-Reply-To: <20080902020302.GA12080@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 2008-09-01 at 23:03 -0300, Henrique de Moraes Holschuh wrote:
> On Tue, 02 Sep 2008, Zhao Yakui wrote:
> > On Tue, 2008-09-02 at 00:59 +0400, Alexey Starikovskiy wrote:
> > > Alexey Starikovskiy wrote:
> > In this patch when timeout happens, EC will try the GPE interrupt mode
> > after 5 seconds.Of course EC will be in polling mode before switching to
> > GPE interrupt mode. It seems reasonable. 
> 
> Yeah, the patch looks good.
> 
> But we probably want to limit the number of times it will try to re-enable
> interrupt mode, otherwise it will keep firing on ECs that are permanently
> broken re. GPE interrupt mode.  I think trying 5 times should be enough,
> that gives a 25s window for the EC to get its act together.
> 
> And we should probably reset the "attempted tries to switch to GPE interrupt
> mode" counter (so that the code will retry interrupt mode again) after
> events that are likely to have done a lot of internal churning to the EC.
> Currently, those would be when resuming from S3 or S4, I think.
> 
> > In fact there also exists the mode switch from polling mode to interrupt
> > mode after EC is initialized. Is it more appropriate that ec->gpe_retry
> > is initialized?
> 
> We could use the same code to do the initial switch, indeed.
> 
> The two other things that we probably want to make sure we are doing are:
> 
> 1. Drain the entire EC queue at every poll cycle (this is a must, really).
It is difficult to drain the entire EC queue. In fact OS can't know the
length of EC entire queue. In fact there is no concept about the EC
queue.
   
> 2. Try to drain the entire EC queue also in interrupt mode, but be careful
> about dumb ECs that will sign 10 interrupts if there are 10 bytes to read in
> the queue, even when we have drained the queue when servicing the very first
> interrupt.   I bet there are ECs which will give you just one interrupt and
> expect the queue to be drained, ECs which will give you interrupts until you
> drain the queue (but no more than necessary), and ECs which will give you
> interrupts for as many bytes as it stored in the queue, regardless of when
> they were read... and we mustn't think there is an interrupt storm happening
> because of this.
Maybe what you said is right. There are too many kinds of EC controllers
available. And they come from the different OEMs. Maybe when one EC
internal event is detected, the EC GPE interrupts will always be
triggered before the notification event is processed on some ECs. But
who knows.
> 

