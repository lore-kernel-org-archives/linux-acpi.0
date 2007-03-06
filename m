From: Mattia Dongili <malattia@linux.it>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21 - part II (resend)
Date: Tue, 6 Mar 2007 13:22:13 +0100
Message-ID: <20070306122213.GF2919@inferi.kami.home>
References: <200702162223.59837.lenb@kernel.org> <20020101045751.GD4106@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:49263 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbXCFMYM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Mar 2007 07:24:12 -0500
Content-Disposition: inline
In-Reply-To: <20020101045751.GD4106@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Jan 01, 2002 at 04:57:52AM +0000, Pavel Machek wrote:
> Hi!
> 
> > commit 4465857d5f99079bae00621626adf74ed8256296
> > Author: Mattia Dongili <malattia@linux.it>
> > Date:   Sat Jan 13 23:04:39 2007 +0100
> > 
> >     sony_acpi: Add lanpower and audiopower controls
> >     
> >     audiopower works well on my SZ72B so it's not marked has "debug" while lanpower
> >     has at least one report of not resuming power happily so morked as "debug"
> >     
> >     Signed-off-by: Mattia Dongili <malattia@linux.it>
> >     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> What is interface to these? It would be nice to automagically disable
> audiopower when sound device is closed, and automagically power down
> lan on ifconfig ... down.

the audiopower is basically a _PS3/_PS0 switch for the device, while the
lanpower plays with the embedded controller to powerdown/powerup.

Now, unfortunately those methods are attached to a fake device in the
DSDT and afaict there's no way to tell which real device they are
playing with (except by inspecting the method implementations).
Well of course iff there's only _one_ sound card and _one_ nic you can
easily guess it :)

Is there some way to hook into drivers for such kind of runtime power
management?

PS: lanpower currently seems to be a little too invasive (or it's just
ACPI that reacts badly) because switching off lanpower also disables the
pic link and never comes back. I need to better diagnose what's
happening and report to linux-acpi.
-- 
mattia
:wq!
