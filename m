From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] ACPI, APEI, Generic Hardware Error Source (GHES) injecting
 support
Date: Fri, 20 May 2011 13:53:07 +0200
Message-ID: <20110520115307.GG14745@elte.hu>
References: <1304996921-24881-1-git-send-email-ying.huang@intel.com>
 <20110516193301.GF29881@redhat.com>
 <4DD218B1.7080601@intel.com>
 <20110517135027.GJ31888@redhat.com>
 <20110517191803.GC29574@elte.hu>
 <20110517195757.GA31067@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:42508 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935640Ab1ETLx0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 May 2011 07:53:26 -0400
Content-Disposition: inline
In-Reply-To: <20110517195757.GA31067@liondog.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Don Zickus <dzickus@redhat.com>, Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kerne>


* Borislav Petkov <bp@alien8.de> wrote:

> On Tue, May 17, 2011 at 09:18:03PM +0200, Ingo Molnar wrote:
> > So for example [sufficienty privileged] user-space could inject *any*
> > perf event - for example a PERF_COUNT_HW_CACHE_MISSES event (for test
> > purposes) and any tooling that runs could not tell apart this injected
> > event from a real event.
> 
> Yeah about that, I was recently speculating how that would work. So do we do
> 
> $ perf record ...
> 
> in the one xterm, and, in the other,
> 
> $ perf inject
> 
> so that while recording, we can inject some events from userspace? Or
> do we inject it, it gets buffered somewhere in the meantime and then
> the next perf record session sees it along with the remaining injection
> events?

Well, for persistent events there would be interim buffering even if there's no 
observation going on anywhere. I.e. there's always an 'observer' of events.

For non-persistent events, if they are injected, then they are like trace 
events for which nobody is interested in: they are lost.

Thanks,

	Ingo
