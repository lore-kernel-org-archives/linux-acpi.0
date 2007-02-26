From: "Andrew Nelless" <andrew@nelless.net>
Subject: Re: 2.6.21-rc1: framebuffer/console boot failure
Date: Mon, 26 Feb 2007 18:48:58 -0000 (GMT)
Message-ID: <36488.86.7.220.119.1172515738.squirrel@wmbeta.mxes.net>
References: <35472.86.7.220.119.1172237750.squirrel@wmbeta.mxes.net>
    <20070224030950.074f88d4.akpm@linux-foundation.org>
    <33525.86.7.220.119.1172358010.squirrel@wmbeta.mxes.net>
    <1172359843.4415.8.camel@daplas>
    <34578.86.7.220.119.1172401665.squirrel@wmbeta.mxes.net>
    <1172493697.20842.6.camel@daplas>
Reply-To: "Andrew Nelless" <andrew@nelless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxout-03.mxes.net ([216.86.168.178]:2068 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030426AbXBZStA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Feb 2007 13:49:00 -0500
In-Reply-To: <1172493697.20842.6.camel@daplas>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

On Mon, February 26, 2007 12:41 pm, Antonino A. Daplas wrote:
>
> I don't know, probably the ACPI code can now probably detect the
> presence or absence of the HPET timer.
>
> Can you remove CONFIG_FB_VESA support from your kernel config but boot
> as if you have vesafb (ie with vga=<VESA mode number>). Your machine may boot to completion but
> you will have a blank screen.  But you should be able to have an output in netconsole and you
> can start X. I wanted to know if the lockup is related to the framebuffer.
>
> Tony
>
>

I disabled CONFIG_FB_VESA but it is still happening because
intermittent boots don't pump out anything over NetConsole.

It's tempting to think this is a hardware issue but I've been
booting 2.6.20 daily since -rc3 and this hasn't happened before
and still doesn't. I've even installed Asus's latest "beta bios"
(which convenient doesn't come with a changelog) but it had
no effect.

The only thing I can think to do now is another git bisect.
Now I know this occurs on average about every third boot I
could do half a dozen reboots between bisections and hopefully
find out what caused the problem..

Unfortunately I won't have the time for such a time consuming
adventure much the weekend..

Any further ideas?

 -- Andrew

P.S. You mentioned HPET, is this HPET config normal?
andrew@ziggy ~ $ fgrep -i hpet /usr/src/linux-2.6.21-rc1/.config
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_HPET is not set


