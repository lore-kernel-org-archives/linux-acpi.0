From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND] [PATCH] fujitsu-laptop: better handling of P8010
Date: Mon, 13 Oct 2008 23:00:04 -0400
Message-ID: <20081014030004.GC8594@anvil.corenet.prv>
References: <20081009051314.GC11477@anvil.corenet.prv> <200810122303.m9CN3EJZ004798@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:44861 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbYJNDAJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Oct 2008 23:00:09 -0400
Received: by rn-out-0910.google.com with SMTP id k40so950100rnd.17
        for <linux-acpi@vger.kernel.org>; Mon, 13 Oct 2008 20:00:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200810122303.m9CN3EJZ004798@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Jonathan,

On Mon, Oct 13, 2008 at 08:33:14AM +0930, Jonathan Woithe wrote:
> Hi Dmitry
> 
> > > This patch (mostly from Peter Gruber) against 2.6.27-rc4 (but with the
> > > interim P8010 patch from 2.6.27-rc6 applied) improves the handling of the
> > > hotkeys for P8010 laptops by passing more accurate input events back to
> > > userspace.  This is needed because the P8010 labels these buttons quite
> > > differently to earlier laptops.  As part of this, a P8010-specific DMI
> > > callback check has been implemented.
> > 
> > How about implementing getkeycode() and setkeycode() methods in the
> > driver and then using HAL to load appropriate keymap?
> 
> Sorry for the delayed response - this arrived after I left work on Friday
> and I'm generally offline over the weekend.
> 
> This could work but I'll have to do some reading to find out precisely how
> all this fits together (any pointers?).

Please take a look at drivers/input/misc/wistron_btns.c for a sample
implementation and don't hesiatate contacting me if you have any
questions.

-- 
Dmitry
