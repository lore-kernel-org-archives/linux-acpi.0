From: Mattia Dongili <malattia@linux.it>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with the
 sony-platform module]
Date: Sat, 16 Jun 2012 22:07:06 +0900
Message-ID: <20120616130705.GB2326@kamineko.org>
References: <4FDA2051.3050108@babioch.de>
 <20120614203914.GA2645@kamineko.org>
 <4FDAE7FE.5030706@babioch.de>
 <20120615113637.GA5904@kamineko.org>
 <4FDB5202.706@babioch.de>
 <20120615223711.GA31180@kamineko.org>
 <4FDBC183.7050203@babioch.de>
 <20120616025223.GA5200@kamineko.org>
 <4FDC6D0A.8080505@babioch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FDC6D0A.8080505@babioch.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Karol Babioch <karol@babioch.de>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jun 16, 2012 at 01:24:58PM +0200, Karol Babioch wrote:
> Hi,
...
> > Can you try applying the sony-laptop patches on 3.2, boot with
> > acpi_backlight=vendor and see what is the state there?
> It behaves just like 3.3. What might be interesting is 3.1. Here some
> really strange values get returned:
> 
> [root@vpcs nv_backlight]# cat actual_brightness brightness max_brightness
...

how about the sony-laptop stuff with 3.1+patches?
What is the output of
$ grep . /sys/class/backlight/*/*
$ grep . /sys/devices/platform/sony-laptop/*
and the kernel log after these two commands

I'm trying to understand is if the patch series I sent works for
you on the last working version of kernel (i.e. 3.1 apparently).

...
> I'm currently trying to reconstruct the last version that worked for me.
> I'm quite sure that "vaio-full-3.0.4.patch" (from here [1]), worked fine
> with the 3.1.x branch. However I've just recompiled 3.1.10 and it
> doesn't seem to work. Anyway it worked without the
> "acpi_backlight=vendor" parameter, so I'm not quite sure whether this is
> of interest for you right now.

it is actually. What did you have in the sony-laptop sysfs directories
when booting with acpi_backlight=vendor?

Thanks!
-- 
mattia
:wq!
