From: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>
Subject: Re: [PATCH] SN: Add initial ACPI support
Date: 15 Jan 2006 07:34:54 -0500
Message-ID: <yq0slrp1xg1.fsf@jaguar.mkp.net>
References: <28961.1137282162@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <28961.1137282162-1LO6/iIh+iQ0n/F98K4Iww@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keith Owens <kaos-sJ/iWh9BUns@public.gmane.org>
Cc: John Keller <jpk-sJ/iWh9BUns@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>>>> "Keith" == Keith Owens <kaos-sJ/iWh9BUns@public.gmane.org> writes:

Hi,

Just a general comment on top of Keith's.

Keith> John Keller (on Sat, 14 Jan 2006 11:37:47 -0600 (CST)) wrote:
>> +inline uint64_t +sal_ioif_init(void)

Keith> Make that static with no inline, let gcc decide if it should be
Keith> inlined or not.

Please stick to using the preferred kernel internal types, u64/u32/u16
etc. I noticed you switch u64 to uint64_t in many places which is the
wrong way to go.

Regards,
Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
