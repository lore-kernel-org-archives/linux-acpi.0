From: Thomas Renninger <trenn@suse.de>
Subject: Re: [GIT PULL] Power management fix for 3.5-rc7
Date: Thu, 12 Jul 2012 10:57:31 +0200
Message-ID: <201207121057.31791.trenn@suse.de>
References: <201207111943.19405.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49372 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106Ab2GLI5k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jul 2012 04:57:40 -0400
In-Reply-To: <201207111943.19405.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>, Lin Ming <ming.m.lin@intel.com>

Hi,

On Wednesday, July 11, 2012 07:43:19 PM Rafael J. Wysocki wrote:
> Hi Linus,
> 
> Please pull one power management fix for 3.5-rc7...

There are two patches (at least these, maybe Len has more?)
from the ACPI area which should still show up in 3.5.
I take the chance and use this thread to draw attention to
these, so that they do not fall off (especially one is critical).

No idea whether they first have to go through Len's
tree. I searched there but couldn't find them commited
in the release branch.

I'll post them to this thread, based on latest Linus' master.

   Thomas
