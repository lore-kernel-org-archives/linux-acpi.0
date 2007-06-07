From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI Debug - for test, devel and possibly even for production kernels
Date: Thu, 7 Jun 2007 20:08:01 +0000
Message-ID: <20070607200800.GA10323@ucw.cz>
References: <1180624839.10908.71.camel@queen.suse.de> <84144f020705311157n6bede2c7ga234d70823d5869f@mail.gmail.com> <200705311556.17966.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2717 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762996AbXFHPKz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jun 2007 11:10:55 -0400
Content-Disposition: inline
In-Reply-To: <200705311556.17966.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi!

> > > (This should efficiently be the same as the proposed big patch a year
> > > ago from Pekka Enberg, just a bit smaller and should make ACPICA and
> > > kernel/linux people happy:
> > > http://marc.info/?l=linux-kernel&m=113699535303722&w=2)
> > 
> > No, you're keeping these obfuscating macros around:
> > 
> > +#define return_VOID                     return
> > +#define return_ACPI_STATUS(s)           return(s)
> > +#define return_VALUE(s)                 return(s)
> > +#define return_UINT8(s)                 return(s)
> > 
> > Making the ACPI code look like regular Linux kernel code (or even
> > regular C for that matter) was the whole point of my patch. Your patch
> > doesn't change that.
> 
> I think that Thomas's point is that he is optimally removing
> function tracing via #ifdef.
> Your 600KB patch, on the other hand, permanently removed the feature
> and touched every file in ACPICA.
> 
> The net effect to the user is the same, the ability to enable
> ACPI_DEBUG and not enable ACPICA function tracing.
> 
> As I probably wrote a year ago, it isn't viable to completely
> remove the tracing code --
> until Linux reaches a point where vendors certify that their
> BIOS is compatible with Linux before they ship, rather than the Linux
> community having to debug some Windows-compatible systems into
> Linux-compatibility well after they have shipped into the field.

Well, those obfuscating macros pretty much make acpi code unreadable
:-(. If function-level tracing is desired, perhaps it can be done via
linker magic?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
