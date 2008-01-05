From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Kohjinsha sleep problems
Date: Sat, 5 Jan 2008 22:44:40 +0100
Message-ID: <20080105214440.GA10292@elf.ucw.cz>
References: <20080101231955.GA1931@ucw.cz> <200801042233.44827.alessandro.guido@gmail.com> <20080105213536.GA2307@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53511 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754864AbYAEVoa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jan 2008 16:44:30 -0500
Content-Disposition: inline
In-Reply-To: <20080105213536.GA2307@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

Hi!

> > > On kohjinsha, wakeup code does not seem to be reached at all. I tried
> > > looking around FACS, but it seems very empty:
> > >
> > > ...
> > 
> > The same on my laptop:
> > 
> > FACS @ 0x2fefafc0
            signature   length      hwsignature waking_vector
> >   0000: 46 41 43 53 40 00 00 00 62 12 00 00 00 00 00 00  FACS@...b.......
> >   0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > 
> > 
> > I've never been able to resume from STR with Linux (works with Windows Vista). 
> > STD works, although I have to press the power button in order to
> > resume.

Hmm, that is strange. firmware_waking_vector seems to be all
zeros. How can that work?

struct acpi_table_facs {
        char signature[4];      /* ASCII table signature */
        u32 length;             /* Length of structure, in bytes */
        u32 hardware_signature; /* Hardware configuration signature */
        u32 firmware_waking_vector;     /* 32-bit physical address of
the Firmware Waking Vector */

...aha, firmware_waking_vector is to be filled by Linux, so I guess
this was false alarm.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
