From: Thomas Renninger <trenn@suse.de>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI drivers - version 2
Date: Wed, 30 Jul 2008 11:06:37 +0200
Message-ID: <200807301106.40521.trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <1217399377.23004.0.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:37846 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbYG3JGo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 05:06:44 -0400
In-Reply-To: <1217399377.23004.0.camel@hidalgo>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, nokos@gmx.net

On Wednesday 30 July 2008 08:29:37 Yves-Alexis Perez wrote:
> On mer, 2008-07-16 at 12:52 +0200, Thomas Renninger wrote:
> > It is highly recommended that these patches are tried out together with
> > Matthew's/Hong's IGD driver changes.
> > I do not know whether they are already in the dri tree or in linux-next,
> > whether they will be accepted for .27 etc. I hope Matthew will answer on
> > this mail and tell us.
> > AFAIK on thinkpads they already need an additional patch to work?
> > Chances are high that other laptop families also need a bit of a special
> > treatment to get the very new IGD parts to work.
> > If people test both patches together we could get a matrix like this:
>
> What is the status of those patches wrt. 2.6.27-rc1?

Matthew and Rui accepted or signed them off AFAIK.
On Peter's system (nokos@gmx.de, fujitsu with IGD support) it returns that
there is no video support which looks wrong.
I contacted him a bit late, after getting pointed to acpidump it still looks
odd/wrong, and I need acpi.debug_level=0x1f log_buf_len=16777216 output to 
hopefully see what it is.

A comment from Andi/Len would be great.
Maybe this could already be sent to linux-next to make testing easier.

      Thomas

PS: and this is version 2, I already sent version 3 which had some cleanups.
