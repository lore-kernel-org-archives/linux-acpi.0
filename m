From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6/6] Revert "ACPI: video: Ignore ACPI video devices that aren't present in hardware"
Date: Tue, 18 Mar 2008 17:01:30 -0400
Message-ID: <200803181701.30447.lenb@kernel.org>
References: <1205820132-21689-1-git-send-email-lenb@kernel.org> <f0d6752c9fa51d24c86b57c76ec5b2926a716b23.1205819948.git.len.brown@intel.com> <1205852061.21619.192.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35735 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756034AbYCTBRQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Mar 2008 21:17:16 -0400
In-Reply-To: <1205852061.21619.192.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org, Adrian Bunk <bunk@stusta.de>

On Tuesday 18 March 2008, Thomas Renninger wrote:
> On Tue, 2008-03-18 at 02:02 -0400, Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> > 
> > This reverts commit 3fa2cdcc45a0176de15cac9dbf4ed2834ebf8932.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=9995
> 
> This is so wrong...
> You register a driver on a device which does not exist.
> You do this because on T61 ThinkPads, the external graphics device
> method (soft-int 10) for brightness switching also works for the
> internal Intel graphics card by pure luck...
>
> You introduce this obviously wrong approach and break other machines
> intentionally (this is not a regression, because brightness switching
> was done through thinkpad_acpi before).

acpi video brightness worked on the T61 before this patch, eg. in 2.6.24.
acpi video brightness stopped working when this patch was applied.
acpi video brightness works again when this patch (and its clone) were reverted.

> This is known for months and reverting this in last minute is the wrong
> action.
> This should be:
>   - fixed up in BIOS through a OSI("IGD") string

IGD isn't part of this discussion, since that support didn't ship
in 2.6.24, and isn't shipping in 2.6.25.

Enabling IGD, or any other feature, via OSI on a platform that has
already shipped is effectively impossible.  It would require every
BIOS and every OS to be updated.

>   - get workarounded (as it always has been done) in thinkpad-acpi
>     meanwhile.
>
> Please try to not load the ACPI video driver.
> Instead load the thinkpad_acpi driver with:
> brightness_enable=1
> parameter. Does this work?
> If that works, this is the right workaround for T61 with
> internal/on-board
> Intel graphics card.

Yes, the thinkpad_acpi driver with brightness_enable=1 works.

The thinkpad_acpi driver is really useful.
It provides ways to get to thinkpad features for which
no standard interface in Linux currently exists.

However, the thinkpad_acpi driver should not be used
to provide features for which a generic method exists.

I understand that a distro may latch onto thinkpad_acpi
to get features in the hands of customers as soon as possible.
I understand that the transition off of custom solutions
is never easy.  brightness_enable=1 was added to ease that
transition.  If you have additional suggestions, please speak up.

> You can get a dmi blacklisting so that video driver is not loaded on the
> ThinkPads or this can be done in user-space, but pls do not revert this
> obvious fix.

This patch was far from obvious, including to Matthew, who created it.

-Len
