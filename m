From: Thomas Renninger <trenn@suse.de>
Subject: Re: HP Compaq nc6320
Date: Thu, 12 Oct 2006 18:38:08 +0200
Message-ID: <1160671089.2096.225.camel@queen.suse.de>
References: <1160604516.5349.14.camel@pcjc2lap>
	 <1160610784.7763.3.camel@pcjc2lap> <1160611737.5429.4.camel@pcjc2lap>
	 <200610121653.02622.rjw@sisk.pl>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:62934 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932275AbWJLQ1x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 12:27:53 -0400
In-Reply-To: <200610121653.02622.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Peter Clifton <pcjc2@cam.ac.uk>, linux-acpi@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

On Thu, 2006-10-12 at 16:53 +0200, Rafael J. Wysocki wrote:
> On Thursday, 12 October 2006 02:08, Peter Clifton wrote:
> > 
> > > Wierdly, I've lost the Battery/AC adapter status monitoring again, with
> > > or without ec_intr=0.
> > 
> > > Gets odder!
> > 
> > Ok,
> > 
> > Nearing completion of this tale I think..
> > 
> > Turns out there is a known problem with psmouse, which leaves the
> > system / ACPI / something in a bad state if psmouse is loaded before
> > shutdown or reboot. Googling tells me that either removing batteries, AC
> > etc.. before powering up, booting Windows, or shutting down Linux with
> > psmouse removed, will "fix" the symptoms.

I got several reports that compiling psmouse as module and unload it
explicitly on shutdown helps to fix things on newer HPs.

E.g. this report:
About the fan and battery issue, there are three workaround:
 - Turn off the machine and quit battery, Place the battery again.
 - Next time you turn on the machine, turn it off during post.
 - "modprobe -r psmouse" (after compiling psmouse as a module) before
shutdown the machine.
Next time you turn on the machine, battery status is working. Not sure
about the fans...


http://www.wolframschenck.de/nx6325.htm#sect3
Similar introduction in German:
http://home.no/slazz/nx6310/nx6310.html


   Thomas

