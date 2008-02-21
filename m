From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 16:39:02 -0800
Message-ID: <200802201639.02502.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <200802201337.52247.jesse.barnes@intel.com> <b6a2187b0802201635t2acb31f2n366f8ef81f119034@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17746 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758344AbYBUAzP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 19:55:15 -0500
In-Reply-To: <b6a2187b0802201635t2acb31f2n366f8ef81f119034@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, suspend-devel List <suspend-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>

On Wednesday, February 20, 2008 4:35 pm Jeff Chua wrote:
> On Thu, Feb 21, 2008 at 5:37 AM, Jesse Barnes <jesse.barnes@intel.com> 
wrote:
> >  Ok, can you give this patch a try with the 'platform' method?  It should
> > at least tell us what ACPI would like the device to do at suspend time,
> > but it probably won't fix the hang.
>
> I can't get it to compile.
>
> drivers/char/drm/i915_drv.c: In function 'i915_suspend':
> drivers/char/drm/i915_drv.c:372: error: implicit declaration of
> function 'acpi_pci_choose_state'

Oops, maybe this should just be pci_choose_state instead.

> drivers/char/drm/i915_drv.c: In function 'i915_resume':
> drivers/char/drm/i915_drv.c:383: error: 'state' undeclared (first use
> in this function)
> drivers/char/drm/i915_drv.c:383: error: (Each undeclared identifier is
> reported only once
> drivers/char/drm/i915_drv.c:383: error: for each function it appears in.)

And this change should just be reverted (leave it as PCI_D0).

Thanks,
Jesse
