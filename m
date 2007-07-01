From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and hibernation operations framework
Date: Sun, 1 Jul 2007 12:01:31 +0200
Message-ID: <200707011201.33111.rjw@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl> <20070630232222.GA8100@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36488 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755513AbXGAJyc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Jul 2007 05:54:32 -0400
In-Reply-To: <20070630232222.GA8100@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Nigel Cunningham <nigel@nigel.suspend2.net>

On Sunday, 1 July 2007 01:22, Russell King wrote:
> On Sat, Jun 30, 2007 at 10:57:16PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This series of patches implements changes that are possible/necessary/desirable
> > (IMO) after the introduction of the .set_target() method in 'struct pm_ops'
> > (the patch that introduces it is in -mm,
> > http://marc.info/?l=linux-mm-commits&m=118306698814722&w=2).
> 
> I suggest you have a look in:
> 
>  http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/arm:pxa2.diff
> 
> since there's some duplication and clashes between your patch set and mine.
> I'm intending submitting the pxa2 branch when the next merge window opens.

Okay, I'll rediff the patch series so that it applies on top of your changes.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
