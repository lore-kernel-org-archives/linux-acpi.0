From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 14:42:40 +0200
Message-ID: <200706211442.41140.rjw@sisk.pl>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com> <200706201332.25486.rjw@sisk.pl> <200706210004.03544.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52264 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbXFUMgA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 08:36:00 -0400
In-Reply-To: <200706210004.03544.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday, 21 June 2007 09:04, David Brownell wrote:
> On Wednesday 20 June 2007, Rafael J. Wysocki wrote:
> > On Wednesday, 20 June 2007 08:18, Shaohua Li wrote:
> > > On Tue, 2007-06-19 at 13:52 +0200, Rafael J. Wysocki wrote:
> > > > On Tuesday, 19 June 2007 04:33, Shaohua Li wrote:
> > > > > Based on David's patch
> > > > > http://marc.info/?l=linux-acpi&m=117873972806360&w=2
> > > > > I slightly changed it.
> > > > > 
> > > > > Add a helper routine, which gets the sleep state of a ACPI device.
> > > > 
> > > > Is it going to work with the recent code ordering changes?  I mean,
> > > > acpi_pm_prepare() is now called after device_suspend() (and analogously for
> > > > the hibernation), so the target ACPI state is not known when the drivers'
> > > > .suspend() routines are being called.
> >
> > > Not. Could pm_message_t have a member indicating the suspend state?
> > 
> > Well, I thought about that, but I did't know what people on linux-pm would
> > think about that.
> 
> Let's get rid of pm_message_t entirely.  Didn't we already discuss
> how the main reasons for it will vanish if drivers get new PM methods?
> 
>  
> > Alternatively, we could introduce a pm_target() global PM operation that will
> > set the target sleep state for the entire system.
> 
> I hope you mean "get the target state"!!
> 
> If drivers actually need a handle on that state, that'd be a fair
> approach; make it an opaque type though, platform-specific.
> 
> But actually I don't see much point to having such a struct.  What
> matters is the attributes of the target state (what resources will
> be present, especially), and that rarely needs to be indicated by
> any kind of cookie.  Consider the "current" task ... it's implicit,
> always present (except in IRQ contexts), and hardly ever accessed
> despite being more fundamental than "target PM state".

The issue at hand is that some device drivers may need to know what the
target sleep state of the system will be when their .suspend() routines are
being executed.  Currently, there's no means of passing that information to the
drivers and my question is how to do this.

IMO it can be done in two different ways:
1) via a .suspend() argument
2) via a global variable that the drivers can read.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
