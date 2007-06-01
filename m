From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Fri, 1 Jun 2007 23:40:53 +0200
Message-ID: <200706012340.54394.rjw@sisk.pl>
References: <878xb35sje.fsf@goat.bogus.local> <200706012237.17375.rjw@sisk.pl> <87k5un4bwk.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57718 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbXFAVe4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Jun 2007 17:34:56 -0400
In-Reply-To: <87k5un4bwk.fsf@goat.bogus.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

On Friday, 1 June 2007 23:12, Olaf Dietsche wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Friday, 1 June 2007 22:27, Olaf Dietsche wrote:
> >> When I resume, everything seems to come up (fan becomes busy, disk and
> >> dvd spin up for a short time),
> >
> > Hmm, what about the screen?
> 
> When the laptop is dead, screen remains black.
> 
> When I skip acpi_enter_sleep_state(), the screen works like everything
> else.

I think you should try s2ram (http://en.opensuse.org/s2ram) as the first step.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
