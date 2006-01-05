From: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [stable] Re: [patch 1/1] acpi: fix asus_acpi on Samsung P30/P35
Date: Wed, 4 Jan 2006 17:47:07 -0800
Message-ID: <20060105014707.GE3335@sorel.sous-sol.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30059658DB@hdsmsx401.amr.corp.intel.com> <20060104163729.GA6533@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060104163729.GA6533-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Greek0-hi6Y0CQ0nG0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* Karol Kozimor (sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org) wrote:
> Thus wrote Brown, Len:
> > The only question is what to do for 2.6.14/15 stable.
> > A. apply this patch after it is tested in 2.6.16?
> > B. wait for an update to replace this patch?
> 
> Ugh, 5 am is not exactly the best time to sound clear and concise. What I
> meant was, in short:
> 1. The patch applied to acpi-test is sufficient for stable (i.e. 2.6.15.x).
> 2. I will provide another patch for acpi-test with my next batch of
>    updates. These will go into 2.6.16, .17 or whatever. Until this time,
>    however, the patch supplied stays at acpi-test.

Any reason not to push the current one up, instead of keeping an interim
patch that is in stable and acpi-test, but nowhere else?  For -stable we
prefer things that are upstream (i.e. reasonably well-tested).

thanks,
-chris
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
