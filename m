From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: 2.6.12-rc1-mm3
Date: 25 Mar 2005 21:24:21 -0500
Message-ID: <1111803861.19920.91.camel@d845pe>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	 <20050326014327.GB207782@dragonfly.engr.sgi.com>
	 <1111802218.19916.59.camel@d845pe>
	 <20050326020212.GC207782@dragonfly.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050326020212.GC207782-MxuHJOjpcnauM61iycY1Zzbuus4N2nEH@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jason Uhlenkott <jasonuhl-sJ/iWh9BUns@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-03-25 at 21:02, Jason Uhlenkott wrote:
> On Fri, Mar 25, 2005 at 08:56:58PM -0500, Len Brown wrote:
> > Please send me the .config you'd like to build.
> 
> arch/ia64/configs/sn2_defconfig


> > I believe that what we want to do is include CONFIG_PM.
> 
> At first glance, it looks like that will enable suspend/resume
> functionality (which I don't think we want on SGI sn2) for a bunch of
> drivers.

What bad things happen if you define CONFIG_PM on SN2?

Re: CONFIG_ACPI_BOOT
I've got a patch that makes it go away -- this looks like
a good reason for me to dust it off...  Looks like
arch/ia64/Kconfig defines ACPI and then pulls in drivers/acpi/Kconfig,
which it should not do - it should look like i386/Kconfig...

-Len



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
