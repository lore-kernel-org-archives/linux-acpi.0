From: Olaf Dabrunz <od@suse.de>
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot
	interrupt equivalent
Date: Tue, 13 Jan 2009 19:22:59 +0100
Message-ID: <20090113182259.GN25512@suse.de>
References: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain> <496B24E5.1070804@suse.de> <200901121151.53195.bjorn.helgaas@hp.com> <1231788349.4094.21.camel@perihelion.bos.jonmasters.org> <496C9807.1010109@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57010 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199AbZAMSXE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Jan 2009 13:23:04 -0500
Content-Disposition: inline
In-Reply-To: <496C9807.1010109@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@suse.de>
Cc: Jon Masters <jcm@redhat.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sven Dietrich <sdietrich@novell.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "Maciej W. Rozycki" <macro@linux-mips.org>

On 13-Jan-09, Stefan Assmann wrote:
> Hi Jon,
>=20
> Jon Masters wrote:
> > On Mon, 2009-01-12 at 11:51 -0700, Bjorn Helgaas wrote:
> >> (I added Eric, Maciej, and Jon because they participated in
> >> previous discussion here: http://lkml.org/lkml/2008/6/2/269)
> >=20
> > Thanks. You know what I'd really like even more than being on the C=
C?
> > I'd *love* someone to post a link to documentation on how this actu=
ally
> > is supposed to work. We had to guess last time because none of the
> > public documentation actually explains this. The guys at SuSE likel=
y
> > received some docs, but I'm not sure where from or the title thereo=
f.
>=20
> Actually, most of the Boot Interrupt patches resulted from reading th=
e
> intel specs and observing the behavior of failing machines. We're try=
ing
> to wrap up all the information gathered in a paper, which is pretty t=
ime
> consuming and a few steps away from being ready to publish.

We read the specs of the chips, analyzed code, put up hypotheses and
tested them. Then read the specs again, finding new hypotheses and
tested again. Also reading what you guys sent out to lkml and reading
through the public discussions for *BSD, Darwin, XEN etc. helped.
And some colleagues discussed hypotheses and solution attempts with us.

We summarized many of our end results in a presentation that we gave
internally, and I am working on making this available online (in
addition to the paper/slides that Stefan mentions below).

The "real" paper still needs much work.

> > If we all knew how this was supposed to work then we might have a m=
uch
> > better likelihood of fixing this behavior. It's only going to get w=
orse
> > over time - we want to get threaded IRQs upstream (I'm about to be
> > poking at that again over here) and that'll mean mainline has to le=
arn
> > to deal with these boot interrupts just as much as RT does today.
>=20
> At the moment I'm uploading the slides we showed at the 10th
> Real-Time Linux Workshop, which are a small, stripped down excerpt of
> our upcoming paper.
>=20
> It should be available soon at:
> ftp://ftp.suse.com/pub/people/sassmann/publication/boot_irq_quirks_rt=
lws10.pdf
>=20
> Meanwhile I'd suggest to have a look at United States Patent 6466998.
> That is intels patent for this interrupt routing mechanism.
>=20
> Hope this is helpful, we'll try to make more information available as=
ap.
>=20
> >=20
> > Jon.
> >=20
>=20
>   Stefan
>=20
> --=20
> Stefan Assmann          | SUSE LINUX Products GmbH
> Software Engineer       | Maxfeldstr. 5, D-90409 Nuernberg
> Mail: sassmann@suse.de  | GF: Markus Rex, HRB 16746 (AG Nuernberg)

--=20
Olaf Dabrunz (od/odabrunz), SUSE Linux Products GmbH, N=C3=BCrnberg

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
