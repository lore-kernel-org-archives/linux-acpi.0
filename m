From: Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
Subject: Re: Re: 2.6.12-rc1-mm3
Date: Fri, 25 Mar 2005 19:40:24 -0800
Message-ID: <200503251940.24644.jbarnes@sgi.com>
References: <20050325002154.335c6b0b.akpm@osdl.org> <1111803861.19920.91.camel@d845pe> <20050326025704.GE207782@dragonfly.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_omNRCZhZeucUSzt"
In-Reply-To: <20050326025704.GE207782-MxuHJOjpcnauM61iycY1Zzbuus4N2nEH@public.gmane.org>
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
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Luck-S9ox3Mig+MlTNBMFyi6HDFaTQe2KTcn/@public.gmane.org, Tony <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_omNRCZhZeucUSzt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, March 25, 2005 6:57 pm, Jason Uhlenkott wrote:
> On Fri, Mar 25, 2005 at 09:24:21PM -0500, Len Brown wrote:
> > What bad things happen if you define CONFIG_PM on SN2?
>
> None, other than slightly enlarging the kernel with some
> suspend/resume stuff we don't care about.  It's always been
> unavailable for SN2 builds:
>
> depends on IA64_GENERIC || IA64_DIG || IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB
>
> but there doesn't appear to be any particular reason for that other
> than us not needing it (and in fact SN2 systems can run IA64_GENERIC
> kernels with CONFIG_PM enabled without incident).
>
> > Re: CONFIG_ACPI_BOOT
> > I've got a patch that makes it go away -- this looks like
> > a good reason for me to dust it off...  Looks like
> > arch/ia64/Kconfig defines ACPI and then pulls in drivers/acpi/Kconfig,
> > which it should not do - it should look like i386/Kconfig...

Yeah, I noticed that too.  If you've got a patch to clean it up, we should go 
ahead and get it sent off to Tony.

I sent this to linux-ia64 the other day to address these issues.

Jesse

--Boundary-00=_omNRCZhZeucUSzt
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ia64-kconfig-pm-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ia64-kconfig-pm-fix.patch"

===== arch/ia64/Kconfig 1.85 vs edited =====
--- 1.85/arch/ia64/Kconfig	2005-01-28 15:32:25 -08:00
+++ edited/arch/ia64/Kconfig	2005-03-21 09:38:29 -08:00
@@ -328,7 +328,7 @@
 
 config PM
 	bool "Power Management support"
-	depends on IA64_GENERIC || IA64_DIG || IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB
+	depends on !IA64_HP_SIM
 	default y
 	help
 	  "Power Management" means that parts of your computer are shut

--Boundary-00=_omNRCZhZeucUSzt--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
