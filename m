From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Sat, 24 Apr 2010 00:10:28 -0300
Message-ID: <20100424031028.GC8755@khazad-dum.debian.net>
References: <1272062884.1594.73.camel@laptop>
 <20100424020113.GB8755@khazad-dum.debian.net>
 <1272075251.29792.9.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48242 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755796Ab0DXDKc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Apr 2010 23:10:32 -0400
Content-Disposition: inline
In-Reply-To: <1272075251.29792.9.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 23 Apr 2010, Jerone Young wrote:
> > Depends on how the key behaves.  Does the EC change from mute always
> > mutes (and vol up/down unmutes) mode to mute does nothing (and thus you
> > can dumb it down into a toggle) depending on OSI(Linux) ?
> 
> Yeap. So by setting OSI=Linux, the EC basically just makes the mute
> button an OS key press. The OS then mutes from the driver or higher
> level. This way both speakers & headphone jack get muted. 

Ok.  Please tell me which bit of the EC the BIOS touches to change modes
since you did look at its innards.  That will let me detect the current mode
from inside thinkpad-acpi...

> Well the T410 has interesting behavior. It actually does both at the
> same time. It sends the OS the mute key press & does a hardware mute to
> the speakers. This can fall out of sync of course if a user mutes from
> the userspace applet. But is easily remedied once the user presses the
> up or down volume key.

Argh.

> Given some of the new behavior it's probably best to crap it. I did some
> testing though before on this on the acpi-devel mailing list with my
> X301.  I want to send the OSI patch for that as well. But the X300 & the
> X301 have the nice hardware mute light that some people love. So I will
> just have to add the command line for my machine for a while.

I'd rather find out exactly how to sync things.  Chances are very high the
hardware mute gate powers *off* the speaker drivers (as it does on all
thinkpads with the extra hardware speaker/headphone volume control).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
