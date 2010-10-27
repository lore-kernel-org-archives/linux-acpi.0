From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [NAK] Re: [PATCH -v2 9/9] ACPI, APEI, Generic Hardware Error
 Source POLL/IRQ/NMI notification type support
Date: Wed, 27 Oct 2010 10:25:37 +0200
Message-ID: <20101027082537.GA23945@elte.hu>
References: <20101025084553.GA27119@elte.hu>
 <1287997112.2862.322.camel@yhuang-dev>
 <20101025091913.GA17622@basil.fritz.box>
 <20101025111530.GA27659@elte.hu>
 <20101025123753.GB17622@basil.fritz.box>
 <20101025125531.GA6075@elte.hu>
 <20101025131127.GC17622@basil.fritz.box>
 <20101025134740.GA8888@elte.hu>
 <20101025151427.GD17622@basil.fritz.box>
 <20101025171022.GA29803@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:33058 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755425Ab0J0I0D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Oct 2010 04:26:03 -0400
Content-Disposition: inline
In-Reply-To: <20101025171022.GA29803@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Arjan van de Ven <arjan@infradead.org>


Btw., just for the record. Two days ago you started getting personal:

* Andi Kleen <andi@firstfloor.org> wrote:

> That's not really the old Ingo I used to know.

But when i (again) outlayed all the technical reasons for the NAK, you did not 
answer. You also did not answer Thomas's technical mail either.

I've seen this behavior many times from you: when the technical argument goes 
against you, when many people are telling you that you are mostly wrong, you do not 
concede, you do not argue in support of your position, you simply ignore the 
discussion from that point on and you pretend that the discussion does not exist 
anymore.

Then a few weeks/months down the line this same pattern repeats: there's another 
similar incident somewhere else, and i'm (or others) are forced to NAK the hard way. 
You then claim it's unreasonable and you act as if the prior discussions did not 
happen at all. Rinse and repeat. Most people dont remember so it even looks 
plausible to the casual observer.

The thing is, upstream NAKs need to be addressed in good faith.

Again: i'm NAK-ing the use of the x86 NMI notifier chain in this fashion and i'm 
NAK-ing the exports that this patch is adding to arch/x86/. It's not the proper 
approach for the many reasons we outlined - debug facilities want to be organized in 
the core, not spread out to vendor-specific fringes.

I wouldnt mind as much if this was a driver for hw few people care about - but this 
looks like a useful piece of Intel hardware whose Linux support you are messing up 
thoroughly by exporting an ABI in the worst possible way. We can and should do 
better than this.

Thanks,

	Ingo
