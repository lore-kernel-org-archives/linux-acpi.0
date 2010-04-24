From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Fri, 23 Apr 2010 21:19:17 -0500
Message-ID: <1272075557.29792.10.camel@laptop>
References: <1272062884.1594.73.camel@laptop>
	 <20100424020113.GB8755@khazad-dum.debian.net>
	 <1272075251.29792.9.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:59468 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab0DXCTV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2010 22:19:21 -0400
In-Reply-To: <1272075251.29792.9.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Errr .. Below I meant an earlier email I did on the thinkpad-acpi
mailing list a while back testing out the mute led support you had.

				Thanks,
					Jerone

On Fri, 2010-04-23 at 21:14 -0500, Jerone Young wrote:
> On Fri, 2010-04-23 at 23:01 -0300, Henrique de Moraes Holschuh wrote:
> > On Fri, 23 Apr 2010, Jerone Young wrote:
> > > This patch fixes that mute keys for X & R & W series Thinkpads. For
> > > these Thinkpads in the BIOS if OS exposes itself as "Linux" it will
> > > switch the functionality of the mute key to send a mute key press to the
> > > OS. These machines will not be getting any bios updates in the future.
> > 
> > Lenovo is getting really cheap those days if they now kill a BIOS that
> > isn't even two years old.
> Well they just will not have any update that would change the behavior.
> But yeah the BIOS for these are done.
> 
> > 
> > > All of these Thinkpads do not have a little light that would indicate
> > > the mute is on. So having them send the mute key to the OS makes a
> > > better user experience and also will match behavior of newer Thinkpads.
> > > These all have the same quirk the T400 & T500 have.
> > 
> > Depends on how the key behaves.  Does the EC change from mute always
> > mutes (and vol up/down unmutes) mode to mute does nothing (and thus you
> > can dumb it down into a toggle) depending on OSI(Linux) ?
> 
> Yeap. So by setting OSI=Linux, the EC basically just makes the mute
> button an OS key press. The OS then mutes from the driver or higher
> level. This way both speakers & headphone jack get muted. 
> 
> 
> 
> > 
> > Also, should I scrap any support for Lenovo mute-only hardware mixers?
> > OSI(Linux) seems to break it badly (but I'd appreciate some extensive
> > testing of this, if you can do it... regular users often can't get
> > userspace to quiet down enough to test it without external influences
> > and I get mixed reports).  Bit 6 of EC register 0x30 should control
> > speaker muting.
> 
> 
> I think scrapping the support would be a good idea. After discovering
> the hardware mute was only wired to the speakers, and not the headphone
> jack. It seems best to let userspace do it, and this at least it is what
> Lenovo is doing for the newer Thinkpads now. But I can also understand
> that by doing this you depend on userspace to quiet down. 
> 
> Well the T410 has interesting behavior. It actually does both at the
> same time. It sends the OS the mute key press & does a hardware mute to
> the speakers. This can fall out of sync of course if a user mutes from
> the userspace applet. But is easily remedied once the user presses the
> up or down volume key.
> 
> Given some of the new behavior it's probably best to crap it. I did some
> testing though before on this on the acpi-devel mailing list with my
> X301.  I want to send the OSI patch for that as well. But the X300 & the
> X301 have the nice hardware mute light that some people love. So I will
> just have to add the command line for my machine for a while.
> 
> 			Thanks,
> 				Jerone
> 
> 
> 
> > 
> 


