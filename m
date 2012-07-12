From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] Power management fix for 3.5-rc7
Date: Thu, 12 Jul 2012 11:48:20 +0200
Message-ID: <201207121148.20927.rjw@sisk.pl>
References: <201207111943.19405.rjw@sisk.pl> <201207121057.31791.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37209 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932983Ab2GLJmo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jul 2012 05:42:44 -0400
In-Reply-To: <201207121057.31791.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>, Lin Ming <ming.m.lin@intel.com>

On Thursday, July 12, 2012, Thomas Renninger wrote:
> Hi,
> 
> On Wednesday, July 11, 2012 07:43:19 PM Rafael J. Wysocki wrote:
> > Hi Linus,
> > 
> > Please pull one power management fix for 3.5-rc7...
> 
> There are two patches (at least these, maybe Len has more?)
> from the ACPI area which should still show up in 3.5.

Thanks for the heads up!

> I take the chance and use this thread to draw attention to
> these, so that they do not fall off (especially one is critical).
> 
> No idea whether they first have to go through Len's
> tree. I searched there but couldn't find them commited
> in the release branch.
> 
> I'll post them to this thread, based on latest Linus' master.

OK, I'm not sure if Len is planning a pull request any time soon, but
since I'm the cpufreq maintainer now officially I'm going push the second
patch in the next round.

As far as the ACPICA fix is concerned, I'd prefer to ask Bob and Len first
to avoid conflicts.

Thanks,
Rafael
