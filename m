From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup and fixes
Date: Sat, 22 Mar 2008 10:55:12 -0700
Message-ID: <200803221055.12541.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org> <200803210115.04210.david-b@pacbell.net> <200803211723.17685.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:26793 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753675AbYCVRzS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Mar 2008 13:55:18 -0400
In-Reply-To: <200803211723.17685.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Friday 21 March 2008, Rafael J. Wysocki wrote:
> >=20
> > You seem to object to letting drivers offload this particular
> > bit of work to infrastructure.
>=20
> No, I don't. =A0I just don't think it's a good idea to change the exi=
sting and
> widely used function for this purpose. =A0If I needed some specific f=
unctionality
> at the infrastructure level, I'd add a new function for that with a n=
ew
> changelog etc. =A0Then, made drivers switch to that and remove the ol=
d one.

I see that a lot of drivers have at some point, not long ago,
been converted to use this routine.  They previously just
used PCI_D3 in all cases.

It seems to me that your objection boils down to the concern
that those drivers may just have pushed their bug out a level,
rather than actually fixing their bugs.

Which I can sympathize with ... but that doesn't change the
fact that any driver in that position *still* has a bug that
needs to be fixed.  And if that bug is highlighted by this
patch ... well, there's still a driver bug to be fixed.


> > > =A0=A0=A0=A0[Note that with the new suspend/hibernation callbacks=
 there
> > > won't be the pm_message_t argument to pass to pci_choose_state().=
]
> >
> > The pm_message_t will necessarily linger until all drivers have
> > been converted and re-tested. =A0Which can't be an overnight thing.
>
> No, it can't. =A0Still, suppose a driver is using the new callbacks. =
=A0How is
> it supposed to use pci_choose_state()?

Hey, you're the one providing those callbacks.  How were you
going to answer that question *before* I posted this overdue
bugfix patch for pci_choose_state()?

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
