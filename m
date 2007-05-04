From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI code in platform mode hibernation code paths (was: Re: [PATCH] swsusp: do not use pm_ops)
Date: Fri, 4 May 2007 14:29:07 +0200
Message-ID: <200705041429.08604.rjw@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <1178276072.7408.7.camel@johannes.berg> <20070504120802.GF13426@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56838 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635AbXEDMYo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 May 2007 08:24:44 -0400
In-Reply-To: <20070504120802.GF13426@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, Alexey Starikovskiy <aystarik@gmail.com>, linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

On Friday, 4 May 2007 14:08, Pavel Machek wrote:
> Hi!
> 
> > > Crazy idea... could we kill hibernate_ops-like struct, and just create
> > > a device for ACPI, using its suspend()/resume()/whatever callbacks to
> > > do the ACPI magic?
> > 
> > Doesn't that have the ordering problem again? You must ensure that this
> > sysdev is suspended as the last one, and that's currently impossible if
> > ACPI is modular.
> 
> I do not think acpi has these kinds of ordering requirements... (And I
> do not see what it has to do with module or not).

Theoretically, ACPI has some ordering requirements.  For example, according to
the spec, the _PTS system-control method should be executed *after* devices are
placed in the appropriate Dx states, which (theoretically) requires us to
execute it after device_suspend() (we don't do this in practice, but I think we
should).

There are some more ordering assumptions like this in the spec and I think
we should at least try to follow them or, if that breaks things, document why
we don't.

That's why I think we should try to do what's needed using hibernation_ops 
(perhaps we'll need to add a couple of callbacks to hibernation_ops) and
then try to replace hibernation_ops with another mechanism allowing us to do
the same.  We first need to determine which operations have to be carried out
at what points so that things don't break.

Greetings,
Rafael
