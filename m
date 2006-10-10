From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Tue, 10 Oct 2006 11:10:13 -0500
Message-ID: <20061010161012.GA18847@lists.us.dell.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com> <200610102232.46627.luming.yu@gmail.com> <1160491646.6174.36.camel@hughsie-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:58283 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932198AbWJJQKK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 12:10:10 -0400
Content-Disposition: inline
In-Reply-To: <1160491646.6174.36.camel@hughsie-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Yu Luming <luming.yu@gmail.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

On Tue, Oct 10, 2006 at 03:47:26PM +0100, Richard Hughes wrote:
> On Tue, 2006-10-10 at 22:32 +0800, Yu Luming wrote:
> > >From my understanding, a cute userspace App shouldn't have this kind
> > of logic:
> >         if (is  DELL )
> >                 invoke libsmbios
> >         if (is  foo)
> >                 invoke libfoo,
> >         if (is bar)
> >                 invoke libbar,
> >         ....
> >         else
> >                 operate on /sys/class/backlight/ ,.,..
> 
> This is what HAL has at the moment[1]. And it's hell to maintain, but
> works for a lot of users.

This is slightly different.  This shows that there are a number of
slightly different kernel implementations:

/proc/acpi/toshiba/lcd
/proc/acpi/asus/brn
/proc/acpi/pcc/brightness
/proc/acpi/ibm/brightness
/proc/acpi/sony/brightness
/proc/omnibook/lcd

which is indeed nasty. I'd agree all in-kernel solutions should use
the same kernel<->user interface.  I'd also expect the kernel to have
a generic ACPI driver that exports the _BCL and _BCM method
implementations via that same interface, so that systems providing
that will "just work".  drivers/acpi/video.c currently exports this
via /proc/acpi/video/$DEVICE/brightness, which isn't the same as
/sys/class/backlight. :-(

There's also at least one more userspace option for the sonypi using
spiictrl.  This is where I expected libsmbios to plug in also, as a
fallback to the ACPI _BCL/_BCM methods above.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
