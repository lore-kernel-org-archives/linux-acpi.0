From: Tom St Denis <tstdenis@elliptictech.com>
Subject: Re: Brightness control fails between 3.6.8 and 3.7.0-rc7 (Intel
 915/Dell Vostro 3560)
Date: Sun, 2 Dec 2012 10:33:27 -0500 (EST)
Message-ID: <1035525993.121797.1354462407778.JavaMail.root@elliptictech.com>
References: <CAKMK7uG3CvfvmMdusSUQf9+rOv_W1AWmoEqH4EAGgCiTyRfNeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.scalarmail.ca ([98.158.95.75]:25078 "EHLO
	ironport-01.sms.scalar.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab2LBPd3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Dec 2012 10:33:29 -0500
In-Reply-To: <CAKMK7uG3CvfvmMdusSUQf9+rOv_W1AWmoEqH4EAGgCiTyRfNeg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-acpi@vger.kernel.org

Thanks Daniel so I'm taking back my bug report on the i915 and claiming this as a bug against the acpi_video stack.

What sort of information would the ACPI folk like from me to help diagnose this?

Here's a dmesg dump of all ACPI messages.

http://pastebin.com/b4XKe5Fk

Tom

----- Original Message -----
> From: "Daniel Vetter" <daniel.vetter@ffwll.ch>
> To: "Tom St Denis" <tstdenis@elliptictech.com>
> Cc: linux-kernel@vger.kernel.org, "intel-gfx" <intel-gfx@lists.freedesktop.org>, "dri-devel"
> <dri-devel@lists.freedesktop.org>
> Sent: Sunday, 2 December, 2012 9:42:39 AM
> Subject: Re: Brightness control fails between 3.6.8 and 3.7.0-rc7 (Intel 915/Dell Vostro 3560)
> 
> On Sun, Dec 2, 2012 at 2:49 PM, Tom St Denis
> <tstdenis@elliptictech.com> wrote:
> > Ok so on v3.7-rc1 [and I suspect up] I can manually control the
> > brightness by echoing to
> >
> > /sys/class/backlight/intel_backlight/brightness
> >
> > But I still can't use the buttons to control it (it only goes one
> > tick down from max and stops there).  I'm using GNOME3 from a
> > x86_64 unstable debian install [up to date with latest].
> >
> > I just noticed that under v3.7 I have a new directory
> > /sys/class/backlight/acpi_video1 which is what GNOME is actually
> > controlling.  I can't disable ACPI video control so is there a
> > workaround?
> 
> Hah, acpi registered a broken backlight driver, which overwrites the
> intel backlight - for once it's not i915.ko's fault ;-) For a
> workaround either disable the acpi backlight with
> acpi_backlight=vendor (iirc) kernel option or teach the X driver that
> you want a different backlight driver in the xorg.conf (Option
> "Backlight" "intel_backlight" should do the trick).
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> 
