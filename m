From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: 2.6.12-rc1-mm3
Date: 25 Mar 2005 20:56:58 -0500
Message-ID: <1111802218.19916.59.camel@d845pe>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	 <20050326014327.GB207782@dragonfly.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050326014327.GB207782-MxuHJOjpcnauM61iycY1Zzbuus4N2nEH@public.gmane.org>
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

On Fri, 2005-03-25 at 20:43, Jason Uhlenkott wrote:
> On Fri, Mar 25, 2005 at 12:21:54AM -0800, Andrew Morton wrote:
> >  bk-acpi.patch
> 
> This doesn't build for SGI sn2:
> 
> arch/ia64/kernel/mca.c: In function `ia64_mca_init':
> arch/ia64/kernel/mca.c:1394: error: `ACPI_INTERRUPT_CPEI' undeclared
> (first use in this function)
> arch/ia64/kernel/mca.c:1394: error: (Each undeclared identifier is
> reported only once
> arch/ia64/kernel/mca.c:1394: error: for each function it appears in.)
> make[1]: *** [arch/ia64/kernel/mca.o] Error 1
> make: *** [arch/ia64/kernel] Error 2
> 
> This is because we lost CONFIG_ACPI_BOOT -- it now depends on
> CONFIG_PM, which we don't have (or want) on sn2.  The following fixes
> it, but I'm not sure what the original rationale was.  Len?
> 
> Signed-off-by: Jason Uhlenkott <jasonuhl-sJ/iWh9BUns@public.gmane.org>
> 

Please send me the .config you'd like to build.
I believe that what we want to do is include CONFIG_PM.
Note also that CONFIG_ACPI_BOOT will be going away --
to be replaced simply by CONFIG_ACPI.

thanks,
-Len




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
