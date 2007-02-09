From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch 02/13] ACPI, i686, x86_64: fix laptop bootup hang in init_acpi()
Date: Fri, 9 Feb 2007 17:13:50 -0200
Message-ID: <20070209191350.GC4536@khazad-dum.debian.net>
References: <200702060010.l160AB6R003718@shell0.pdx.osdl.net> <200702090114.32041.lenb@kernel.org> <20070209142622.GD26414@khazad-dum.debian.net> <20070209180128.GA8586@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50801 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992759AbXBITNz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 14:13:55 -0500
Content-Disposition: inline
In-Reply-To: <20070209180128.GA8586@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, mingo@elte.hu, ak@suse.de

On Fri, 09 Feb 2007, Matthew Garrett wrote:
> On Fri, Feb 09, 2007 at 12:26:22PM -0200, Henrique de Moraes Holschuh wrote:
> > According to a patch sent to LKML a while ago that blacklisted all ThinkPads
> > from nmi_watchdog, the ThinkPad SMBIOS does INT 0x10 or something else that
> > will cause double or triple-faults if an NMI happens while in SMBIOS mode.
> 
> This is hardly unique to Thinkpads - huge arrays of things can trigger 
> SMM on pretty much any laptop. It's rarer on desktops, but some servers 
> have similar issues.

Well, that looks like a reason to blacklist it on thinkpads (and anything
else known to break on NMIs during SMM) and *ALSO* to add nmi_watchdog
guards around every call into the BIOS and ACPI tables, and every known
switch into SMM mode (i.e. anything using IBM's smapi, for example).  Yikes.

Not to mention that it should be documented, so that people get to know it
is potentially unsafe and don't turn it on without a reason.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
