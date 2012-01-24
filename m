From: joeyli <jlee@suse.com>
Subject: Re: Fwd: [Bugreport] Screen backllight issues on FirePro M5950 (HP
 EliteBook 8560w)
Date: Tue, 24 Jan 2012 08:58:40 +0800
Message-ID: <1327366720.7090.7.camel@linux-s257.site>
References: <CAEPe-G+b9U-vdDmU29=GjyABab=5-MzWm4U6pBj1upRgLjH1OQ@mail.gmail.com>
	 <CAGB3EUR750VpHdvrZ25mn9bcS-4ZT+BSJ_zD4-sRncyYNT=0Zg@mail.gmail.com>
	 <1323442460.20114.95.camel@linux-s257.site>
	 <CAEPe-G+iooX_BOD=5m1nMgn+t63XGsLR+4JCfvHKOyTx98qydg@mail.gmail.com>
	 <1324443308.10394.456.camel@linux-s257.site>
	 <CAEPe-GLzak+SG3-H4Sw8KsQmpsh-v0UJWfHQb7hXoycO0GoWTA@mail.gmail.com>
	 <1327030553.15960.92.camel@linux-s257.site>
	 <CAEPe-G+H6CDDzg9-fXZK4MJbKw_-MJFSMheCL9=yN4Gt=fmaTQ@mail.gmail.com>
	 <1327196727.15960.118.camel@linux-s257.site>
	 <CAEPe-GKff7y1g4qc5gSz4vuhz5P0XpGgPTO570YzkjO6AZNV4A@mail.gmail.com>
	 <1327276502.15960.150.camel@linux-s257.site>
	 <CAEPe-G+jNsa5VScrk-Nii2e=0U5bVWtcCT5apOy0BAJrjKri4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:47391 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab2AXBDA (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Mon, 23 Jan 2012 20:03:00 -0500
In-Reply-To: <CAEPe-G+jNsa5VScrk-Nii2e=0U5bVWtcCT5apOy0BAJrjKri4Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Artur Flinta <aflinta@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Mon, 2012-01-23 at 15:45 +0100, Artur Flinta wrote:
> Hi!
> 
> On Mon, Jan 23, 2012 at 12:55 AM, joeyli <jlee@suse.com> wrote:
> > Yes! we still need fix the problem with backlight control. Please kindly
> > give me the result after add the following debug parameter:
> >        acpi.debug_level=0xF acpi.debug_layer=0xFFFFFFFF log_buf_len=5M
> >
> 
> I did it and log is in attachment.
> 

Thanks, but looks like your kernel didn't enable 
	CONFIG_ACPI_DEBUG=y

So, doesn't show up any acpi debug log in messages.

> > And,
> > Did you try the following kernel parameter?
> >        acpi_backlight=vendor
> 
> Sure, but after applying it, backlight control keys doesn't work
> anymore, there is also no any message in the log.
> 

Does it work set backlight level by sysfs?
	echo 9 > /sys/class/backlight/acpi_video0/brightness

> I've also checked command: watch -n 1 cat
> /sys/firmware/acpi/interrupts/gpe[012][0123456789ABCDEF]
> but nothing changed too.
> 
> Regards
> Artur

I think don't neet test gpe anymore, because we already know function
key emit scancode.


Thanks a lot!
Joey Lee



