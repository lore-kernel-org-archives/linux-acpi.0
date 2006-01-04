From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [patch 1/1] acpi: fix asus_acpi on Samsung P30/P35
Date: Wed, 4 Jan 2006 17:37:29 +0100
Message-ID: <20060104163729.GA6533@hell.org.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B30059658DB@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30059658DB-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, Greek0-hi6Y0CQ0nG0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Brown, Len:
> Due to necessary bug compatibility with MS, we're stuck with
> the implicit return workaround behaviour for the forseeable future.

I suppose so.

> acpi=struct exists so that OEMs can use Linux (and ACPICA)
> to test their BIOS.  Linux should do the right thing with
> or without it -- but I would expect it to be enabled only in
> the test lab in practice.
> 
> Note that in any case, acpi_strict is not intended to be
> changed at run-time -- for who knows what other workarounds
> other threads may be in the middle of when it might be changed...

That's exactly the reason I didn't push this concept further. Having a Big
ACPI Lock to accompany BKL is an interesting idea, but I doubt it would
catch on. OTOH, it would be nice to have 'my laptop boots with acpi=strict'
stickers to give out on trade shows. People would love it.

> The only question is what to do for 2.6.14/15 stable.
> A. apply this patch after it is tested in 2.6.16?
> B. wait for an update to replace this patch?

Ugh, 5 am is not exactly the best time to sound clear and concise. What I
meant was, in short:
1. The patch applied to acpi-test is sufficient for stable (i.e. 2.6.15.x).
2. I will provide another patch for acpi-test with my next batch of
   updates. These will go into 2.6.16, .17 or whatever. Until this time,
   however, the patch supplied stays at acpi-test.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
