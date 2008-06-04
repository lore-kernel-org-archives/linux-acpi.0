From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 00/18] PNP: convert resource options to unified dynamic list, v2
Date: Wed, 04 Jun 2008 16:09:33 -0600
Message-ID: <20080604220933.168145536@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:25395 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbYFDWLX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2008 18:11:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

This patch series converts the PNP resource option structures
to a unified linked list.  This preserves resource order, which
is important for some devices.  The bulk of the series is in
the last patch, and it has more a more detailed changelog.

Rene Herman did some testing of ISA devices and reviewed
v1 of this series.  I think I addressed all his comments.
Any comments would be welcome.

This depends on some patches that are in -mm, but not yet
upstream.  In mmotm, these would probably go after
pnp-dont-sort-by-type-in-sys-resources.patch

Note that I incorporated Rene's ioport.h comment fix
(pnpacpi-fix-irq-flag-decoding-comment-fix.patch) into
this series, so you should drop that if you pick up this
series.

Change between v1 and v2:
    - rewrote 8250_pnp modem identification (first patch in series)
    - used bitmap_copy() rather than explicit loop to copy IRQ bitmaps
    - added "(optional)" note in /sys/.../options for IORESOURCE_IRQ_OPTIONAL
    - split out ISAPNP ENDDEP bug fix into a separate patch
    - restored "clear auto resources" when auto-assignment fails
    - removed 0x100 from option priority
    - allocated 12 bits for dependent option priority, 16 bits for set number
    - restored check for invalid dependent function priority
    - fixed AD1815 quirk (set OPTIONAL flag in the correct "flags" field)
    - fixed ioport.h ISA PnP comment (replaces Rene's
      pnpacpi-fix-irq-flag-decoding-comment-fix.patch)
    - rename "pnp_dependent_option()" to "pnp_new_dependent_set()"

Bjorn
-- 
