From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: a question about lid input device
Date: Wed, 7 Jul 2010 10:01:25 -0700
Message-ID: <20100707170125.GB25178@core.coreip.homeip.net>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
 <20100614020127.GA30773@khazad-dum.debian.net>
 <8005.1278515660@foxharp.boston.ma.us>
 <20100707162511.GA25178@core.coreip.homeip.net>
 <16574.1278521464@foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54601 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab0GGRBd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jul 2010 13:01:33 -0400
Received: by pzk26 with SMTP id 26so1171104pzk.19
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jul 2010 10:01:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <16574.1278521464@foxharp.boston.ma.us>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Fox <pgf@laptop.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <lenb@kernel.org>

On Wed, Jul 07, 2010 at 12:51:04PM -0400, Paul Fox wrote:
> dmitry wrote:
>  > On Wed, Jul 07, 2010 at 11:14:20AM -0400, Paul Fox wrote:
>  > > henrique de moraes holschuh wrote:
>  > >  > On Sun, 13 Jun 2010, Zhang Rui wrote:
>  > >  > > Then we update the lid switch status when a Lid notification comes.
>  > >  > > right?
>  > >  > 
>  > >  > Yes.
>  > >  > 
>  > >  > > Then, IMO, userspace can get the lid status
>  > >  > > via /sys/class/input/inputX/uevent, right?
>  > >  > 
>  > >  > No, only through an IOCTL.
>  > >  > 
>  > >  > > /sys/class/input/input1/uevent:EV==21
>  > >  > 
>  > >  > That's an bitmap of al EV_EV it supports.
>  > >  > 
>  > >  > > /sys/class/input/input1/uevent:SW==1
>  > >  > 
>  > >  > That's an bitmap of al EV_SW it supports.
>  > >  > 
>  > >  > > Lid is opened but SW is set, I tried to close/open the lid and found
>  > >  > > that this bit never changes. is there something I misunderstand? can we
>  > >  > > get the lid status in userspace?
>  > >  > 
>  > >  > IOCTL(), only.
>  > >  > 
>  > >  > Since nobody got a input-utils standard package (or added something to
>  > >  > util-linux) yet to do that (AFAIK anyway), it is a MAJOR annoyance for
>  > >  > shell scripts that want to query EV_SW state...
>  > > 
>  > > i understand that it's not fully general, but for the case of
>  > > the lid:  is /proc/acpi/button/lid/LID/state going away?
>  > > 
>  > 
>  > Yes, according to feature-removal.txt ACPI procfs interface shoudl have
>  > been gone back in 2008.
> 
> thanks.  i understand that adding sysfs entries for all the bells
> and whistles on modern input devices might seem prohibitive.  on
> the other hand, there are some basic interfaces that are very
> usefully accessed from the shell.  i guess either way the
> information is available, but having to rely on a utility package
> for intermediate access always introduces new packaging
> dependencies, release skew issues, etc, etc.
> 

I am not wasting kernel memory to export full state of an arbitrary
input device via sysfs just so someone out there might avoid writing or
installig a utility. The interface was there for many years and is quite
stable, I do not understand what release skew issues you are talking
about.

Thanks.

-- 
Dmitry
