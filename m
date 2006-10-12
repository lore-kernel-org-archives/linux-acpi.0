From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: HP Compaq nc6320
Date: Thu, 12 Oct 2006 23:08:23 +0200
Message-ID: <200610122308.24557.rjw@sisk.pl>
References: <1160604516.5349.14.camel@pcjc2lap> <1160671089.2096.225.camel@queen.suse.de> <1160671170.13557.25.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:7610 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750952AbWJLVIa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 17:08:30 -0400
In-Reply-To: <1160671170.13557.25.camel@pcjc2lap>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Dmitry Torokhov <dtor@insightbb.com>, Pavel Machek <pavel@ucw.cz>

On Thursday, 12 October 2006 18:39, Peter Clifton wrote:
> [snip]
> 
> > I got several reports that compiling psmouse as module and unload it
> > explicitly on shutdown helps to fix things on newer HPs.
> > 
> > E.g. this report:
> > About the fan and battery issue, there are three workaround:
> >  - Turn off the machine and quit battery, Place the battery again.
> >  - Next time you turn on the machine, turn it off during post.
> >  - "modprobe -r psmouse" (after compiling psmouse as a module) before
> > shutdown the machine.
> > Next time you turn on the machine, battery status is working. Not sure
> > about the fans...
> 
> My fans seemed to work ok most of the time before, it was the battery
> status which hung, and the speedstep would never go to full speed.
> 
> Everything is happy with Ubuntu's kernel 2.6.17-10 and when unloading
> psmouse as part of the shutdown and reboot scripts.
> 
> I did dig though psmouse a little, but being a non-expert, couldn't see
> anything odd.
> 
> It could be the synaptics driver part I guess, as most people have
> laptops.

Well, on the HPC nx6325 I'm using psmouse is apparently interfering with
ACPI during resume from disk in a destructive way.  Namely, with the
2.6.19-rc1-mm1 kernel the temperature in one of the thermal zones
is way off during the resume, so ACPI thinks the critical thermal
point has been passed and it tries to power off the system, which makes
it hang.  Unloading psmouse before the suspend apparently helps.

I think it's synaptics too, because it spits reset failure messages during the
resume, if not unloaded before.

> It could be that psmouse keeps a serial driver of some sort alive, or a
> bus active. Perhaps it is still receiving and processing interrupts as
> the bios tries to reboot? Does someone need to open a kernel bug for
> this, and where should it go?

Well I guess so, and it looks like ACPI is the right place to start from.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
