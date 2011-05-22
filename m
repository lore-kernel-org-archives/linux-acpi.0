From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 5/9] HWPoison: add memory_failure_queue()
Date: Sun, 22 May 2011 15:25:15 +0200
Message-ID: <20110522132515.GA13078@elte.hu>
References: <1305619719-7480-1-git-send-email-ying.huang@intel.com>
 <1305619719-7480-6-git-send-email-ying.huang@intel.com>
 <20110517084622.GE22093@elte.hu>
 <4DD23750.3030606@intel.com>
 <20110517092620.GI22093@elte.hu>
 <4DD31C78.6000209@intel.com>
 <20110520115614.GH14745@elte.hu>
 <BANLkTi=5Y0fqsmhsoPm8si=nQBc-tCwtrw@mail.gmail.com>
 <20110522100021.GA28177@elte.hu>
 <BANLkTi=VDQMOfWe5tP7nXSv2AEsiUUEteg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:34640 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805Ab1EVNZh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 May 2011 09:25:37 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=VDQMOfWe5tP7nXSv2AEsiUUEteg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>


* huang ying <huang.ying.caritas@gmail.com> wrote:

> On Sun, May 22, 2011 at 6:00 PM, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * huang ying <huang.ying.caritas@gmail.com> wrote:
> >
> >> On Fri, May 20, 2011 at 7:56 PM, Ingo Molnar <mingo@elte.hu> wrote=
:
> >> >
> >> > * Huang Ying <ying.huang@intel.com> wrote:
> >> >
> >> >> > So why are we not working towards integrating this into our e=
vent
> >> >> > reporting/handling framework, as i suggested it from day one =
on when you
> >> >> > started posting these patches?
> >> >>
> >> >> The memory_failure_queue() introduced in this patch is general,=
 that is, it
> >> >> can be used not only by ACPI/APEI, but also any other hardware =
error
> >> >> handlers, including your event reporting/handling framework.
> >> >
> >> > Well, the bit you are steadfastly ignoring is what i have made c=
lear well
> >> > before you started adding these facilities: THEY ALREADY EXISTS =
to a large
> >> > degree :-)
> >> >
> >> > So you were and are duplicating code instead of using and extend=
ing existing
> >> > event processing facilities. It does not matter one little bit t=
hat the code
> >> > you added is partly 'generic', it's still overlapping and duplic=
ated.
> >>
> >> How to do hardware error recovering in your perf framework? =A0IMH=
O, it can be
> >> something as follow:
> >>
> >> - NMI handler run for the hardware error, where hardware error
> >> information is collected and put into a ring buffer, an irq_work i=
s
> >> triggered for further work
> >> - In irq_work handler, memory_failure_queue() is called to do the =
real
> >> recovering work for recoverable memory error in ring buffer.
> >>
> >> What's your idea about hardware error recovering in perf?
> >
> > The first step, the whole irq_work and ring buffer already looks la=
rgely
> > duplicated: you can collect into a perf event ring-buffer from NMI =
context like
> > the regular perf events do.
>=20
> Why duplicated? perf uses the general irq_work too.

Yes, of course, because - if you still remember - Peter split irq_work =
out of=20
perf events:

 e360adbe2924: irq_work: Add generic hardirq context callbacks

 |
 | Perf currently has such a mechanism, so extract that and provide it =
as a=20
 | generic feature, independent of perf so that others may also benefit=
=2E
 |

:-)

But in hindsight the level of abstraction (for this usecase) was set to=
o low,=20
because we lose wider access to the actual events themselves:

> > The generalization that *would* make sense is not at the irq_work l=
evel=20
> > really, instead we could generalize a 'struct event' for kernel int=
ernal=20
> > producers and consumers of events that have no explicit PMU connect=
ion.
> >
> > This new 'struct event' would be slimmer and would only contain the=
 fields=20
> > and features that generic event consumers and producers need. Traci=
ng=20
> > events could be updated to use these kinds of slimmer events.
> >
> > It would still plug nicely into existing event ABIs, would work wit=
h event=20
> > filters, etc. so the tooling side would remain focused and unified.
> >
> > Something like that. It is rather clear by now that splitting out i=
rq_work=20
> > was a mistake. But mistakes can be fixed and some really nice code =
could=20
> > come out of it! Would you be interested in looking into this?
>=20
> Yes.  This can transfer hardware error data from kernel to user space=
=2E Then,=20
> how to do hardware error recovering in this big picture?  IMHO, we wi=
ll need=20
> to call something like memory_failure_queue() in IRQ context for memo=
ry=20
> error.

That's where 'active filters' come into the picture - see my other mail=
 (that=20
was in the context of unidentified NMI errors/events) where i outlined =
how they=20
would work in this case and elsewhere. Via active filters we could shar=
e most=20
of the code, gain access to the events and still have kernel driven pol=
icy=20
action.

Thanks,

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
