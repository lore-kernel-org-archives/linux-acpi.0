From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [stable] Re: [patch 1/1] acpi: fix asus_acpi on Samsung P30/P35
Date: Wed, 4 Jan 2006 22:27:55 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300599D0BA@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Greek0-hi6Y0CQ0nG0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>Any reason not to push the current one up, instead of keeping 
>an interim patch that is in stable and acpi-test, but nowhere else?
>For -stable we prefer things that are upstream (i.e. reasonably well-tested).

No reason except that I'm waiting for an -mm iteration
before we pushing anything to 2.6.16.  It has been 3 weeks
since -mm shipped, so a lot has changed besides this
and I'd like to see it all survive -mm before pushing to linus.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
