From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] S4bios for 2.5.52.
Date: Tue, 17 Dec 2002 14:24:23 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B6@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Kai Germaschewski' <kai-K3FV8rsiL1oTdZ4mcS17cL1bcanuHkqH@public.gmane.org>
Cc: 'Ducrot Bruno' <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Kai Germaschewski [mailto:kai-K3FV8rsiL1oTdZ4mcS17cL1bcanuHkqH@public.gmane.org] 
> > I still am not clear on why we would want s4bios in 2.5.x, 
> since we have S4.
> > Like you said, S4bios is easier to implement, but since 
> Pavel has done much
> > of the heavy lifting required for S4 proper, I don't see the need.
> 
> Let me counter this, I have to admit that I didn't try the 
> patch yet, but
> my laptop does S4 BIOS, and I'd definitely prefer that to 
> swsusp, since
> it's much faster and also I somewhat have more faith into S4 BIOS than
> swsusp (as in: after resuming, it'll most likely either work 
> or crash, but
> not cause any weird kinds of corruption). Since it does not 
> need not much
> more to support it than S3, I don't see why you wouldn't want to give
> users the option?

Ok that's reasonable.

My belief is that S4bios is a stopgap measure until S4 gets better. That
said, I think you are right - it should go in for now, and then at some
point in the future someone will say, "S4bios?? who needs *that* anymore??"
and it will get pulled out. ;-)

So I'll look to merge it, unless someone upstream beats me to it.

Regards -- Andy
