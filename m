From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Tue, 9 Sep 2008 09:18:17 -0700
Message-ID: <200809090918.18343.david-b@pacbell.net>
References: <20080908091926.785882370@sli10-desk.sh.intel.com> <200809081956.42663.david-b@pacbell.net> <200809091309.01433.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:31169 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751529AbYIIQ0N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2008 12:26:13 -0400
In-Reply-To: <200809091309.01433.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: shaohua.li@intel.com, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu

On Tuesday 09 September 2008, Rafael J. Wysocki wrote:
> >=20
> > Another rather important case is bridges. =A0I observe that with AC=
PI
> > the way PME# is handled for add-in cards _seems_ to be that the bri=
dge
> > for that PCI bus segment gets a GPE (presumably matching the PME#
> > signal for that bus segment, and maybe for its subsidiaries). =A0Th=
at
> > suggests the bridge will need to scan its children to find out whic=
h
> > one(s) issued PME#. =A0You didn't include such code here, where tha=
t
> > notification will be received...
>=20
> AFAICS, the 'original' PCI PME# (as opposed to the PCI Express native=
 PME)
> signal is supposed to be routed _around_ bridges and (presumably) the=
 entire
> PME# network would share one GPE in that case.

To the extent that board designers are expected to follow
such rules, but have the power not to do so, we know that
relying on such expectations would be ... unwise.  ;)

Isn't the notion of a GPE pretty much an x86-ism?
=46or non-x86 systems I'd just think "IRQ".  And for
x86, I regularly wonder if maybe chaining through
genirq wouldn't make SCI interrupts, including GPEs,
become a lot more robust.  :(

I suspect folk maintaining non-ACPI platforms with PCI
wiill have to help sort out this particular issue.  I
suspect their board designs will provide at least one
PME# indication.  ISTR multiple PME# domains were OK,
at least in the "one per root bridge" sense, but I've
not looked at the relevant spec recently.


> Then, we'd actually have to=20
> check all of the PCI devices to see which of them caused the event to=
 happen.

That emphasizes my point:  that patch #3 needs to include code
to handle bridges, scanning wakeup-eligible devices until it
finds the relevant one(s).

Of course there should be a few ways to speed that scanning:

 - First, bridges shouldn't need to scan devices for which PME#
   was not enabled.  Make pci_enable_wake() record that state
   for use in scanning ... look at that handful of devices first.
   (And possibly the rest later, in case of errors.)

 - Second, ACPI-specific, is to recognize that the mainboard
   devices all seem to be associated with private GPEs so they
   can get direct wake event notifications.  So when the PCI
   device getting this notification/probe isn't a bridge, it
   won't need to scan other devices.

EVERY system I have here seems to have PCI devices, including
ones in add-in slots, which will require that scanning ...
because they don't show up in the ACPI tables (second case).

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
