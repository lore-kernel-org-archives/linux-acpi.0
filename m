From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Mon, 1 Sep 2008 23:03:02 -0300
Message-ID: <20080902020302.GA12080@khazad-dum.debian.net>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com> <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de> <48BC57C9.2040409@suse.de> <1220317387.4039.83.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59847 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104AbYIBCDN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2008 22:03:13 -0400
Content-Disposition: inline
In-Reply-To: <1220317387.4039.83.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, 02 Sep 2008, Zhao Yakui wrote:
> On Tue, 2008-09-02 at 00:59 +0400, Alexey Starikovskiy wrote:
> > Alexey Starikovskiy wrote:
> In this patch when timeout happens, EC will try the GPE interrupt mode
> after 5 seconds.Of course EC will be in polling mode before switching to
> GPE interrupt mode. It seems reasonable. 

Yeah, the patch looks good.

But we probably want to limit the number of times it will try to re-enable
interrupt mode, otherwise it will keep firing on ECs that are permanently
broken re. GPE interrupt mode.  I think trying 5 times should be enough,
that gives a 25s window for the EC to get its act together.

And we should probably reset the "attempted tries to switch to GPE interrupt
mode" counter (so that the code will retry interrupt mode again) after
events that are likely to have done a lot of internal churning to the EC.
Currently, those would be when resuming from S3 or S4, I think.

> In fact there also exists the mode switch from polling mode to interrupt
> mode after EC is initialized. Is it more appropriate that ec->gpe_retry
> is initialized?

We could use the same code to do the initial switch, indeed.

The two other things that we probably want to make sure we are doing are:

1. Drain the entire EC queue at every poll cycle (this is a must, really).

2. Try to drain the entire EC queue also in interrupt mode, but be careful
about dumb ECs that will sign 10 interrupts if there are 10 bytes to read in
the queue, even when we have drained the queue when servicing the very first
interrupt.   I bet there are ECs which will give you just one interrupt and
expect the queue to be drained, ECs which will give you interrupts until you
drain the queue (but no more than necessary), and ECs which will give you
interrupts for as many bytes as it stored in the queue, regardless of when
they were read... and we mustn't think there is an interrupt storm happening
because of this.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
