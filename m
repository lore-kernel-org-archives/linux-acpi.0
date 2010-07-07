From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: a question about lid input device
Date: Wed, 7 Jul 2010 10:19:06 -0700
Message-ID: <20100707171906.GA4108@core.coreip.homeip.net>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
 <20100614020127.GA30773@khazad-dum.debian.net>
 <8005.1278515660@foxharp.boston.ma.us>
 <20100707162511.GA25178@core.coreip.homeip.net>
 <16574.1278521464@foxharp.boston.ma.us>
 <20100707170125.GB25178@core.coreip.homeip.net>
 <18986.1278522498@foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33149 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab0GGRT1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jul 2010 13:19:27 -0400
Received: by pxi14 with SMTP id 14so2756588pxi.19
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jul 2010 10:19:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <18986.1278522498@foxharp.boston.ma.us>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Fox <pgf@laptop.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <lenb@kernel.org>

On Wed, Jul 07, 2010 at 01:08:18PM -0400, Paul Fox wrote:
> dmitry wrote:
>  > On Wed, Jul 07, 2010 at 12:51:04PM -0400, Paul Fox wrote:
>  > > dmitry wrote:
>  > >  > On Wed, Jul 07, 2010 at 11:14:20AM -0400, Paul Fox wrote:
>  ...
>  > >  > > i understand that it's not fully general, but for the case of
>  > >  > > the lid:  is /proc/acpi/button/lid/LID/state going away?
>  > >  > 
>  > >  > Yes, according to feature-removal.txt ACPI procfs interface shoudl have
>  > >  > been gone back in 2008.
>  > > 
>  > > thanks.  i understand that adding sysfs entries for all the bells
>  > > and whistles on modern input devices might seem prohibitive.  on
>  > > the other hand, there are some basic interfaces that are very
>  > > usefully accessed from the shell.  i guess either way the
>  > > information is available, but having to rely on a utility package
>  > > for intermediate access always introduces new packaging
>  > > dependencies, release skew issues, etc, etc.
>  > > 
>  > 
>  > I am not wasting kernel memory to export full state of an arbitrary
>  > input device via sysfs just so someone out there might avoid writing or
>  > installig a utility. The interface was there for many years and is quite
>  > stable, I do not understand what release skew issues you are talking
>  > about.
> 
> if, for example, the utility package available in a distro lags
> behind the kernel.
> 

How can it lag? The interface to query the state is available at least
since 2.6.0 and is not likely to change for years to come.

> but please consider my comments above as more of a lament than a
> complaint.  i understand your design decision -- it will make
> your life easier, at the expense of making mine somewhat more
> difficult.  :-)
> 

It is not that it will make my life easier. Exporting state in sysfs is
easy, but do you really want your keyboard device to consume memory needed
for 100+ sysfs nodes that nobody cares about?

-- 
Dmitry
