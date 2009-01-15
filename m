From: Olaf Dabrunz <od@suse.de>
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot
	interrupt equivalent
Date: Thu, 15 Jan 2009 16:34:44 +0100
Message-ID: <20090115153444.GT25512@suse.de>
References: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain> <496B24E5.1070804@suse.de> <200901121151.53195.bjorn.helgaas@hp.com> <1231788349.4094.21.camel@perihelion.bos.jonmasters.org> <496C9807.1010109@suse.de> <20090113182259.GN25512@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45259 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbZAOPes (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jan 2009 10:34:48 -0500
Content-Disposition: inline
In-Reply-To: <20090113182259.GN25512@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Assmann <sassmann@suse.de>, Jon Masters <jcm@redhat.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@>

On 13-Jan-09, Olaf Dabrunz wrote:
> On 13-Jan-09, Stefan Assmann wrote:
> > Hi Jon,
> >=20
> > Jon Masters wrote:
> > > On Mon, 2009-01-12 at 11:51 -0700, Bjorn Helgaas wrote:
> > >> (I added Eric, Maciej, and Jon because they participated in
> > >> previous discussion here: http://lkml.org/lkml/2008/6/2/269)
> > >=20
> > > Thanks. You know what I'd really like even more than being on the=
 CC?
> > > I'd *love* someone to post a link to documentation on how this ac=
tually
> > > is supposed to work. We had to guess last time because none of th=
e
> > > public documentation actually explains this. The guys at SuSE lik=
ely
> > > received some docs, but I'm not sure where from or the title ther=
eof.
> >=20
> > Actually, most of the Boot Interrupt patches resulted from reading =
the
> > intel specs and observing the behavior of failing machines. We're t=
rying
> > to wrap up all the information gathered in a paper, which is pretty=
 time
> > consuming and a few steps away from being ready to publish.
>=20
> We read the specs of the chips, analyzed code, put up hypotheses and
> tested them. Then read the specs again, finding new hypotheses and
> tested again. Also reading what you guys sent out to lkml and reading
> through the public discussions for *BSD, Darwin, XEN etc. helped.
> And some colleagues discussed hypotheses and solution attempts with u=
s.
>=20
> We summarized many of our end results in a presentation that we gave
> internally, and I am working on making this available online (in
> addition to the paper/slides that Stefan mentions below).

The presentation can be found at

    http://www.suse.de/~odabrunz/Boot_Interrupts_and_IRQ_Threads.pdf

Some parts of it have been corrected and updated.

Please do not miss the "Details" slides after the License and the
Disclaimer. The Details should answer many questions.

Thanks,

--=20
Olaf Dabrunz (od/odabrunz), SUSE Linux Products GmbH, N=C3=BCrnberg

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
