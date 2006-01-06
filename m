From: Ben Collins <ben.collins-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch 9/9] asus_acpi: Invert read of wled proc file to show
	correct state of LED
Date: Fri, 06 Jan 2006 10:19:53 -0500
Message-ID: <1136560794.4405.5.camel@grayson>
References: <200601060631.k066VEgJ008147@shell0.pdx.osdl.net>
 <20060106142853.GA20618@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20060106142853.GA20618-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: akpm-3NddpPZAyC0@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2006-01-06 at 15:28 +0100, Karol Kozimor wrote:
> Thus wrote akpm-3NddpPZAyC0@public.gmane.org:
> > 
> > From: Ben Collins <bcollins-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
> > 
> > User with this equipment stated that writes to this file worked correctly,
> > but that reads were showing inverted state (1 for off, 0 for on). 
> > Following the same style for reads, introduced an invert flag to read_led,
> > and used it for wled.
> 
> Any background on this patch? I've never received such reports, so it must
> be model-specific and require a model-specific work around.
> Best regards,

http://bugzilla.ubuntu.com/show_bug.cgi?id=10770

-- 
   Ben Collins <ben.collins-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
   Developer
   Ubuntu Linux

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
