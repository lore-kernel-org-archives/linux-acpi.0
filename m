From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [patch 1/1] acpi: cleanup u32 flags in spin_lock calls
Date: Wed, 4 Jan 2006 07:11:29 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0601040710420.3052@gandalf.stny.rr.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005965885@hdsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0601032235340.28111@gandalf.stny.rr.com>
 <20060103195518.6b6a7afe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060103195518.6b6a7afe.akpm-3NddpPZAyC0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Tue, 3 Jan 2006, Andrew Morton wrote:

> Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org> wrote:
> >
> >  So as long as this is 64 bits
> >  on a 64 bit machine, I'm fine with it.
>
> No, it's wrong.  We cannot assume that a 64-bit platform defines u64 as
> `unsigned long'.  For example, one architecture (sh64) defines u64 as
> `unsigned long long', so we'll get warnings when mixing pointers to u64
> and to the arg to local_irq_*().
>
> Please don't invent new stuff.  Linux uses `unsigned long' and that's that.

OK, it was fine with me, but I guess it's not fine with Linus ;)

-- Steve

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
