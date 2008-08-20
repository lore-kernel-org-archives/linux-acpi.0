From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/8] PNP debugging rework
Date: Wed, 20 Aug 2008 08:57:42 -0600
Message-ID: <200808200857.44056.bjorn.helgaas@hp.com>
References: <20080819225310.28206.1011.stgit@tigger.helgaas> <20080820025427.GQ9807@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:25301 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbYHTO5s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Aug 2008 10:57:48 -0400
In-Reply-To: <20080820025427.GQ9807@one.firstfloor.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Len Brown <lenb@kernel.org>, Adam M Belay <abelay@mit.edu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Dave Jones <davej@redhat.com>, Ben Collins <bcollins@ubuntu.com>, Dann Frazier <dannf@debian.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 19 August 2008 08:54:27 pm Andi Kleen wrote:
> On Tue, Aug 19, 2008 at 04:53:10PM -0600, Bjorn Helgaas wrote:
> > These patches add support for a boot-time switch to enable PNP debug
> > messages.  Currently, users have to recompile with CONFIG_PNP_DEBUG=y
> > to get PNP debug messages.
> > 
> > I copied the implementation strategy from Greg KH's USB patches:
> >     http://lkml.org/lkml/2008/8/8/529
> > 
> > These patches don't fix any bugs, and I know it's pretty late to
> > consider new stuff for 2.6.27.  The only reason to even consider them
> > is that 2.6.27 includes a significant PNP rewrite, and if 2.6.27 ends
> > up in a distro kernel, it will be much easier to work on problems if
> > users can collect debug information without rebuilding the kernel.
> 
> I would have pushed them up because they look harmless enough,
> but after Linus' recent rant on merging windows on linux-kernel I've 
> reconsidered.  Will queue them for .28 in test.

Fair enough, thanks!

Bjorn
