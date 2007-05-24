From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [BUG] long freezes on thinkpad t60
Date: Thu, 24 May 2007 16:28:31 +0200
Message-ID: <E1HrEIp-0005qy-00@dorka.pomaz.szeredi.hu>
References: <E1HrC3W-0005SZ-00@dorka.pomaz.szeredi.hu> <20070524125453.GA7554@elte.hu> <E1HrDuQ-0005m7-00@dorka.pomaz.szeredi.hu> <20070524141059.GA19872@elte.hu>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:47034 "EHLO
	mail-gw2.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbXEXO3Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 May 2007 10:29:16 -0400
In-reply-to: <20070524141059.GA19872@elte.hu> (message from Ingo Molnar on
	Thu, 24 May 2007 16:10:59 +0200)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tglx@linutronix.de

> > > how reproducable are these lockups - could you possibly trace it? If 
> > > yes then please apply:
> > > 
> > >   http://www.tglx.de/private/tglx/ht-debug/tracer.diff
> > 
> > With this patch boot stops at segfaulting fsck.  I enabled all the new 
> > config options, is that not a good idea?  Which one exactly do I need?
> 
> hm, you should only need these:
> 
>  CONFIG_EVENT_TRACE=y
>  CONFIG_FUNCTION_TRACE=y
>  # CONFIG_WAKEUP_TIMING is not set
>  # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
>  CONFIG_MCOUNT=y
> 
> does it boot with these?

Nope.  Same segfault.  If I try to continue manually with 'init 5',
then init segfaults as well :(

Miklos
