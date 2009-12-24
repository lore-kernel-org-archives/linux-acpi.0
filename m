From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] Asynchronous suspend/resume - test results
Date: Thu, 24 Dec 2009 23:10:42 +0100
Message-ID: <200912242310.42615.rjw@sisk.pl>
References: <200912210140.19713.rjw@sisk.pl> <200912232146.29339.rjw@sisk.pl> <4B32D2D6.3030707@crca.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55280 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755449AbZLXWK2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Dec 2009 17:10:28 -0500
In-Reply-To: <4B32D2D6.3030707@crca.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Thursday 24 December 2009, Nigel Cunningham wrote:
> Hi.

Hi, 

> I built the async branch of your tree and tested it, also running
> 2.6.33-rc1 + TuxOnIce for comparison. Dmesg for both are attached. Is
> there anything I can/should be doing for you on top of this?

No, thanks a lot.

> I'll try Dmitry's patch on top of this a little later - other things to do first.

No need for that, the patchset contains an equivalent of the Dmitry's patch.

> I noticed that you were doing standard deviations in your stats - how
> many runs were you basing them on?

I usually run 10 iterations of suspend-resume for each configuration.
The raw data are at http://www.sisk.pl/kernel/data/async-suspend-updated.pdf
if you're interested.

> Not sure that I can be bothered to do too many - too much else to do!

Sure, thanks a lot anyway.  Your data confirn that there's a measurable gain
from suspending and resuming devices asynchronously.

Have a merry Christmas and happy new year,
Rafael
