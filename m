From: Thomas Renninger <trenn@suse.de>
Subject: Re: S3 on acer travelmate 3022WTMi
Date: Wed, 27 Sep 2006 20:48:55 +0200
Message-ID: <1159382935.3610.399.camel@queen.suse.de>
References: <966a04530609260106y2bea58del50732ba061cdc9a9@mail.gmail.com>
	 <efbtdo$s4f$1@sea.gmane.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:34731 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030525AbWI0Sj6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 14:39:58 -0400
In-Reply-To: <efbtdo$s4f$1@sea.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Pregler <Peter_Pregler@email.com>
Cc: linux-acpi@vger.kernel.org, bk <bk@suse.de>

On Tue, 2006-09-26 at 21:01 +0200, Peter Pregler wrote:
> Arto Pastinen wrote:
> > Hi,
> > 
> > Has anyone got Suspend to Ram work on Acer TravelMate 3022WTMi?
> > 
> > I even fixed DSDT, but it still freezes on return from sleep, the hard
> > disc shows little action, but then everything is blank..
> 
> I think this describes the problem with all Acer TM 3xxx. I have a
> TM3201 and have the same problem. Additional symptons: display backlight
> is off, fan is running. I tried about all the tricks including all
> debugging that is possible without a serial console with no success.
> And since I have no docking station, i.e. no chance for a serial
> console, I simply gave up.
There is firescope, setting up the kernel console output over firewire:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114412300502236&w=2
There might be some machines having problems with it (all you need is a
cable and your firewire device must be OHCI1394 compliant AFAIK), but I
tried it out once and it worked fine.

There is even something additional to set up kgdb over firewire,
Bernhard knows more about this...

    Thomas

