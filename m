From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: CONFIG_SUSPEND? (was: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1)
Date: Thu, 26 Jul 2007 21:17:25 +0200
Message-ID: <200707262117.26353.rjw@sisk.pl>
References: <200707251238.50218.lenb@kernel.org> <alpine.LFD.0.999.0707252353150.3442@woody.linux-foundation.org> <200707261345.29902.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37822 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761445AbXGZTJH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 15:09:07 -0400
In-Reply-To: <200707261345.29902.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On Thursday, 26 July 2007 19:45, Len Brown wrote:
> On Thursday 26 July 2007 02:55, Linus Torvalds wrote:
> > 
> > On Thu, 26 Jul 2007, Len Brown wrote:
> > > 
> > > Feel free to share what you know about the benefits vs. the costs
> > > of maintaining CONFIG_ACPI_SLEEP as a build option.
> > 
> > Why don't you just make CONFIG_ACPI_SLEEP dependent on SOFTWARE_SUSPEND 
> > and STR?
> 
> CONFIG_STR doesn't exist.

Hmm, perhaps we should introduce a CONFIG_SUSPEND and change
CONFIG_SOFTWARE_SUSPEND into CONFIG_HIBERNATION, both depending on
CONFIG_PM?

There's quite some code needed only for suspend compiled in when CONFIG_PM is
set ...

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
