From: Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
Subject: Re: Ask devices to powerdown before S3 sleep
Date: Tue, 21 Jan 2003 03:38:35 -0800 (PST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.10.10301210326580.16070-100000@master.linux-ide.org>
References: <20030121104737.GC24349@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030121104737.GC24349-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Pavel,

I failed to make the point clear.
One thing I learned was never trust the BIOS, even if you wrote it.

Now if you are missing ACPI hooks to beat the BIOS silly for whatever
reason you want, I will load two barrels towards Andy for not finishing
the task or not explaining how to throttle them.

I do not care if the BIOS want to do monkey flips.
If there is an event any piece of hardware can not handle, ie where you
have inserted tests that default to panic, it had better allow you to
throttle to full enable.

If it does not, the solution is to make a blackball list of hardware
which fails to conform to acpi rules.  Fair warning you had better have a
means to prove it because, public lists make companies nervous.

So, that I am clear ... would you consider changing the default method of
operations for errors.

How a BUG() and a really long long timer until the battery dies, a panic
gives little or no information, but this is my opinion.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

On Tue, 21 Jan 2003, Pavel Machek wrote:

> Hi!
> 
> > Could you do me just one tiny favor?
> > Please consider attempting an error recovery level path, maybe ...
> > 
> > Every patch I have glanced at has 'panic("blah blah");'
> > 
> > If you do not have enough hardware to generate an accurate path for
> > recovery, then please do not force the kernel into panic.  Would you
> > consider failing the request making it jump back to S1 ?  This at least
> > allows it crash like a power failure.
> 
> If I make it go S1, auto-reboot will not apply etc, and machine will
> crash during ENABLE, anyway...
