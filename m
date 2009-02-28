From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: experimental patch for toshiba_acpi
Date: Sat, 28 Feb 2009 12:19:33 -0300
Message-ID: <20090228151933.GC17541@khazad-dum.debian.net>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov> <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk> <20090225165152.GA5981@srcf.ucam.org> <a0c408570902260512t702b2575w417ef96dfa74a5bf@mail.gmail.com> <1235657022.3802.86.camel@hughsie-work.lan> <1235663518.4770.197.camel@penguin.lifesci.dundee.ac.uk> <1235753349.5444.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49155 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966AbZB1PU3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Feb 2009 10:20:29 -0500
Content-Disposition: inline
In-Reply-To: <1235753349.5444.53.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Jonathan Buzzard <jonathan@buzzard.me.uk>, John Belmonte <john@neggie.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Charles@schwieters.org, linux-acpi@vger.kernel.org

On Fri, 27 Feb 2009, Richard Hughes wrote:
> In the meantime, you've insulted me enough for one email thread.
> 
> Len, I would agree with Matthew that the patch should not be merged, and
> that any missing functionality should be added to the existing ACPI
> driver.

FWIW, I also think the patch, as it stands, is NOT a good idea.

I will ignore the human interaction protocol screwups that happened in
the thread even if they left me with a bad taste in the mouth just
from watching from the outside.

There are strong technical reasons to not accept the patch IMHO:

1. If something can brick a box, access to it must not be provided
   unfiltered, not even kernel-side (through exported functions,
   active virtual memory regions that a bug could overwrite, etc),
   let alone to userland.  At least not as the normal operational mode
   of a driver (might-brick-something functionality hidden behind a
   developer mode accessed through a Kconfig option would be OK).

   If there isn't a safe group of functions for all models the driver
   will load at, filtering must be done by whitelisting.  It really
   doesn't matter if the table will be big, it can live in __initdata,
   in fact, if it were not for the can-brick stuff, it could be done
   through the firmware interface (easy upgrading for new models).

   If filtering is implemented, giving userspace access through
   /dev/toshiba for selected HCI functions would not be a problem.
   However, see (2) below.

2. Standard kernel functionality is to be made accessible through
   standard kernel interfaces.  This means brightness control and
   rfkill control, power supplies, thermal and fan control, hotkeys
   and generic event reporting, among others.

   Userspace could use /dev/toshiba for anything else there isn't a
   generic interface for, though.

   Access to such functionality also through /dev/toshiba should be
   provided only for backwards compatibility, with a set date for
   removal (say, one year).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
