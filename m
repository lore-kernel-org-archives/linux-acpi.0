From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 02:26:06 +0100
Message-ID: <200912060226.06217.rjw@sisk.pl>
References: <200912052216.19540.rjw@sisk.pl> <200912060055.36130.rjw@sisk.pl> <20091205164541.5e0f209a@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36426 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754740AbZLFBZ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Dec 2009 20:25:28 -0500
In-Reply-To: <20091205164541.5e0f209a@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>

On Sunday 06 December 2009, Arjan van de Ven wrote:
> On Sun, 6 Dec 2009 00:55:36 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > 
> > Disk spinup/spindown takes time, but also some ACPI devices resume
> > slowly, serio devices do that too and there are surprisingly many
> > drivers that wait (using msleep() during suspend and resume).  Apart
> > from this, every PCI device going from D0 to D3 during suspend and
> > from D3 to D0 during resume requires us to sleep for 10 ms (the
> > sleeping is done by the PCI core, so the drivers don't even realize
> > its there).
> 
> maybe a good step is to make a scripts/bootgraph.pl equivalent for
> suspend/resume (or make a debug mode that outputs in a compatible format
> so that the script can be used as is.. I don't mind either way, and
> consider this my offer to help with such a script as long as there's
> sufficient logging in dmesg ;-)

OK, so what kind of logging is needed?

> that way we can SEE which ones are an issue.... and by how much.

Well, why not.

Thanks,
Rafael
