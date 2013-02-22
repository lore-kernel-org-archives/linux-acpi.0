From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [GIT PATCH] USB patches for 3.9-rc1
Date: Fri, 22 Feb 2013 22:51:58 +0100
Message-ID: <20130222215158.GA4723@balto.lan>
References: <20130222085954.GA4352@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:59281 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756963Ab3BVVwK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Feb 2013 16:52:10 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so566376eek.0
        for <linux-acpi@vger.kernel.org>; Fri, 22 Feb 2013 13:52:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130222085954.GA4352@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, tianyu.lan@intel.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On Fri, Feb 22, 2013 at 03:59:54AM -0500, Dave Jones wrote:
> On Thu, Feb 21, 2013 at 10:40:10AM -0800, Greg KH wrote:
> 
>  > USB patches for 3.9-rc1
>  > 
>  > Here's the big USB merge for 3.9-rc1
>  > 
>  > Nothing major, lots of gadget fixes, and of course, xhci stuff.
> 
> I get no USB devices recognised when I insert them any more, which
> I think is pretty major.  I suspect it has something to do with this ?
> 
>  > Lan Tianyu (12):
>  >       usb: add runtime pm support for usb port device
>  >       usb: add usb port auto power off mechanism
> 
> It looks like every port on my laptop is powered down, as I can't
> even charge devices with it.

Hi Dave,

I have the same problem (and almost the same laptop, Thinkpad T430
here), all external USB ports without power - even the always-on one
:-).

The bug seems to be ACPI related, I bisected it down to this patch:

f95988d ACPI / scan: Treat power resources in a special way

In the dmesg I have some error like these:

ACPI: Power Resource [PUBS] (on)
...
pci 0000:00:14.0: System wakeup disabled by ACPI

for the USB controllers in the broken kernel, there are some in your
dmesg too.  I'll try to come up with a fix for current mainline, but all
the acpi stuff is quite obscure to me and the patch does not revert
cleanly, maybe Rafael (in CC) has some idea!

Fabio

-- 
Fabio Baltieri
