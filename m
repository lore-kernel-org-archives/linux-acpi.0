From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/3] i915: Don't provide ACPI backlight interface if
 firmware expects Windows 8
Date: Sat, 15 Jun 2013 22:35:34 +0200
Message-ID: <20130615203534.GC6424@phenom.ffwll.local>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
 <20130615151628.GA9868@srcf.ucam.org>
 <20130615182942.GA6424@phenom.ffwll.local>
 <6834259.1uPUZ8EFRd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:60435 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab3FOUfq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Jun 2013 16:35:46 -0400
Received: by mail-ea0-f170.google.com with SMTP id h10so1002644eaj.29
        for <linux-acpi@vger.kernel.org>; Sat, 15 Jun 2013 13:35:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6834259.1uPUZ8EFRd@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Vetter <daniel@ffwll.ch>, Matthew Garrett <mjg59@srcf.ucam.org>, Aaron Lu <aaron.lu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Seth Forshee <seth.forshee@canonical.com>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Aaron Lu <aaron.lwe@gmail.com>, Alex Deucher <alexdeucher@gmail.com>

On Sat, Jun 15, 2013 at 10:27:06PM +0200, Rafael J. Wysocki wrote:
> On Saturday, June 15, 2013 08:29:42 PM Daniel Vetter wrote:
> > Hi all,
> > 
> > So to me it looks like the discussion is going in circles a bit, hence let
> > me drop my maintainer-opinion here:
> > 
> > 1. Matthew's patch series here looks reasonable, and if it fixes a bunch
> > of systems (which it seems to) it has my Ack and imo should go in. If acpi
> > maintainers can smash their Ack onto the acpi parts I'd very much like to
> > merge this into drm-intel-next, that should give us the most coverage for
> > intel systems.
> > 
> > Len, Rafael, are you ok with the acpi part of this and merging it through
> > drm-intel-next?
> 
> It has to go through the ACPI tree because of the ACPICA patch that needs to
> be synchronized with the ACPICA upstream.  Sorry.

No problem, since we're pretty close to the merge window that would have
at most resulted in a few more weeks of testing in i915 trees anyway. -rc
kernels should still give us plenty of time to catch fallout, if there is
any.

> That said, I'm going to take this patchset.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
