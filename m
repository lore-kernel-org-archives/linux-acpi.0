From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [linux-pm] [patch update 2 fix] PM: Introduce core framework
 for  run-time PM of I/O devices
Date: Mon, 22 Jun 2009 06:49:15 -0700
Message-ID: <20090622064915.741154a7@infradead.org>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
	<Pine.LNX.4.44L0.0906201010590.12994-100000@netrider.rowland.org>
	<aec7e5c30906212320v3e3e991fyd028d005675f1e25@mail.gmail.com>
	<20090621234324.06fda564@infradead.org>
	<aec7e5c30906220027v63c88e8aj32950a8d84558cce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:40080 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbZFVNs3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 09:48:29 -0400
In-Reply-To: <aec7e5c30906220027v63c88e8aj32950a8d84558cce@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Mon, 22 Jun 2009 16:27:29 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> On Mon, Jun 22, 2009 at 3:43 PM, Arjan van de
> Ven<arjan@infradead.org> wrote:
> > On Mon, 22 Jun 2009 15:20:43 +0900
> > Magnus Damm <magnus.damm@gmail.com> wrote:
> >
> >> On Sat, Jun 20, 2009 at 11:30 PM, Alan
> >> Stern<stern@rowland.harvard.edu> wrote:
> >> > Some more thoughts...
> >> >
> >> > Magnus, you might have some insights here. =C2=A0It occurred to =
me
> >> > that some devices can switch power levels very quickly, and the
> >> > drivers might therefore want the runtime suspend and resume
> >> > methods to be called as soon as possible, even in interrupt
> >> > context.
> >>
> >> I'd like to call pm_request_suspend() from interrupt context. I
> >> don't
> >
> > there are some really strong reasons to at least be able to call th=
e
> > resume function from an interrupt handler.... shared interrupts are
> > one of them.
>=20
> I suppose you mean that you need to resume the hardware device before
> you can check if it has a pending interrupt source? If so then you
> also mean that suspended hardware devices may generate interrupts, no=
?

yes and no. For the shared interrupt case.. no.
but yes for the hw I have in mind (and on my desk ;-) that can happen
as well from the device itself.

--=20
Arjan van de Ven 	Intel Open Source Technology Centre
=46or development, discussion and tips for power savings,=20
visit http://www.lesswatts.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
