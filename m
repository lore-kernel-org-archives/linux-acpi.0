From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup and fixes
Date: Fri, 21 Mar 2008 17:23:16 +0100
Message-ID: <200803211723.17685.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org> <200803210247.18686.rjw@sisk.pl> <200803210115.04210.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41514 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674AbYCUQXo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 12:23:44 -0400
In-Reply-To: <200803210115.04210.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Friday, 21 of March 2008, David Brownell wrote:
> On Thursday 20 March 2008, Rafael J. Wysocki wrote:
> > Is there any reason why pci_choose_state() should try to figure out=
 what kind
> > of operation is being performed by the driver and tailor its output=
 to that?
>=20
> It's always been specified to do that ... but it's always done
> that in a buggy way.  (Which is why USB never used it.)

I hope you realize that your change will affect all drivers calling
pci_choose_state() on ACPI systems on FREEZE/PRETHAW in a hard to predi=
ct
way?  Perhaps some of them actually rely on getting D3hot on FREEZE, fo=
r
example?

> > I don't think so. =A0Rather, the driver should know what it's doing=
 and either
> > call pci_choose_state() or not. =A0If the state of the device is no=
t to be
> > changed, there's no reason to call pci_choose_state() at all.
>=20
> You seem to object to letting drivers offload this particular
> bit of work to infrastructure.

No, I don't.  I just don't think it's a good idea to change the existin=
g and
widely used function for this purpose.  If I needed some specific funct=
ionality
at the infrastructure level, I'd add a new function for that with a new
changelog etc.  Then, made drivers switch to that and remove the old on=
e.

> What's the dividing line between being OK to offload vs not eing OK? =
 Why not
> let the drivers make that choice?
>=20
>=20
> > 	[Note that with the new suspend/hibernation callbacks there
> > won't be the pm_message_t argument to pass to pci_choose_state().]
>=20
> The pm_message_t will necessarily linger until all drivers have
> been converted and re-tested.  Which can't be an overnight thing.

No, it can't.  Still, suppose a driver is using the new callbacks.  How=
 is it
supposed to use pci_choose_state()?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
