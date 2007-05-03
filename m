From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Why don't we use _TTS method?
Date: Fri, 4 May 2007 00:55:38 +0200
Message-ID: <200705040055.39007.rjw@sisk.pl>
References: <200705032201.49071.rjw@sisk.pl> <20070503222702.GC13426@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54885 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754054AbXECWvQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2007 18:51:16 -0400
In-Reply-To: <20070503222702.GC13426@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

Hi,

On Friday, 4 May 2007 00:27, Pavel Machek wrote:
> Hi!
> 
> > I've got two questions regarding the implementation of the ACPI poweroff/sleep
> > code in drivers/acpi/sleep and drivers/acpi/hardware .
> > 
> > 1) We don't seem to use the _TTS system-control method, although the ACPI
> > specification (ACPI 3.0b) says that this method should be used for intiating
> > and finishing power transitions.  Could you please tell me why we
> > don't use it?
> 
> I guess we simply overlooked that :-(.

Hmm, does it mean we should implement that?

> > 2) In the functions acpi_enter_sleep_state_prep(), acpi_enter_sleep_state(),
> > acpi_leave_sleep_state() we manipulate GPEs quite extensively (we disable
> > and enable them for a couple of times during a transition), although the
> > specification doesn't tell anything about that explicitly.  Could you please
> > explain to me what the purpose of that is?
> 
> We have had some notebooks auto-waking-up just after suspend. Perhaps
> those hacks are workarounds for that problem?

Well, maybe, but if there's anyone who knows *exactly* why we do this and
why it is done in these particular places, I would appreciate it very much if
she or he could explain that to me.

Currently we're having problems with some boxes due to the code reordering that
took place before 2.6.21 and I'm trying to figure out what the source of them
is.  In the process I've observed that the ACPI functions used by us in the
hibernation and suspend code generally don't follow the specification and I'd
like to understand if that's intentional and if so then why.

Also, I'd like to understand why the old code ordering seemed to work better
than the current one, although the current one is closer to what the ACPI spec
says (or so it seems).

Greetings,
Rafael
