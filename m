From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: suspend to RAM failure on t61p
Date: Tue, 11 Dec 2007 01:57:51 -0800
Message-ID: <20071211015751.3a786fb4.akpm@linux-foundation.org>
References: <20071209011928.c9873c66.akpm@linux-foundation.org>
	<200712100204.13881.rjw@sisk.pl>
	<20071209232547.1d0c6599.akpm@linux-foundation.org>
	<200712101206.15037.rjw@sisk.pl>
	<20071210222156.f51dd114.akpm@linux-foundation.org>
	<20071210225858.f9746533.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34455 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750735AbXLKJ56 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Dec 2007 04:57:58 -0500
In-Reply-To: <20071210225858.f9746533.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Tomas Carnecky <tom@dbservice.com>, linux-acpi@vger.kernel.org

On Mon, 10 Dec 2007 22:58:58 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 10 Dec 2007 22:21:56 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > However reverting 9cd9a0058dd35268b24fa16795a92c800f4086d4 does not fix the
> > machine-reboots-after-resume-from-disk regression.
> > 
> > It gets to here:
> > 
> > Attempting manual resume
> > swsusp: Marking nosave pages: 000000000009d000 - 0000000000100000
> > swsusp: Basic memory bitmaps created
> > Freezing user space processes ... (elapsed 0.00 seconds) done.
> > Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> > Loading image data pages (52207 pages) ... done
> > Read 208828 kbytes in 5.40 seconds (38.67 MB/s)
> > Suspending console(s)
> > 
> > then everything stops for five seconds then wham.
> > 
> > This bug is present in 2.6.24-rc1 but I'm basically unable to bisect it
> > because every bisection point (tried about four so far) hits fatal runtime
> > errors: cant-find-/dev/root, an oops in ipv6, an oops in netfilter, etc.
> > 
> > This is just a basic boot-it-on-fc8 test with RH's config and nothing
> > works.  The quality of code which people have been checking into the tree
> > is just appalling and here we see the costs of that.
> > 
> > I think I'll see if it's present in the last 2.6.23 -mm lineup: I know I
> > can bisect that.  Probably it won't be, given the way in which people like
> > to jam vast amounts of new code into the merge window.
> > 
> 
> Under 2.6.23-mm1 on the t61p,
> 
> 	echo disk >/sys/power/state
> 
> makes the screen go black then nothing at all happens for ten seconds and
> then the display comes back and it says:
> 
> t61p:/home/akpm# echo disk >/sys/power/state
> echo: write error: device or resource busy
> 
> So I have to bisect that first.
> 

This was caused by freezer-use-wait-queue-instead-of-busy-looping.patch
which we blessedly dropped.

After dropped that patch from 2.6.23-mm1, bisection shows that
hibernation-use-temporary-page-tables-for-kernel-text-mapping-on-x86_64.patch
is causing the t61p's reboot-after-resuming-from-disk regression. 
Reverting that patch from current Linus mainline fixes this regression.

Now let me see what caused the keystrokes-no-longer-trigger-resume-from-RAM
regression.

