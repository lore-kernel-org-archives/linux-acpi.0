From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and hibernation operations framework
Date: Wed, 11 Jul 2007 13:16:07 +0200
Message-ID: <200707111316.08388.rjw@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl> <20070711105334.GH7091@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49275 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755641AbXGKLIk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jul 2007 07:08:40 -0400
In-Reply-To: <20070711105334.GH7091@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, Nigel Cunningham <nigel@nigel.suspend2.net>

Hi,

On Wednesday, 11 July 2007 12:53, Pavel Machek wrote:
> Hi!
> 
> 
> > This series of patches implements changes that are possible/necessary/desirable
> > (IMO) after the introduction of the .set_target() method in 'struct pm_ops'
> > (the patch that introduces it is in -mm,
> > http://marc.info/?l=linux-mm-commits&m=118306698814722&w=2).
> 
> (I think this series is already in -mm, right?)

No, it is not, because I'm waiting for the inclusion of the ARM update.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
