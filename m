From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 8/8] ACPI PM: Add DMI quirk list for ACPI 1.0
	suspend ordering
Date: Thu, 10 Jul 2008 13:37:07 +0200
Message-ID: <20080710113707.GG15412@elf.ucw.cz>
References: <200807100152.17755.rjw@sisk.pl> <200807100207.03636.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758839AbYGJPFA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200807100207.03636.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Andi Kleen <andi@firstfloor.org>
List-Id: linux-acpi@vger.kernel.org

On Thu 2008-07-10 02:07:02, Rafael J. Wysocki wrote:
> From: Carlos Corbacho <carlos@strangeworlds.co.uk>
> Subject: ACPI PM: Add DMI quirk list for ACPI 1.0 suspend ordering
> 
> There are a few BIOS' that we know of already that need to use the
> ACPI 1.0 suspend order. This appears to be only be a small minority of
> mostly nVidia based systems.
> 
> Based on observation of Windows behaviour, it's clear that Windows is
> also doing maintaining its own list of broken hardware that needs this
> workaround.
> 
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
