From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target method in pm_ops
Date: Tue, 26 Jun 2007 22:14:50 +0200
Message-ID: <200706262214.51413.rjw@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706261141.35071.rjw@sisk.pl> <200706261019.59712.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46087 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757830AbXFZUHu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2007 16:07:50 -0400
In-Reply-To: <200706261019.59712.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Igor Stoppa <igor.stoppa@nokia.com>

On Tuesday, 26 June 2007 19:19, David Brownell wrote:
> On Tuesday 26 June 2007, Rafael J. Wysocki wrote:
> 
> > Alternatively, I could write that the argument passed to .enter() etc. is
> > guaranteed to be the same as the one passed to .set_target(), but I didn't want
> > to say that. :-)
> 
> Why not?  So long as enter() takes an argument, that seems
> to me exactly what it should guarantee.

Okay, I can change the wording, although reluctantly.  [Please have a look at
[PATCH 1/8] in the updated series, the comment is a bit different in there,
with "should" instead of "must" which I think is correct.] 

> Although that argument should vanish; any platform that differentiates
> what it does based on that parameter can just be required
> to provide a set_target() method.

Well, I'd like to leave the option for defining only .enter(), without the
other callbacks (some platforms do it and I don't see why we should force
them to complicate things).

In fact, what I wanted the comment to _mean_ after applying the entire patchset
is that either you can define .set_target(), in which case you should use what
it gives you and not anything else, or you can define only .enter(), in which
case its argument represents the target state.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
