From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Tue, 27 Apr 2010 00:50:12 -0500
Message-ID: <1272347412.14100.18.camel@laptop>
References: <1272062884.1594.73.camel@laptop>
	 <20100424160114.GA13867@srcf.ucam.org> <1272142178.1839.138.camel@laptop>
	 <20100424211601.GA16731@srcf.ucam.org> <1272154109.1839.345.camel@laptop>
	 <20100425022832.GA27607@khazad-dum.debian.net>
	 <1272220091.1274.94.camel@laptop> <20100425184405.GA29130@srcf.ucam.org>
	 <1272221872.1640.22.camel@laptop>
	 <20100426101115.GA2614@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:55124 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab0D0FuS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Apr 2010 01:50:18 -0400
In-Reply-To: <20100426101115.GA2614@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Mon, 2010-04-26 at 07:11 -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 25 Apr 2010, Jerone Young wrote:
> > On Sun, 2010-04-25 at 19:44 +0100, Matthew Garrett wrote:
> > > On Sun, Apr 25, 2010 at 01:28:11PM -0500, Jerone Young wrote:
> > > > I think it's not really possible to get it correct with thinkpad-acpi .
> > > > The reason is the userspace sound server. In our case it's pulse audio.
> > > > So we are no longer just dealing with ALSA anymore. So if the OS gets a
> > > > proper hotkey event it is able to mute at the pulse audio level then,
> > > > pulse audio does work at the ALSA level (toggling the mixer).
> > > > thinkpad-acpi has no way to check on the status of pulse audio.
> > > 
> > > This really isn't a problem. We have a mixer device for the Thinkpad's 
> > > own mixer, and we can send ALSA events to indicate that its state has 
> > > changed.
> > 
> > I think it is. Since pulse audio only pay attention to the Master mixer
> > of the primary card. The Thinkpad EC shows up basically as a second
> > audio card. 
> 
> Fix userspace, don't break the kernel.

I think going this route actually is more hacky .. by having a second
sound device for this. My thoughts is all of this should be removed.
Instead have somewhere where hardware mute state can be checked easily.

> 
> It is taking more than two years to fix the last such "shortcut" (brightness
> control keys misused as notifications) taken because of userspace
> shortcomings.
> 
> > I think all this work isn't going to help the situation any. There
> > appears to be a easy solution. Just a matter of getting the LEDs on some
> > to light correctly, and see when the hardware mute is enabled.
> 
> It is a matter of keeping the hardware state and software states in sync.
> 
> Looking at it in any other way will result in gross, fragile hacks.

I agree. I think though that by trying to solve the whole problem at the
thinkpad-acpi level makes it more hacky.

Instead having thinkpad-acpi just exposing the LEDs & hardware mute
state. Then allowing a userspace daemon to see & manipulate these states
is a more elegant solution. This way it can also query & manipulate
higher level things, like sound servers (pulse audio) , and keep
everyone in sync.

				Thanks,
					Jerone


> 


