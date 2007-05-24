From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] long freezes on thinkpad t60
Date: Thu, 24 May 2007 16:44:49 +0200
Message-ID: <20070524144447.GA25068@elte.hu>
References: <E1HrC3W-0005SZ-00@dorka.pomaz.szeredi.hu> <20070524125453.GA7554@elte.hu> <E1HrDuQ-0005m7-00@dorka.pomaz.szeredi.hu> <20070524141059.GA19872@elte.hu> <E1HrEIp-0005qy-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:41269 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbXEXOoz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 May 2007 10:44:55 -0400
Content-Disposition: inline
In-Reply-To: <E1HrEIp-0005qy-00@dorka.pomaz.szeredi.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tglx@linutronix.de


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> >  CONFIG_EVENT_TRACE=y
> >  CONFIG_FUNCTION_TRACE=y
> >  # CONFIG_WAKEUP_TIMING is not set
> >  # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
> >  CONFIG_MCOUNT=y
> > 
> > does it boot with these?
> 
> Nope.  Same segfault.  If I try to continue manually with 'init 5', 
> then init segfaults as well :(

could you just try v2.6.21 plus the -rt patch, which has the tracer 
built-in? That's a combination that should work well. You can pick it up 
from:

   http://people.redhat.com/mingo/realtime-preempt/

same config options as above. If you dont turn on PREEMPT_RT you'll get 
an almost-vanilla kernel.

	Ingo
