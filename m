From: Marek Wawrzyczny <marekw1977@yahoo.com.au>
Subject: Re: Generic battery interface
Date: Wed, 2 Aug 2006 17:46:13 +1000
Message-ID: <200608021746.13612.marekw1977@yahoo.com.au>
References: <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060731230145.GF3612@elf.ucw.cz> <20060802091841.8585a72a.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bld-mail01.adl2.internode.on.net ([203.16.214.65]:63632 "EHLO
	mail.internode.on.net") by vger.kernel.org with ESMTP
	id S1751358AbWHBHqc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Aug 2006 03:46:32 -0400
In-Reply-To: <20060802091841.8585a72a.khali@linux-fr.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Pavel Machek <pavel@suse.cz>, Shem Multinymous <multinymous@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@debian.org>, Mark Underwood <basicmark@yahoo.com>, Greg KH <greg@kroah.com>

On Wednesday 02 August 2006 17:18, Jean Delvare wrote:
> Hi Pavel,
>
> > > frequently it can read from the chip. And no hardware monitoring chip I
> > > know of can tell when the monitored value has changed - you have to
> > > read the chip registers to know.
> >
> > ACPI battery can tell when values change in significant way. (Like
> > battery becoming critical).
>
> Ah, good to know. But is there a practical use for this? I'd suspect
> that the user wants to know the battery charge% all the time anyway,
> critical or not.

Yes, the user may want to know the battery state all the time, but will not 
notice the difference between the system reporting battery changes every 100 
microseconds or every 10 seconds, unless the hardware eats its battery 
sources for breakfast? 

The system cares though, very much so in fact:

If the battery becomes critical the system should either shut down or suspend 
to disk (if this is supported). 
This obviously would be triggered by some sort of daemon (powersaved comes to 
mind).
Ideally the suspend to disk or shutdown event triggers another event that 
allows any desktop to save it's state or possibly unmount shares that could 
otherwise be corrupted.

This scenario is quite different to an application reading the battery level.


Marek Wawrzyczny
