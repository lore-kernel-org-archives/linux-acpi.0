From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI drivers - version 2
Date: Thu, 31 Jul 2008 10:05:21 +0930 (CST)
Message-ID: <200807310035.m6V0ZLOU022072@turbo.physics.adelaide.edu.au>
References: <200807301106.40521.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:53293 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751923AbYGaAg2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 20:36:28 -0400
In-Reply-To: <200807301106.40521.trenn@suse.de> from "Thomas Renninger" at Jul 30, 2008 11:06:37 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Yves-Alexis Perez <corsac@debian.org>, ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, nokos@gmx.net

Hi Thomas

> > On mer, 2008-07-16 at 12:52 +0200, Thomas Renninger wrote:
> > > It is highly recommended that these patches are tried out together with
> > > Matthew's/Hong's IGD driver changes.
> > > I do not know whether they are already in the dri tree or in linux-next,
> > > whether they will be accepted for .27 etc. I hope Matthew will answer on
> > > this mail and tell us.
> > > AFAIK on thinkpads they already need an additional patch to work?
> > > Chances are high that other laptop families also need a bit of a special
> > > treatment to get the very new IGD parts to work.
> > > If people test both patches together we could get a matrix like this:
> >
> > What is the status of those patches wrt. 2.6.27-rc1?
> 
> Matthew and Rui accepted or signed them off AFAIK.
> On Peter's system (nokos@gmx.de, fujitsu with IGD support) it returns that
> there is no video support which looks wrong.
> I contacted him a bit late, after getting pointed to acpidump it still looks
> odd/wrong, and I need acpi.debug_level=0x1f log_buf_len=16777216 output to 
> hopefully see what it is.
> 
> A comment from Andi/Len would be great.
> Maybe this could already be sent to linux-next to make testing easier.
> :
> PS: and this is version 2, I already sent version 3 which had some cleanups.

I'm trying to sort out the status of this myself.  Is the expectation that
your patches *with* the IGD work from Matthew/Hong should mean that Fujitsus
implementing IGD should not need fujitsu-laptop in order to provide working
software backlight brightness control?  Or shouldn't Matthew/Hong's
patchset be necessary with your patch in theory?

AFAIK even IGD Fujitsus will need fujitsu-laptop to support other hotkeys,
so allowing fujitsu-laptop to co-exist with video.ko handling the backlight
(as your patches allow) is the right thing to do.

Regards
  jonathan
