From: Ducrot Bruno <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] S4bios for 2.5.52.
Date: Wed, 18 Dec 2002 09:59:02 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021218085902.GD1012@poup.poupinou.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B1@orsmsx119.jf.intel.com> <Pine.LNX.4.44.0212171611460.21707-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212171611460.21707-100000-+ltLZMaECS1Ps8vDFOCQiqGgjKF21WCF@public.gmane.org>
To: Kai Germaschewski <kai-K3FV8rsiL1oTdZ4mcS17cL1bcanuHkqH@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Ducrot Bruno' <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 17, 2002 at 04:14:41PM -0600, Kai Germaschewski wrote:
> On Tue, 17 Dec 2002, Grover, Andrew wrote:
> 
> > > From: Ducrot Bruno [mailto:poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] 
> > > This patch add s4bios support for 2.5.52.
> 
> > > echo 4 > /proc/acpi/sleep is for swsusp;
> > > echo 4b > /proc/acpi/sleep is for s4bios.
> > 
> > I still am not clear on why we would want s4bios in 2.5.x, since we have S4.
> > Like you said, S4bios is easier to implement, but since Pavel has done much
> > of the heavy lifting required for S4 proper, I don't see the need.
> 
> Let me counter this, I have to admit that I didn't try the patch yet, but
> my laptop does S4 BIOS, and I'd definitely prefer that to swsusp, since
> it's much faster and also I somewhat have more faith into S4 BIOS than
> swsusp (as in: after resuming, it'll most likely either work or crash, but
> not cause any weird kinds of corruption). Since it does not need not much
> more to support it than S3, I don't see why you wouldn't want to give
> users the option?
> 

In fact, I agree with Andrew.  But Pavel insist and want it,
and since it is really straightforward to have it in 2.5
because Pavel have already done all the work, why not giving
him a little gift for Christmas ?

A final word:  S4bios is way much _slower_ by nature than S4OS, especially
at suspend path, which is what we don't want if we have to go to S4 due
to an emergency.

Kai, if you see that S4OS is slower, it is probably a bug that have to be
fixed in swsusp.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
