From: Pavel Machek <pavel@suse.cz>
Subject: Re: acpi_os_allocate(GFP_KERNEL) (was Re: acpi_evaluate_integer
	broken by design)
Date: Thu, 18 Dec 2008 17:48:01 +0100
Message-ID: <20081218164801.GC16115@elf.ucw.cz>
References: <20081125110508.GA1943@elf.ucw.cz> <20081215214140.9031d4c8.akpm@linux-foundation.org> <200812161634.25838.rjw@sisk.pl> <200812170040.07977.rjw@sisk.pl> <alpine.LFD.2.00.0812180104500.17738@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752633AbYLRQq2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812180104500.17738@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-acpi@vger.kernel.org

On Thu 2008-12-18 01:07:08, Len Brown wrote:
> 
> 
> -- Len Brown, Intel Open Source Technology Center
> 
> > In fact, we should be using GFP_ATOMIC already while devices are being
> > suspended, so we can switch from GFP_KERNEL to GFP_ATOMIC even before
> > interrupts are enabled.
> 
> true.  it makes me wonder if tinkering with ACPI
> is a bad idea -- for it will address only one user of kmalloc.

Other users should already know that they are called while suspending
device, and behave accordingly (use right flags to kmalloc, etc.)

If not, that's a bug...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
