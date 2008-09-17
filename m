From: Pavel Machek <pavel@suse.cz>
Subject: Re: ACPI suspend: test 64-bit waking vector (was Re: [PATCH] ACPI
	suspend: Always use the 32-bit waking vector)
Date: Wed, 17 Sep 2008 09:28:58 +0200
Message-ID: <20080917072858.GA2659@elf.ucw.cz>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com> <200809061313.02088.rjw@sisk.pl> <20080915111836.GA17913@elf.ucw.cz> <200809170745.19645.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41454 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYIQH1f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Sep 2008 03:27:35 -0400
Content-Disposition: inline
In-Reply-To: <200809170745.19645.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Suspend-devel list <suspend-devel@lists.sourceforge.net>, "Li, Shaohua" <shaohua.li@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "andi@firstfloor.org" <andi@firstfloor.org>

On Wed 2008-09-17 07:45:18, Rafael J. Wysocki wrote:
> On Monday, 15 of September 2008, Pavel Machek wrote:
> > Hi!
> > 
> > ACPI specificiation tells us that x_firmware_waking_vector is
> > preffered, and maybe it works better than firmware_waking_vector on
> > some machines.
> > 
> > Unfortunately, it does not seem to work on thinkpad x60... but I am
> > not sure if I'm not doing something wrong.
> > 
> > Testing/ideas would be welcome.
> 
> Well, the spec says that if x_firmware_waking_vector is non-zero, the BIOS is
> supposed to call your wake-up code in Protected Mode ...

That's why I'm passing physical address of 32-bit code...

or am I supposed to pass 48-bit selector:offset pair? But what GDT
will BIOS use in that case?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
