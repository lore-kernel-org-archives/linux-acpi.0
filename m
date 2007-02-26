From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2.6.21-rc1: framebuffer/console boot failure
Date: Mon, 26 Feb 2007 20:41:37 +0800
Message-ID: <1172493697.20842.6.camel@daplas>
References: <35472.86.7.220.119.1172237750.squirrel@wmbeta.mxes.net>
	 <20070224030950.074f88d4.akpm@linux-foundation.org>
	 <33525.86.7.220.119.1172358010.squirrel@wmbeta.mxes.net>
	 <1172359843.4415.8.camel@daplas>
	 <34578.86.7.220.119.1172401665.squirrel@wmbeta.mxes.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:42748 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965241AbXBZMjQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Feb 2007 07:39:16 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1238798nze
        for <linux-acpi@vger.kernel.org>; Mon, 26 Feb 2007 04:39:15 -0800 (PST)
In-Reply-To: <34578.86.7.220.119.1172401665.squirrel@wmbeta.mxes.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Nelless <andrew@nelless.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 2007-02-25 at 11:07 +0000, Andrew Nelless wrote:
> On Sat, February 24, 2007 11:30 pm, Antonino A. Daplas wrote:
> >
> > How about booting with just vga=normal?
> >
> >
> > Tony
> >
> 
> That seems to work too. I've rebooted about 20 times in a row
> and it hasn't done it again yet. Why would this only occur
> at higher modes?
> 
> In the 2.6.20 dmesg log it reads "Nvidia board detected.
> Ignoring ACPI timer override." whereas in 2.6.21-rc1 it doesn't.
> Could this be the culprit?
> 

I don't know, probably the ACPI code can now probably detect the
presence or absence of the HPET timer.

Can you remove CONFIG_FB_VESA support from your kernel config but boot
as if you have vesafb (ie with vga=<VESA mode number>). Your machine may
boot to completion but you will have a blank screen.  But you should be
able to have an output in netconsole and you can start X. I wanted to
know if the lockup is related to the framebuffer.

Tony


