From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Asus M6*, A6*, L5D - can't reboot after suspend/resume
Date: Thu, 28 Jun 2007 23:23:21 +0200
Message-ID: <200706282323.21340.rjw@sisk.pl>
References: <87myyjdcp6.fsf@vertex.dottedmag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56598 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759668AbXF1VQC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jun 2007 17:16:02 -0400
In-Reply-To: <87myyjdcp6.fsf@vertex.dottedmag.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mikhail Gusarov <dottedmag@dottedmag.net>
Cc: linux-acpi@vger.kernel.org

On Thursday, 28 June 2007 22:52, Mikhail Gusarov wrote:
> Hi.
> 
> ping'ing mailing list: there is stuck bug in bugzilla and probably fresh eyes
> need to look at it to find the obvious solution :) Sorry if this noise is
> unnecessary.
> 
> Bug is http://bugzilla.kernel.org/show_bug.cgi?id=8598
> 
> Summary:
> 
> Most recent kernel where this bug did not occur: n/a
> Distribution: debian/sid
> Hardware Environment: Asus A6B, A6BA, M6A, M6N, M6NE, L5D notebooks
> Problem Description: After S3 STR reboot does not work, reboot=w,h and
> reboot=c,b, no luck. System shows message about restarting system. Caps lock and
> num lock LEDs flash, but it does not reboot.
> 
> I personally have only M6N notebook, so can test things only on it.

I'm afraid that this is not an easy problem.  It shows up on two of my own test
machines and I have no idea how to debug it further, let alone fixing.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
