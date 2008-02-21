From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 08:35:38 +0800
Message-ID: <b6a2187b0802201635t2acb31f2n366f8ef81f119034@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	 <200802201053.16218.jesse.barnes@intel.com>
	 <b6a2187b0802201110k6e6c458dg6f48c586fff6187a@mail.gmail.com>
	 <200802201337.52247.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:56156 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823AbYBUAfj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 19:35:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4246602wah.23
        for <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 16:35:39 -0800 (PST)
In-Reply-To: <200802201337.52247.jesse.barnes@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, suspend-devel List <suspend-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>

On Thu, Feb 21, 2008 at 5:37 AM, Jesse Barnes <jesse.barnes@intel.com> wrote:

>  Ok, can you give this patch a try with the 'platform' method?  It should at
>  least tell us what ACPI would like the device to do at suspend time, but it
>  probably won't fix the hang.

I can't get it to compile.

drivers/char/drm/i915_drv.c: In function 'i915_suspend':
drivers/char/drm/i915_drv.c:372: error: implicit declaration of
function 'acpi_pci_choose_state'
drivers/char/drm/i915_drv.c: In function 'i915_resume':
drivers/char/drm/i915_drv.c:383: error: 'state' undeclared (first use
in this function)
drivers/char/drm/i915_drv.c:383: error: (Each undeclared identifier is
reported only once
drivers/char/drm/i915_drv.c:383: error: for each function it appears in.)
make[3]: *** [drivers/char/drm/i915_drv.o] Error 1
make[2]: *** [drivers/char/drm] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

Thanks,
Jeff.
