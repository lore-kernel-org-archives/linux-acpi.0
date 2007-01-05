From: Mattia Dongili <malattia@linux.it>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 5 Jan 2007 19:06:59 +0100
Message-ID: <20070105180659.GH13533@inferi.kami.home>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <1167946596.6816.7.camel@hughsie-laptop> <20070104215810.GE25619@inferi.kami.home> <200701051202.31208.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:41050 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422651AbXAESHs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jan 2007 13:07:48 -0500
Content-Disposition: inline
In-Reply-To: <200701051202.31208.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>, Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

On Fri, Jan 05, 2007 at 12:02:30PM -0500, Len Brown wrote:
> > > Well, HAL has used it for changing the brightness for the last year or
> > > so: /proc/acpi/sony/brightness
> > > 
> > > Although if you use a new enough HAL (CVS), the laptop will be supported
> > > via the shiny new backlight class.
> > 
> > great, -mm already has the /sys/class/backlight in place for sony_acpi
> > and I suppose the /proc entry can be kept until 2.6.20 is released, i.e.
> > just before pushing things for .21.
> > 
> > Len, would you allow it?
> 
> Sure, no problem.
> Checking it into my tree with /proc/acpi/sony is
> no different than what is in -mm today.
> 
> When we push upstream, however, the /proc/acpi/sony part should be gone,
> or at least scheduled for removal.

I'd rather avoid pushing mainline something already scheduled for
removal. Also, a workaround can eventually be implemented in the
userspace tools using /proc/acpi/sony

[...]
> thanks for stepping forward Mattia,

It's me who should thank :)
Thanks
-- 
mattia
:wq!
