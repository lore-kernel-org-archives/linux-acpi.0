From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re. 2.6.15-mm1
Date: Fri, 6 Jan 2006 00:36:18 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30059D3B5D@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Vladimir V. Saveliev" <vs-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>> Jan  5 16:22:38 t40 kernel: pnp: PnP ACPI init
>> Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
>> Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
>> Jan  5 16:22:39 t40 last message repeated 10 times
>> Jan  5 16:22:39 t40 kernel: pnp: PnP ACPI: found 0 devices
>
>pnpacpi is unhappy.

pnpacpi is fixed:
http://lkml.org/lkml/2006/1/5/287

>> Jan  5 16:22:43 t40 kernel: **** SET: Misaligned resource pointer: f7db5502 
>
>acpi is unhappy.

Yes, that one is ours.  We'll track it here:

http://bugme.osdl.org/show_bug.cgi?id=5841

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
