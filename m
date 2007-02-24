From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2.6.21-rc1: framebuffer/console boot failure
Date: Sun, 25 Feb 2007 07:30:42 +0800
Message-ID: <1172359843.4415.8.camel@daplas>
References: <35472.86.7.220.119.1172237750.squirrel@wmbeta.mxes.net>
	 <20070224030950.074f88d4.akpm@linux-foundation.org>
	 <33525.86.7.220.119.1172358010.squirrel@wmbeta.mxes.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:32763 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933594AbXBXX2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Feb 2007 18:28:13 -0500
Received: by nz-out-0506.google.com with SMTP id s1so849693nze
        for <linux-acpi@vger.kernel.org>; Sat, 24 Feb 2007 15:28:12 -0800 (PST)
In-Reply-To: <33525.86.7.220.119.1172358010.squirrel@wmbeta.mxes.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Nelless <andrew@nelless.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, 2007-02-24 at 23:00 +0000, Andrew Nelless wrote:
> On Sat, February 24, 2007 11:09 am, Andrew Morton wrote:
> >
> > Presumably this regression was caused by the ACPI merge.  Are you able to
> > capture the dmesg output from the 2.6.20-rc1 boot?  netconsole might be useful here, thanks.
> >
> 
> I've confirmed a few things:
> 
> 1) 2.6.21-rc1 actually will boot intermittently.
> 2) pci=noacpi always allows 2.6.21-rc1 to boot.
> 2) 2.6.20 always boots.
> 3) There doesn't seem to be a pattern (that I can tell) between booting and not booting,
> although it'll now boot more often than not (It seemed very much t'other way around yesterday)
> 4) When 2.6.21-rc1 doesn't boot ('Boot'? Am i using the right term here? hmm...) nothing is
> sent across netconsole at all.
> 5) Netconsole is useful.
> 
> I've uploaded all the dmesg output i've managed to capture here:
> http://homepage.ntlworld.com/anelless/linux/2.6.21-rc1/
> 
> > (You get added to the post-2.6.20 regression list, so you'll be hearing
> > from us quite a lot for the next month.  Sorry ;))
> >
> 
> Lucky me :)

How about booting with just vga=normal?

Tony


