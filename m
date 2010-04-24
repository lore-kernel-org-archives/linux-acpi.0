From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Fri, 23 Apr 2010 23:15:00 -0500
Message-ID: <1272082500.29792.34.camel@laptop>
References: <1272062884.1594.73.camel@laptop>
	 <20100424020113.GB8755@khazad-dum.debian.net>
	 <1272075251.29792.9.camel@laptop>
	 <20100424031028.GC8755@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:40625 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab0DXEPG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Apr 2010 00:15:06 -0400
In-Reply-To: <20100424031028.GC8755@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

On Sat, 2010-04-24 at 00:10 -0300, Henrique de Moraes Holschuh wrote:
> On Fri, 23 Apr 2010, Jerone Young wrote:
> > > Depends on how the key behaves.  Does the EC change from mute always
> > > mutes (and vol up/down unmutes) mode to mute does nothing (and thus you
> > > can dumb it down into a toggle) depending on OSI(Linux) ?
> > 
> > Yeap. So by setting OSI=Linux, the EC basically just makes the mute
> > button an OS key press. The OS then mutes from the driver or higher
> > level. This way both speakers & headphone jack get muted. 
> 
> Ok.  Please tell me which bit of the EC the BIOS touches to change modes
> since you did look at its innards.  That will let me detect the current mode
> from inside thinkpad-acpi...

Not sure, this is based on the DSDT from my x301.. but here are the
instructions:

	\_SB.PCI0.LPC.EC.SAUM (0x02)
		

Actually this is identical to the condition found in an X61 (which is
already in blacklist.c):
http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg12070.html

> 
> > Well the T410 has interesting behavior. It actually does both at the
> > same time. It sends the OS the mute key press & does a hardware mute to
> > the speakers. This can fall out of sync of course if a user mutes from
> > the userspace applet. But is easily remedied once the user presses the
> > up or down volume key.
> 
> Argh.
> 
> > Given some of the new behavior it's probably best to crap it. I did some
> > testing though before on this on the acpi-devel mailing list with my
> > X301.  I want to send the OSI patch for that as well. But the X300 & the
> > X301 have the nice hardware mute light that some people love. So I will
> > just have to add the command line for my machine for a while.
> 
> I'd rather find out exactly how to sync things.  Chances are very high the
> hardware mute gate powers *off* the speaker drivers (as it does on all
> thinkpads with the extra hardware speaker/headphone volume control).

I belive at least under Windows they use a daemon to keep things in
sync. I think with a vanilla Windows install it has the same sync issue.
You have to have a userspace daemon monitoring the two. *Going off vague
memory .. so take it with little confidence till can get a chance to
really verify.



		Jerone

> 


