From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: 17 Feb 2005 01:16:45 -0500
Message-ID: <1108621005.2096.412.camel@d845pe>
References: <20050214211105.GA12808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050214211105.GA12808-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel,
I think that it is the BIOS' job on S3-suspend
to save the video mode.  On S3-resume the BIOS should
re-POST and restore the video mode.

While Linux's X drivers may be able to handle the case
where X is running -- that doesn't help us with the
cases where X is not running (a case that Windows
presumably does not have).

Besides updated X drivers, which may have complicated
restore routines for complicated modes, all the other
techniques for restoring video from Linux are
hit/miss workarounds for broken platforms.

To completely solve the Linux S3 video restore issue,
we need to push the platform and BIOS vendors.

What am I missing?

thanks,
-Len




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
