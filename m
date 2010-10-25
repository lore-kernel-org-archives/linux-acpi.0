From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Mon, 25 Oct 2010 15:02:23 +0200
Message-ID: <20101025130223.GA7012@elte.hu>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
 <1287992610-14996-10-git-send-email-ying.huang@intel.com>
 <20101025084553.GA27119@elte.hu>
 <1287997112.2862.322.camel@yhuang-dev>
 <20101025091913.GA17622@basil.fritz.box>
 <20101025111530.GA27659@elte.hu>
 <20101025123753.GB17622@basil.fritz.box>
 <20101025125531.GA6075@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:44087 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab0JYNCu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 09:02:50 -0400
Content-Disposition: inline
In-Reply-To: <20101025125531.GA6075@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Arjan van de Ven <arjan@infradead.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> > The memory error handler does different actions depending on what the state the 
> > page the error is happening on is in.
> 
> What you appear to be arguing for is the ability to inject different types of 
> events.
> 
> _OF COURSE_ we want that.
> 
> Just like we want to be able to _receive_ multiple types of events from wildly 
> different hardware and wildly different kernel subsystems ...
> 
> Duh.
> 
> That desire does not necessiate 'three different injectors' at all. It does not 
> necessiate multiple incompatible facilities with random ABIs.

And note that once there's a generic facility that allows event injection, the 
actual low level implementation might of course be hardware specific. There's no 
reduction in actual feature richness: if the hw can do fancy things, it can be 
expressed via a generic facility as well.

What i object to is the narrow hardware specificity (and ad-hocness) of the high 
level interface and its non-integration into existing facilities.

Thanks,

	Ingo
