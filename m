From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 10:57:32 -0800
Message-ID: <200802201057.33055.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <b6a2187b0802200954p1cccb01aqbc48c865797f0af1@mail.gmail.com> <alpine.LFD.1.00.0802201007300.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34335 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191AbYBTS54 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 13:57:56 -0500
In-Reply-To: <alpine.LFD.1.00.0802201007300.7833@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, suspend-devel List <suspend-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>

On Wednesday, February 20, 2008 10:37 am Linus Torvalds wrote:
> This *sounds* like some part of the suspend-to-disk sequence is doing
> something stupid like trying to access the screen after it has been turned
> off, which doesn't surprise me at all. My oft-stated opinion has been that
> suspend-to-disk isn't a suspend at all, and should never have been
> confused with "suspending" anything.
>
> It's "snapshot-and-restore", and my opinion is that:
>
>  - it should *never* call "suspend()"/"resume()" at all (that should be
>    reserved purely for suspend-to-RAM and has real power management
>    issues!)
>
>  - it should have a totally separate "halt/unhalt/restore" thing
>    that has nothing what-so-ever to do with power management, and is
>    purely about stopping the hardware for things like USB and network
>    cards (which otherwise do things like scan their command lists
>    asynchronously) and making sure that the driver state is consistent
>    with that stopped hw state.
>
>  - the people who confuse snapshot/restore with suspend/resume are
>    horrible people that cause problems exactly because driver people then
>    get those things mixed up, and something like the video suspend/resume
>    should probably never have impacted suspend-to-disk in the first place!

Totally agreed.  I remember when I started getting hibernation bug reports 
against this new code and boggling at how hibernate was actually done.  The 
driver actually gets its ->suspend routine called twice with two different 
pm_message_t values.  We tried to do different stuff depending on the 
pm_message_t (like only putting the device in D3hot if PM_EVENT_SUSPEND), but 
it appears we're not doing enough...

> So there seems to be two (probably largely independent) problems:
>
>  - the hang at shutdown that requires you to press-and-hold the power
>    button to actually cut power.
>
>    At a guess: putting the VGA device into D3hot makes the ACPI code that
>    actually does the shutoff unhappy. Probably because it wants to access
>    the device, and ends up not ever getting the replies it wants, since
>    the hardware has been turned off.

Sounds like a good theory... now if we could just use set_power_state in the 
suspend case only.  That's what the latest code *tries* to do...

JEsse
