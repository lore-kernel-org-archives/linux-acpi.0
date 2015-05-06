From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Detecting that a battery is inside a dock?
Date: Thu, 07 May 2015 00:26:25 +0200
Message-ID: <238522372.SKjufVyRkH@vostro.rjw.lan>
References: <1430320098.2525.105.camel@hadess.net> <1430922017.2786.10.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62617 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750868AbbEFWBW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May 2015 18:01:22 -0400
In-Reply-To: <1430922017.2786.10.camel@hadess.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-acpi@vger.kernel.org

On Wednesday, May 06, 2015 04:20:17 PM Bastien Nocera wrote:
> On Wed, 2015-04-29 at 17:08 +0200, Bastien Nocera wrote:
> > Hey,
> > 
> > I have access to a convertible Toshiba machine where the 2nd battery 
> > is in detachable keyboard. This is the decompiled DSDT:
> > https://hadess.fedorapeople.org/toshiba.dsl
> > 
> > There's no BAT0, BAT1 is in the screen, and BAT2 is in the keyboard.
> > 
> > BAT2 can be ejected (it has an _EJD method), but the dock code 
> > doesn't 
> > see it as having a battery:
> > $ pwd
> > /sys/devices/platform/dock.0
> > $ cat flags
> > 16
> > $ cat type
> > dock_station
> > 
> > Any ideas what might be missing here?
> > 
> > I'd eventually like to be able to say that, if I can detect that the 
> > battery is inside the dock, to mark it as such in the UI[1] (even 
> > better would be to say it's "in the keyboard" but I'm not sure we 
> > can 
> > easily detect that).
> 
> Anyone?

Not now, sorry.  Too many things are going on in parallel and this one is
not the most urgent of them.

Please file a bug for it at bugzilla.kernel.org in the ACPI category, so it's
not forgotten.  Those bugs are looked at on a regular basis, so we'll get to
it at one point.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
