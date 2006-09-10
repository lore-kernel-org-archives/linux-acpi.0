From: Pavel Machek <pavel@ucw.cz>
Subject: Re: io-apic breaks suspend unless acpi_skip_timer_override
Date: Mon, 11 Sep 2006 00:33:08 +0200
Message-ID: <20060910223308.GA1691@elf.ucw.cz>
References: <20060910141533.GA6594@srcf.ucam.org> <20060910205803.GA1966@elf.ucw.cz> <20060910212045.GA9278@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3484 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932169AbWIJWd0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Sep 2006 18:33:26 -0400
Content-Disposition: inline
In-Reply-To: <20060910212045.GA9278@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun 2006-09-10 22:20:45, Matthew Garrett wrote:
> On Sun, Sep 10, 2006 at 10:58:03PM +0200, Pavel Machek wrote:
> 
> > Do you mean suspend-to-RAM? Can you try beeping patch?
> 
> Yes, suspend to RAM. I'll look at trying to work out where it blows up, 
> though I suspect it's successfully getting back into C code.

If you are back in C, that should be easy. Just serial console or
something... :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
