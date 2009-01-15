From: Olaf Dabrunz <od@suse.de>
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot
	interrupt equivalent
Date: Thu, 15 Jan 2009 13:36:07 +0100
Message-ID: <20090115123607.GS25512@suse.de>
References: <200901121151.53195.bjorn.helgaas@hp.com> <m1d4esxfk2.fsf@frodo.ebiederm.org> <1231806563.4094.25.camel@perihelion.bos.jonmasters.org> <20090113014723.GA11366@elte.hu> <m1prirx3xn.fsf@frodo.ebiederm.org> <1231820798.4094.34.camel@perihelion.bos.jonmasters.org> <20090114114006.GF8625@elte.hu> <1231960709.23174.0.camel@londonpacket.bos.redhat.com> <m11vv5wlug.fsf@frodo.ebiederm.org> <1231973760.23174.33.camel@londonpacket.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:34382 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929AbZAOMgK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jan 2009 07:36:10 -0500
Content-Disposition: inline
In-Reply-To: <1231973760.23174.33.camel@londonpacket.bos.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Stefan Assmann <sassmann@suse.de>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sven Dietrich <sdietrich@novell.com>, "Maciej W. Rozycki" <macro@linux-mips.org>

On 14-Jan-09, Jon Masters wrote:
> On Wed, 2009-01-14 at 14:42 -0800, Eric W. Biederman wrote:
> > Jon Masters <jcm@redhat.com> writes:
> >=20
> > > On Wed, 2009-01-14 at 12:40 +0100, Ingo Molnar wrote:
> > >
> > >> it's not just -rt, but it is also needed for the concept of thre=
aded IRQ=20
> > >> handlers - which was discussed at the Kernel Summit to be desire=
d for=20
> > >> mainline.
> > >
> > > Right. I'm poking at Thomas' patches and hope to post something s=
oon on
> > > that front - I'm acutely aware that this will be impacted aswell =
but
> > > because it's vaguely RT related had banded it under that banner.
> >=20
> > Stepping back a moment.  The only way I can see this working reliab=
ly
> > is if we disable the boot interrupt.  Anything that leaves the boot=
 interrupt
> > enabled means that when we disable the primary interrupt the boot i=
nterrupt
> > will scream, and thus we must disable it as well.
> >=20
> > Which leads to my problem with the entire development process of th=
is feature.
> >=20
> >  People want the feature.
> >  People don't want to pay attention to the limits of the hardware.
> >  Which leads to countless broken patches proposed.
>=20
> Is a patch broken because hardware has limitations? If that were alwa=
ys
> true then many of the patches we see in the kernel wouldn't be there.
>=20
> > Which leads me to conclude.
> > - IRQ handling in the RT kernel is hopelessly broken.
>=20
> Nope. It's done in a very similar way to other real time kernels alre=
ady
> out there - really there are only so many ways to do this.
>=20
> > - IRQ threads are a bad idea.
>=20
> Why? IRQ threads actually make life so much easier - you have a task
> context, you can do everything inside that rather than scheduling all
> kinds of deferred work (that in RT will be done in another task later=
),
> and so forth.
>=20
> > None of this works reliably on level triggered ioapic irqs.

Actually it works very well. The patches are also not _that_
complicated. We have two kinds of patches:

    1) if possible on the chipset, disable boot irqs (if in APIC mode)

       - this works as designed and has no problems

       - we cover up for broken BIOSes here that forget to disable boot
         irqs

    2) if we cannot disable boot irqs, disable the original interrupt
       line and only use the boot irq line -> no duplicated interrupts,
       but increased interrupt sharing

       - this is a hack for older, but widely used chipsets

       - we cover up for broken hardware (wrt threaded IRQ handling)

       - when the broken hardware falls out of use, this is not needed
         anymore


The only limitations we have so far:

    - For newer chipsets, we have to make sure that we find the disable
      bit. Vendors should put this bit in a common place.

    - It is a lot of work to describe all of the findings and
      experimental results we had, in a digestable way.

> Level triggered IOAPIC IRQs have quirks, film at 11!

Love this. *grin* :)

--=20
Olaf Dabrunz (od/odabrunz), SUSE Linux Products GmbH, N=C3=BCrnberg

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
