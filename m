From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in
	hardware
Date: Thu, 3 Jul 2008 18:21:34 +0200
Message-ID: <20080703162134.GI6755@corsac.net>
References: <200807031805.52883.trenn@suse.de> <20080703160822.GA29110@srcf.ucam.org> <200807031815.13291.trenn@suse.de> <20080703161643.GB29110@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080703161643.GB29110@srcf.ucam.org>
Sender: linux-next-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 03, 2008 at 05:16:43PM +0100, Matthew Garrett wrote:
> > Try the next patch, it works for the T61.
> > These IGD parts could take quite a while still, while Toshibas and others
> > remain broken (and T61 poke on wrong hardware which could cause
> > all kind of badness).
> 
> The code's written and works, it just has a 750ms latency for reasons I 
> don't understand.

I dont know if it's the same thing, but I remember at one time that when
pressing my brightness keys (on a T61, intel graphics), the acpi event
appeared in /proc/acpi/event like 1 second later. I didn't check
precisely, but it could really be those 750ms. Irrc, this was only
happening after first suspend to ram.

Do these patches mean that, maybe in 2.6.27, brightness keys would work
directly from kernel, without needing hal, gnome-power-manager or
anything else, like X?

I can try those patches and report back, but on which kernel should I
apply them? 2.6.26-rc8? Or some git?

Cheers,
-- 
Yves-Alexis
