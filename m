From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] long freezes on thinkpad t60
Date: Thu, 24 May 2007 16:42:51 +0200
Message-ID: <20070524144251.GA24859@elte.hu>
References: <E1HrC3W-0005SZ-00@dorka.pomaz.szeredi.hu> <20070524125453.GA7554@elte.hu> <E1HrDuQ-0005m7-00@dorka.pomaz.szeredi.hu> <20070524141059.GA19872@elte.hu> <E1HrEIp-0005qy-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:41121 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbXEXOm5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 May 2007 10:42:57 -0400
Content-Disposition: inline
In-Reply-To: <E1HrEIp-0005qy-00@dorka.pomaz.szeredi.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tglx@linutronix.de


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> > hm, you should only need these:
> > 
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

does it go away if you turn off CONFIG_FUNCTION_TRACE? (that will make 
the trace a lot less verbose, but still informative)

	Ingo
