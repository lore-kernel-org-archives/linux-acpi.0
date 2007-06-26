From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target method in pm_ops
Date: Tue, 26 Jun 2007 11:41:33 +0200
Message-ID: <200706261141.35071.rjw@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706242240.40476.rjw@sisk.pl> <1182806886.6644.4.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43741 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbXFZJeo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2007 05:34:44 -0400
In-Reply-To: <1182806886.6644.4.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Igor Stoppa <igor.stoppa@nokia.com>

On Monday, 25 June 2007 23:28, Johannes Berg wrote:
> On Sun, 2007-06-24 at 22:40 +0200, Rafael J. Wysocki wrote:
> 
> > + * @set_target: Tell the platform which system sleep state is going to be
> > + *	entered.  The information passed to @set_target should be disregarded
> > + *	by the platform as soon as @finish() is executed and if	@prepare()
> > + *	fails.
> > + *	This callback is optional.  However, if it is implemented, the
> > + *	argument passed to @prepare(), @enter and @finish() must be ignored.
> 
> I don't understand the point in mandating that then the argument to
> enter() is to be ignored, why bother? It doesn't look as though we can
> possibly do anything with the semantics here that would mean the state
> set by set_target is different to the state passed to enter(), can we?

In principle we can't, but I think that it should be "either, or".  Either the
platform implements set_target() and uses the value provided by it, or it
uses the argument passed to the other functions.

Alternatively, I could write that the argument passed to .enter() etc. is
guaranteed to be the same as the one passed to .set_target(), but I didn't want
to say that. :-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
