From: Kai Germaschewski <kai-K3FV8rsiL1oTdZ4mcS17cL1bcanuHkqH@public.gmane.org>
Subject: RE: [PATCH] S4bios for 2.5.52.
Date: Tue, 17 Dec 2002 16:14:41 -0600 (CST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.44.0212171611460.21707-100000@chaos.physics.uiowa.edu>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B1@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B1-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Ducrot Bruno' <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 17 Dec 2002, Grover, Andrew wrote:

> > From: Ducrot Bruno [mailto:poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] 
> > This patch add s4bios support for 2.5.52.

> > echo 4 > /proc/acpi/sleep is for swsusp;
> > echo 4b > /proc/acpi/sleep is for s4bios.
> 
> I still am not clear on why we would want s4bios in 2.5.x, since we have S4.
> Like you said, S4bios is easier to implement, but since Pavel has done much
> of the heavy lifting required for S4 proper, I don't see the need.

Let me counter this, I have to admit that I didn't try the patch yet, but
my laptop does S4 BIOS, and I'd definitely prefer that to swsusp, since
it's much faster and also I somewhat have more faith into S4 BIOS than
swsusp (as in: after resuming, it'll most likely either work or crash, but
not cause any weird kinds of corruption). Since it does not need not much
more to support it than S3, I don't see why you wouldn't want to give
users the option?

--kai
