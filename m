From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Fri, 6 Jun 2008 11:50:24 -0700
Message-ID: <20080606115024.387b5f80.akpm@linux-foundation.org>
References: <200806051100.12885.dex@dragonslave.de>
	<20080606031718.36cbbdc9.akpm@linux-foundation.org>
	<200806061930.29046.dex@dragonslave.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57806 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755063AbYFFSub (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Jun 2008 14:50:31 -0400
In-Reply-To: <200806061930.29046.dex@dragonslave.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: webmaster@dragonslave.de
Cc: Daniel Exner <dex@dragonslave.de>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 6 Jun 2008 19:30:28 +0200 Daniel Exner <dex@dragonslave.de> wrote:

> Andrew Morton wrote:
> > (cc linux-acpi)
> >
> > On Thu, 5 Jun 2008 11:00:12 +0200 Daniel Exner <dex@dragonslave.de> wrote:
> > > Hi!
> > >
> > > (Added myself to CC, because I'm not subscribed)
> > >
> > > with linux-next snapshot 20080604 my Laptop morphes into sitting duck and
> > > I think this is due to this:
> >
> > I assume 2.6.26-rc5 is OK?
> Indeed.. just tried it with (nearly) the same config: no unable to locate 
> IOAPIC
> 
> Will try todays next snapshot above -rc5 now.

OK, thanks.

It would be great if you could test 2.6.26-rc5 plus
http://userweb.kernel.org/~akpm/git-acpi.patch.  That'll allow us to
confirm that the regression is due to changes in the acpi tree.

> BTW: Any chance to get this damn thing to not route everything by IRQ 11 !?

ooh, wrong guy to ask, sorry.
