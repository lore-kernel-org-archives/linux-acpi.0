From: nokos@gmx.net
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Tue, 15 Apr 2008 12:51:06 +0200
Message-ID: <1208256666.20860.37.camel@earth.gruber.myown>
References: <200804150314.m3F3EnJW011526@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:47820 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750715AbYDOKvf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2008 06:51:35 -0400
In-Reply-To: <200804150314.m3F3EnJW011526@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: trenn@suse.de, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Am Dienstag, den 15.04.2008, 12:44 +0930 schrieb Jonathan Woithe:
> > > There probably are machines out there which only have one of above
> > > devices, then only the relevant driver should be loaded.
> > 
> > I thought the since there is only a small functionality in each part and
> > the module only registers drivers which are started only if an
> > appropriate device is present it might be good to integrate it in one
> > module. (in the S6410 case there is actually a third device FUJ02E1 but
> > I don't know yet what it is for, there are some notifies for that device
> > in the DSDT but so far I haven't triggered any of them)
> 
> A fair point.  I guess it really depends on how these devices end up being
> structured.  Modularity enforces separation which can help with
> maintainability going forward but it can also give rise to a certain
> amount of code duplication.  I'd be interested to see what others think.

I had another look into the DSDT and this is how the structure looks to
me:
I have three devices (FUJ02B1, FUJ02E1, FUJ02E3) with names (FJEX, CMBT,
FEXT)
so far it seems we can ignore the second since it always reports _STA=0
(ie. disabled?)

FUJ02B1 Methods:
 - RBLL get max brightness level
 - GBLL/GBLS get current brightness (only difference GBLL zeros a flag
if used for the first time which is not used anywhere else?)
 - SBLL/SBL2 set brightness (some differences, notable SBLL doesn't do
anything if a flag is set but interacts with the video device GFX0)
 - GMOU,SMOU some getter/setter of unknown flags
 - GHKS,GSIF more unknown flags

FUJ02E3 Methods:
 - FUNC frontend to S000-S009 : approx. FUNC(0x1000+i,j,k,l) =
S00i(j,k,l)
 - S000-S009 getters and setters for various stuff (not restricted to
FUJ02E3)
    - S000 uses some fields from FUJ02E1
    - S004 clones GIRB
    - S006 seems to be a frontend for video/brightness stuff in FUJ02B1
and FUJ02E3   
 - GIRB/SIRB get and set? the special hotkey registers
 - SBLC/SVBL/RSBL do something with brightness and/or video using
FUJ02B1 methods
 
so it seems the devices are not independent of each other and a combined
module might be the more sensible way to go?


Peter

