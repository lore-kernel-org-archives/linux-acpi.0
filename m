From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in hardware
Date: Thu, 3 Jul 2008 20:24:05 +0100
Message-ID: <20080703192405.GB32260@srcf.ucam.org>
References: <200807031805.52883.trenn@suse.de> <20080703160822.GA29110@srcf.ucam.org> <200807031815.13291.trenn@suse.de> <20080703161643.GB29110@srcf.ucam.org> <20080703162134.GI6755@corsac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080703162134.GI6755@corsac.net>
Sender: linux-next-owner@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 03, 2008 at 06:21:34PM +0200, Yves-Alexis Perez wrote:

> I dont know if it's the same thing, but I remember at one time that when
> pressing my brightness keys (on a T61, intel graphics), the acpi event
> appeared in /proc/acpi/event like 1 second later. I didn't check
> precisely, but it could really be those 750ms. Irrc, this was only
> happening after first suspend to ram.

Yes, it's the same issue.

> Do these patches mean that, maybe in 2.6.27, brightness keys would work
> directly from kernel, without needing hal, gnome-power-manager or
> anything else, like X?

Right.

> I can try those patches and report back, but on which kernel should I
> apply them? 2.6.26-rc8? Or some git?

It's against drm git - search the dri-devel archives for the patch.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
