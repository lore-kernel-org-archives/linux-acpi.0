From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: High frequency sound when loading the processor module --   Please help
Date: Sat, 9 Apr 2005 00:17:03 +0200
Message-ID: <20050408221703.GA20022@isilmar.linta.de>
References: <200504081428.48477.gkanis@cems.umn.edu> <200504081528.51796.gkanis@cems.umn.edu> <20050408203934.GA18490@isilmar.linta.de> <200504081647.30433.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200504081647.30433.gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Philipp Wollermann <phil_wo-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 08, 2005 at 03:47:30PM -0600, Vasileios Gkanis wrote:
> If in the file include/asm-i386/param.h, I change the 
> #ifdef __KERNEL__
> # define HZ  1000  /* Internal kernel timer frequency */
> # define USER_HZ 100  /* .. some user interfaces are in "ticks" */
> # define CLOCKS_PER_SEC  (USER_HZ) /* like times() */
> #endif
> 
> to 
> #ifdef __KERNEL__
> # define HZ  100  /* Internal kernel timer frequency */
> # define USER_HZ 100  /* .. some user interfaces are in "ticks" */
> # define CLOCKS_PER_SEC  (USER_HZ) /* like times() */
> #endif
> 
> will it do the trick or will I make a mess?

I don't know exactly, however IIRC there are some issues if you do only
this.

The latest dynamic tick patch can be found at

http://lkml.org/lkml/2005/4/8/54

but it might still be on the bleeding side of the warm fuzzy feeling of
being on the bleeding edge of kernel development.

Thanks,
	Dominik


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
