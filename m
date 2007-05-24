From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] long freezes on thinkpad t60
Date: Thu, 24 May 2007 16:10:59 +0200
Message-ID: <20070524141059.GA19872@elte.hu>
References: <E1HrC3W-0005SZ-00@dorka.pomaz.szeredi.hu> <20070524125453.GA7554@elte.hu> <E1HrDuQ-0005m7-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750938AbXEXOLS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1HrDuQ-0005m7-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tglx@linutronix.de
List-Id: linux-acpi@vger.kernel.org


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> > how reproducable are these lockups - could you possibly trace it? If 
> > yes then please apply:
> > 
> >   http://www.tglx.de/private/tglx/ht-debug/tracer.diff
> 
> With this patch boot stops at segfaulting fsck.  I enabled all the new 
> config options, is that not a good idea?  Which one exactly do I need?

hm, you should only need these:

 CONFIG_EVENT_TRACE=y
 CONFIG_FUNCTION_TRACE=y
 # CONFIG_WAKEUP_TIMING is not set
 # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
 CONFIG_MCOUNT=y

does it boot with these?

	Ingo
