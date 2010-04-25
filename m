From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Sun, 25 Apr 2010 14:19:28 -0500
Message-ID: <1272223168.1640.60.camel@laptop>
References: <1272062884.1594.73.camel@laptop>
	 <20100424160114.GA13867@srcf.ucam.org> <1272142178.1839.138.camel@laptop>
	 <20100424211601.GA16731@srcf.ucam.org> <1272154109.1839.345.camel@laptop>
	 <20100425022832.GA27607@khazad-dum.debian.net>
	 <1272220091.1274.94.camel@laptop> <20100425184405.GA29130@srcf.ucam.org>
	 <1272221872.1640.22.camel@laptop>  <20100425185957.GA29300@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:59637 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab0DYTTe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Apr 2010 15:19:34 -0400
In-Reply-To: <20100425185957.GA29300@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Sun, 2010-04-25 at 19:59 +0100, Matthew Garrett wrote:
> On Sun, Apr 25, 2010 at 01:57:52PM -0500, Jerone Young wrote:
> > On Sun, 2010-04-25 at 19:44 +0100, Matthew Garrett wrote:
> > > This really isn't a problem. We have a mixer device for the Thinkpad's 
> > > own mixer, and we can send ALSA events to indicate that its state has 
> > > changed.
> > 
> > I think it is. Since pulse audio only pay attention to the Master mixer
> > of the primary card. The Thinkpad EC shows up basically as a second
> > audio card. 
> 
> Good thing we have the source code to pulse, then.

hehe ... yes thinking about it you can come up with some scheme to have
pulse audio sync the master & the Thinkpad EC mixers. Though would get
tricky.

Also the EC mixer doesn't seem to be working on my X301
currently...though not running the latest tip thinkpad-acpi.

But I think the issue now is for these older Thinkpads the mute does not
send an event (without OSI(Linux)) .. meaning
	1) something would have to poll the EC to see if the hardware mute is
enabled for the speakers
	2) Then send a softkey event to the OS so the sound server (pulse
audio) can learn about it .. 
	3) Pulse will mute the Alsa Mixer, so the headphone jack will then mute
as well.. 
	4) Then the users gets the nice on screen notification. 

Or if you specify OSI(Linux) .. you basically just skip step one and go
to step 2 on. Also (not trying to beat a dead horse) this is what the
X201 is doing right now.


				Jerone



				Thanks,
					Jerone
 
> 


