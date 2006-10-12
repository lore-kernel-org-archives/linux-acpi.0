From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320
Date: Thu, 12 Oct 2006 17:39:30 +0100
Message-ID: <1160671170.13557.25.camel@pcjc2lap>
References: <1160604516.5349.14.camel@pcjc2lap>
	 <1160610784.7763.3.camel@pcjc2lap> <1160611737.5429.4.camel@pcjc2lap>
	 <200610121653.02622.rjw@sisk.pl>  <1160671089.2096.225.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:52951 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932669AbWJLQjr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 12:39:47 -0400
In-Reply-To: <1160671089.2096.225.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

[snip]

> I got several reports that compiling psmouse as module and unload it
> explicitly on shutdown helps to fix things on newer HPs.
> 
> E.g. this report:
> About the fan and battery issue, there are three workaround:
>  - Turn off the machine and quit battery, Place the battery again.
>  - Next time you turn on the machine, turn it off during post.
>  - "modprobe -r psmouse" (after compiling psmouse as a module) before
> shutdown the machine.
> Next time you turn on the machine, battery status is working. Not sure
> about the fans...

My fans seemed to work ok most of the time before, it was the battery
status which hung, and the speedstep would never go to full speed.

Everything is happy with Ubuntu's kernel 2.6.17-10 and when unloading
psmouse as part of the shutdown and reboot scripts.

I did dig though psmouse a little, but being a non-expert, couldn't see
anything odd.

It could be the synaptics driver part I guess, as most people have
laptops.

It could be that psmouse keeps a serial driver of some sort alive, or a
bus active. Perhaps it is still receiving and processing interrupts as
the bios tries to reboot? Does someone need to open a kernel bug for
this, and where should it go?

Regards

Peter Clifton.

