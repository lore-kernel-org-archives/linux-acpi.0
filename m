From: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Thu, 17 Feb 2005 11:15:33 +0100
Message-ID: <20050217101533.GA15721@ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <1108621005.2096.412.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108621005.2096.412.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 17, 2005 at 01:16:45AM -0500, Len Brown wrote:

> Pavel,
> I think that it is the BIOS' job on S3-suspend
> to save the video mode.  On S3-resume the BIOS should
> re-POST and restore the video mode.

Should.

But this definitely is not the case on about 80+% of notebooks.

You can save the video state through VESA VBE, and restore it on resume,
but if the BIOS didn't re-POST the video, this will often fail.

> While Linux's X drivers may be able to handle the case
> where X is running -- that doesn't help us with the
> cases where X is not running (a case that Windows
> presumably does not have).
> 
> Besides updated X drivers, which may have complicated
> restore routines for complicated modes, all the other
> techniques for restoring video from Linux are
> hit/miss workarounds for broken platforms.
> 
> To completely solve the Linux S3 video restore issue,
> we need to push the platform and BIOS vendors.

That's correct.

> What am I missing?
 
I'm not sure if you can push the whole industry at once.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
