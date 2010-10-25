From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Mon, 25 Oct 2010 14:55:31 +0200
Message-ID: <20101025125531.GA6075@elte.hu>
References: <1287992610-14996-1-git-send-email-ying.huang@intel.com>
 <1287992610-14996-10-git-send-email-ying.huang@intel.com>
 <20101025084553.GA27119@elte.hu>
 <1287997112.2862.322.camel@yhuang-dev>
 <20101025091913.GA17622@basil.fritz.box>
 <20101025111530.GA27659@elte.hu>
 <20101025123753.GB17622@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:50804 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263Ab0JYMzy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Oct 2010 08:55:54 -0400
Content-Disposition: inline
In-Reply-To: <20101025123753.GB17622@basil.fritz.box>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Arjan van de Ven <arjan@infradead.org>


* Andi Kleen <andi@firstfloor.org> wrote:

> On Mon, Oct 25, 2010 at 01:15:30PM +0200, Ingo Molnar wrote:
> 
> > > > > einj.c: it's about the 3rd separate 'error injection' concept that got 
> > > > > introduced ...
> > > > 
> > > > EINJ is a true platform feature, not just software feature. We need to support 
> > > > it to debug various hardware error features.
> > > 
> > > Also having multiple error injecting interfaces is a good thing.
> > 
> > It's never a good thing to have separate, vendor dependent interfaces for what 
> > to the user is basically the same conceptual thing!
> 
> Perhaps a simple example (simplified, in practice there are more complications) 
> makes it more clear:
> 
> The memory error handler does different actions depending on what the state the 
> page the error is happening on is in.

What you appear to be arguing for is the ability to inject different types of 
events.

_OF COURSE_ we want that.

Just like we want to be able to _receive_ multiple types of events from wildly 
different hardware and wildly different kernel subsystems ...

Duh.

That desire does not necessiate 'three different injectors' at all. It does not 
necessiate multiple incompatible facilities with random ABIs.

What we want is a single injector facility visible to RAS/hw-testing/etc. apps, and 
a way to pass in attributes that specify the kind of event that we want to trigger.

Also note that you completely ignored the other basis of my objection and NAK: that 
the whole ad-hoc event log export that this code does via the /dev/erst-dbg ABI is 
actively harmful.

> Would it be nice if there was a single great injector that covers everything? Yes 
> Is it realistic? No.

Everyone else working on this area thinks it's realistic, and is in fact working on 
such a facility.

The main thing that is causing confusion here is not the technical viability of such 
a project (it's evidently doable and desirable), but your unwillingness to 
cooperate. If Intel goes into random directions and essentially obstructs upstream 
projects then we wont have this implemented on Intel CPUs sanely and cleanly - 
despite Mauro's best efforts on the Nehalem code.

But you should really not bring that up as some kind of positive argument ...

Thanks,

	Ingo
