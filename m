From: Pavel Machek <pavel@ucw.cz>
Subject: Re: i915 hibernation patch (was: Re: [Suspend-devel] 2.6.25-rc2
	System no longer powers off aftersuspend-to-disk. Screen becomes
	green.)
Date: Sat, 23 Feb 2008 12:17:00 +0100
Message-ID: <20080223111700.GB1909@elf.ucw.cz>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <200802230031.20292.rjw@sisk.pl> <alpine.LFD.1.00.0802221653000.21332@woody.linux-foundation.org> <200802230255.54510.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48740 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750927AbYBWLQg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Feb 2008 06:16:36 -0500
Content-Disposition: inline
In-Reply-To: <200802230255.54510.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jesse.barnes@intel.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Romano Giannetti <romano@dea.icai.upcomillas.es>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, pm list <linux-pm@lists.linux-foundation.org>

> > Apart from those issues it looks fine to me.

> 
> OK, please have a look at the modified patch below.

Seems to work here after basic tests. ACK.

(I discovered that -rc2 swsusp will not power down in some cases, but
it was here before the patch, too...)
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
