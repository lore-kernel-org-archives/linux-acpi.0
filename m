From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Wed, 9 Dec 2009 12:10:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091204550.4120-100000@iolanthe.rowland.org>
References: <20091209164653.GI9018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754096AbZLIRKB@vger.kernel.org>
In-Reply-To: <20091209164653.GI9018@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 9 Dec 2009, Mark Brown wrote:

> > How long does it take to bring down the entire embedded audio 
> > subsystem?  And how critical is the timing for typical systems?
> 
> Worst case is about a second for both resume and suspend which means two
> seconds total but it's very hardware dependant.  

A second seems awfully long.  What happens if audio isn't being played
when the suspend occurs?  Can't you shorten things with no artifacts in
that case?

If audio _is_ being played when a suspend occurs, users probably don't 
mind audible artifacts.  In fact, they probably expect some.

Alan Stern
