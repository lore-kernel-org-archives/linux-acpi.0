From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [RESEND] [PATCH] fujitsu-laptop: better handling of P8010
Date: Mon, 13 Oct 2008 08:33:14 +0930 (CST)
Message-ID: <200810122303.m9CN3EJZ004798@turbo.physics.adelaide.edu.au>
References: <20081009051314.GC11477@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:56612 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752048AbYJLXD3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Oct 2008 19:03:29 -0400
In-Reply-To: <20081009051314.GC11477@anvil.corenet.prv> from "Dmitry Torokhov" at Oct 09, 2008 01:13:15 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Dmitry

> > This patch (mostly from Peter Gruber) against 2.6.27-rc4 (but with the
> > interim P8010 patch from 2.6.27-rc6 applied) improves the handling of the
> > hotkeys for P8010 laptops by passing more accurate input events back to
> > userspace.  This is needed because the P8010 labels these buttons quite
> > differently to earlier laptops.  As part of this, a P8010-specific DMI
> > callback check has been implemented.
> 
> How about implementing getkeycode() and setkeycode() methods in the
> driver and then using HAL to load appropriate keymap?

Sorry for the delayed response - this arrived after I left work on Friday
and I'm generally offline over the weekend.

This could work but I'll have to do some reading to find out precisely how
all this fits together (any pointers?).  It might be a while before I get
anything out though because I'm going to be extremely short on time over the
next 4 or so weeks.  In the meantime it'll be good to have this patch as
is since it greatly improves the hotkey support for the P8010 laptop (and I
note that Len has merged a rebased version of the patch in the meantime).

Thanks for the suggestion.

Regards
  jonathan
