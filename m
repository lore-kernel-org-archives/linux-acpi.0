From: Pavel Machek <pavel@suse.cz>
Subject: Re: Check for BIOS bugs - Original Subject: Re: [PATCH 23/70] ACPICA: Workaround for reversed _PRT entries from BIOS
Date: Mon, 7 Jul 2008 13:12:08 +0200
Message-ID: <20080707111207.GH5643@ucw.cz>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org> <deade3c973eb9c98d2a6cfed658bbb49e693894a.1213947350.git.len.brown@intel.com> <200807011033.27887.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2494 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756107AbYGHNi7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 09:38:59 -0400
Content-Disposition: inline
In-Reply-To: <200807011033.27887.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Huang Cheng <cheng.huang@intel.com>, firmwarekit-discuss@bughost.org, Arjan van de Ven <arjan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi!

> > Some BIOSs erroneously reverse the _PRT SourceName and the
> > SourceIndex.  Detect and repair this problem. MS ACPI also allows
> > and repairs this problem, thus ACPICA must also.
> 
> It would be great to have an interface to report this as a BIOS defect.
> 
> Something like:
> 
> FIRMWARE_BUG_ON(FIRM_WARN, "erroneously reversed the _PRT source_name", ACPI_ 
> Bug);
> 
> FIRMWARE_BUG_ON(severity, description, component);

Yes, please.

I'd also like HARDWARE_BUG_ON(), with similar usage.

With all the preload-linux-on-foo project, we have some chance to make
BIOS vendors fix their stuff if we can easily diagnose errors in
there.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
