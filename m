From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Introduce pm_power_off_prepare
Date: Wed, 4 Jul 2007 23:52:02 +0200
Message-ID: <200707042352.02563.rjw@sisk.pl>
References: <200707012051.48338.rjw@sisk.pl> <200707042342.27427.rjw@sisk.pl> <20070704213910.GA1836@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50994 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757160AbXGDVo0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Jul 2007 17:44:26 -0400
In-Reply-To: <20070704213910.GA1836@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, 4 July 2007 23:39, Pavel Machek wrote:
> Hi!
> 
> > > > Introduce the pm_power_off_prepare() callback that can be registered by the
> > > > interested platforms in analogy with pm_idle() and pm_power_off(), used for
> > > > preparing the system to power off (needed by ACPI).
> > > > 
> > > > This allows us to drop acpi_sysclass and device_acpi that are only defined in
> > > > order to register the ACPI power off preparation callback, which is needed by
> > > > pm_power_off() registered in a much different way.
> > > 
> > > Well, the acpi way works with more than one piece of code "listening"
> > > for powerdowns... and does not seem that ugly to me.
> > > 
> > > Okay, so accessing system_state is not _that_ nice... aha, and perhaps
> > > I understand why 1/2 of this series is right... it called prepare for
> > > S4 even when we had shutdown in /sys/power/disk, right?
> > > 
> > > Hmm. Okay, I think I can ACK both of these patches, but ACPI people
> > > should have chance to comment, and it probably needs to stay in -mm
> > > for a while.
> > 
> > Well, linux-acpi in on the CC list and I see no comments from them. :-)
> 
> Hmm, that's bad. We can try adding "APM rocks" into subject line to
> get their attetion or something...

Well, I take the lack of comments as the lack of objections. ;-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
