From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [git pull request] ACPI patches for 2.6.34-rc6
Date: Sat, 8 May 2010 00:39:45 +0200
Message-ID: <201005080039.45533.rjw@sisk.pl>
References: <alpine.LFD.2.00.1005062216430.10792@localhost.localdomain> <alpine.LFD.2.00.1005061926460.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57136 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767Ab0EGWir (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 May 2010 18:38:47 -0400
In-Reply-To: <alpine.LFD.2.00.1005061926460.901@i5.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Friday 07 May 2010, Linus Torvalds wrote:
> 
> On Thu, 6 May 2010, Len Brown wrote:
> > 
> > The big DMI list in sleep.c a temporary brute force and low-risk workaround.
> > We will endeavor to delete it entirely in 2.6.35 with a clean fix
> > that was deemed too risky for this late in the .34 release cycle.
> 
> Btw, why don't we just force the SCI_EN by hand?

Because there are boxes that are broken right away by this.

I have one on my desk in front of me. :-)

Rafael
