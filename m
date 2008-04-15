From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Wed, 16 Apr 2008 08:51:43 +0930 (CST)
Message-ID: <200804152321.m3FNLhPY022726@turbo.physics.adelaide.edu.au>
References: <1208256666.20860.37.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:40650 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752581AbYDOXVx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2008 19:21:53 -0400
In-Reply-To: <1208256666.20860.37.camel@earth.gruber.myown> from "nokos@gmx.net" at Apr 15, 2008 12:51:06 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: linux-acpi@vger.kernel.org, trenn@suse.de, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Hi Peter

> Am Dienstag, den 15.04.2008, 12:44 +0930 schrieb Jonathan Woithe:
> > > > There probably are machines out there which only have one of above
> > > > devices, then only the relevant driver should be loaded.
> > > 
> > > I thought the since there is only a small functionality in each part and
> > > the module only registers drivers which are started only if an
> > > appropriate device is present it might be good to integrate it in one
> > > module. (in the S6410 case there is actually a third device FUJ02E1 but
> > > I don't know yet what it is for, there are some notifies for that device
> > > in the DSDT but so far I haven't triggered any of them)
> > 
> > A fair point.  I guess it really depends on how these devices end up being
> > structured.  Modularity enforces separation which can help with
> > maintainability going forward but it can also give rise to a certain
> > amount of code duplication.  I'd be interested to see what others think.
> 
> I had another look into the DSDT and this is how the structure looks to
> me:
> I have three devices (FUJ02B1, FUJ02E1, FUJ02E3) with names (FJEX, CMBT,
> FEXT)
> so far it seems we can ignore the second since it always reports _STA=0
> (ie. disabled?)
> 
> FUJ02B1 Methods:
>  - RBLL get max brightness level
>  - GBLL/GBLS get current brightness (only difference GBLL zeros a flag
> if used for the first time which is not used anywhere else?)
>  - SBLL/SBL2 set brightness (some differences, notable SBLL doesn't do
> anything if a flag is set but interacts with the video device GFX0)
>  - GMOU,SMOU some getter/setter of unknown flags
>  - GHKS,GSIF more unknown flags
> 
> FUJ02E3 Methods:
>  - FUNC frontend to S000-S009 : approx. FUNC(0x1000+i,j,k,l) =
> S00i(j,k,l)
>  - S000-S009 getters and setters for various stuff (not restricted to
> FUJ02E3)
>     - S000 uses some fields from FUJ02E1
>     - S004 clones GIRB
>     - S006 seems to be a frontend for video/brightness stuff in FUJ02B1
> and FUJ02E3   
>  - GIRB/SIRB get and set? the special hotkey registers
>  - SBLC/SVBL/RSBL do something with brightness and/or video using
> FUJ02B1 methods
>  
> so it seems the devices are not independent of each other and a combined
> module might be the more sensible way to go?

Maybe.  Let's see how the patch behaves on the S7020 first and take things
from there.  From the above it seems to me that FUJ02B1 is the thing which
deals direct with brightness and that any brightness-related stuff in
FUJ02E3 may be there for convenience.  If that was the case then the modular
split still makes sense I think.  If we can show that the FUJ02E3 methods
add additional functionality on top of that provided by FUJ02B1 then a
single module may make sense.  For example, maybe FUJ02E3's SBLC/SVBL/RSBL
take care of selecting the correct low-level brightness control method on a
given laptop.  Of course if laptops turn up without the FUJ02E3 it might
complicate things somewhat.

If we were to go to a single module we would have to find a way to
automatically work out which brightness control method to use.  Otherwise
almost every user of the module will have to worry about setting module
parameters because there's no default setting which would work for "most"
users.

I'll let you know how the current patch behaves on the S7020.

Regards
  jonathan
