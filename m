From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.15-mm2
Date: Sun, 8 Jan 2006 03:16:29 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A1348A@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 
>2) acpi-cpufreq does not load either, returns ENODEV too. It's probably
>git-acpi. I tried to revert it but there are lots of other patches
>depending on it, so I finally gave up.

Brice,
Can you try the converse?
Apply the acpi patch (which is included in -mm)
without the rest of the mm tree to see if that broke acpi-cpufreq?:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.15/acpi-test-20051216-2.6.15.diff.bz2

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
