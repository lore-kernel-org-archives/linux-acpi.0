From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: git-acpi breaks resume-from-ram on the Vaio
Date: Tue, 18 Sep 2007 13:59:04 +0200
Message-ID: <200709181359.04826.rjw@sisk.pl>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org> <20070917214054.bb622420.akpm@linux-foundation.org> <200709181354.16939.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58516 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756264AbXIRLqi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 07:46:38 -0400
In-Reply-To: <200709181354.16939.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, 18 September 2007 13:54, Rafael J. Wysocki wrote:
> On Tuesday, 18 September 2007 06:40, Andrew Morton wrote:
> > On Mon, 17 Sep 2007 21:12:13 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > 
> > > It suspends OK, then during resume it gets partway through it, then everything
> > > just stops.
> > > 
> > > Would prefer not to have to bisect this one - I've done enough bisecting this
> > > week to last a lifetime, and bisecting git-acpi is painful due to build bustage
> > > at various points (cpuidle).
> > 
> > And git-acpi breaks suspend-to-disk as well.  It gets up to "Suspending console(s)"
> > and then the cursor stops blinking at it wedges up.
> 
> Can you please compile with CONFIG_DISABLE_CONSOLE_SUSPEND set and try:

Ah, that's -mm, sorry.  Instead of setting CONFIG_DISABLE_CONSOLE_SUSPEND
(which has been removed) please pass no_console_suspend in the command line.

> # echo test > /sys/power/disk
> # echo disk > /sys/power/state
> 
> and if that hangs,
> 
> # echo testproc > /sys/power/disk
> # echo disk > /sys/power/state
