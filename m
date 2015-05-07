From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Detecting that a battery is inside a dock?
Date: Thu, 07 May 2015 11:11:39 +0200
Message-ID: <1430989899.2786.19.camel@hadess.net>
References: <1430320098.2525.105.camel@hadess.net>
	 <1430922017.2786.10.camel@hadess.net> <238522372.SKjufVyRkH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34309 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbEGJLo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 May 2015 05:11:44 -0400
In-Reply-To: <238522372.SKjufVyRkH@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org

On Thu, 2015-05-07 at 00:26 +0200, Rafael J. Wysocki wrote:
> On Wednesday, May 06, 2015 04:20:17 PM Bastien Nocera wrote:
> > On Wed, 2015-04-29 at 17:08 +0200, Bastien Nocera wrote:
> > > Hey,
> > > 
> > > I have access to a convertible Toshiba machine where the 2nd 
> > > battery 
> > > is in detachable keyboard. This is the decompiled DSDT:
> > > https://hadess.fedorapeople.org/toshiba.dsl
> > > 
> > > There's no BAT0, BAT1 is in the screen, and BAT2 is in the 
> > > keyboard.
> > > 
> > > BAT2 can be ejected (it has an _EJD method), but the dock code 
> > > doesn't 
> > > see it as having a battery:
> > > $ pwd
> > > /sys/devices/platform/dock.0
> > > $ cat flags
> > > 16
> > > $ cat type
> > > dock_station
> > > 
> > > Any ideas what might be missing here?
> > > 
> > > I'd eventually like to be able to say that, if I can detect that 
> > > the 
> > > battery is inside the dock, to mark it as such in the UI[1] 
> > > (even 
> > > better would be to say it's "in the keyboard" but I'm not sure 
> > > we 
> > > can 
> > > easily detect that).
> > 
> > Anyone?
> 
> Not now, sorry.  Too many things are going on in parallel and this 
> one is
> not the most urgent of them.

Sure. I didn't expect a bug fix straight away, I just wanted to know
whether I was missing something.

> Please file a bug for it at bugzilla.kernel.org in the ACPI 
> category, so it's
> not forgotten.  Those bugs are looked at on a regular basis, so 
> we'll get to
> it at one point.
> 

Filed as:
https://bugzilla.kernel.org/show_bug.cgi?id=97841

Cheers
