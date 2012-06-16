From: Mattia Dongili <malattia@linux.it>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with the
 sony-platform module]
Date: Sun, 17 Jun 2012 08:16:58 +0900
Message-ID: <20120616231658.GC2326@kamineko.org>
References: <20120614203914.GA2645@kamineko.org>
 <4FDAE7FE.5030706@babioch.de>
 <20120615113637.GA5904@kamineko.org>
 <4FDB5202.706@babioch.de>
 <20120615223711.GA31180@kamineko.org>
 <4FDBC183.7050203@babioch.de>
 <20120616025223.GA5200@kamineko.org>
 <4FDC6D0A.8080505@babioch.de>
 <20120616130705.GB2326@kamineko.org>
 <4FDCCB79.9090305@babioch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FDCCB79.9090305@babioch.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Karol Babioch <karol@babioch.de>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Karol

On Sat, Jun 16, 2012 at 08:07:53PM +0200, Karol Babioch wrote:
> Hi,
> 
> Am 16.06.2012 15:07, schrieb Mattia Dongili:
...
> > I'm trying to understand is if the patch series I sent works for
> > you on the last working version of kernel (i.e. 3.1 apparently).
> No, it doesn't work neither on 3.0 nor on 3.1. Interestingly the
> original patch that definitely did work on 3.0 and 3.1. I'm not quite
> sure what is the reason for this. I've basically compiled every kernel
> version from 3.0 to 3.3 :(.
> 
> > it is actually. What did you have in the sony-laptop sysfs directories
> > when booting with acpi_backlight=vendor?
> Unfortunately I don't know and can't reproduce a working solution here
> :(. Any clue why this could be?

I'm a bit lost at this point. Are you saying that you cannot get a
working backlight control with the old set-up you had?

If so what else did you change in your set up?
Also, any chance you could try to inspect/poke the acpi_video0 or
sony-laptop backlight directories without loading the nouveau driver?

thanks
-- 
mattia
:wq!
