From: Daniel Silverstone <dsilvers@simtec.co.uk>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Fri, 06 Mar 2009 10:12:56 +0000
Message-ID: <1236334376.19146.11.camel@petitemort>
References: <20090306003941.GA32403@srcf.ucam.org>
	 <20090306005234.GA32539@srcf.ucam.org>
	 <1236330536.12838.2.camel@hughsie-work.lan>
	 <1236332843.19146.4.camel@petitemort> <20090306095623.GA6014@srcf.ucam.org>
	 <1236333861.19146.9.camel@petitemort> <20090306100951.GA6268@srcf.ucam.org>
Reply-To: dsilvers@simtec.co.uk
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from batfish.pepperfish.net ([87.237.62.180]:44484 "EHLO
	flounder.pepperfish.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750701AbZCFKNA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2009 05:13:00 -0500
In-Reply-To: <20090306100951.GA6268@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Fri, 2009-03-06 at 10:09 +0000, Matthew Garrett wrote:
> > > > How will it interact with software stacks like HAL when the lock button
> > > > is pressed?
> > > I don't really understand the question?
> > It was more: will events come out of both the notify method *and*
> > the /proc/acpi/toshiba/keys stuff, or will they only come out of the
> > notify method if it can be enabled? (I'm just trying to establish that
> > things polling /proc/acpi/toshiba/keys won't end up causing duplicated
> > events).
> Either the kernel or userspace will get the event, but not both. There's 
> an argument for disabling the input code if /proc/acpi/toshiba/keys is 
> open in order to avoid breaking anything that expects to get the code 
> itself.

I see. One other thing occurred to me. Is there any way for Hal to know
that the notify stuff is in place and thus doesn't need to
poll /proc/acpi/toshiba/keys? Otherwise it's going to poll it anyway
which fails to remove the periodic wakeups.

D.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895


