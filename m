From: Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
Subject: Re: [BKPATCH] ACPI for 2.6
Date: Sat, 14 Aug 2004 13:56:51 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408141356.51746.jbarnes@engr.sgi.com>
References: <1092466509.5028.248.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TynHBaaPsbMZ9XT"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1092466509.5028.248.camel@dhcppc4>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_TynHBaaPsbMZ9XT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, August 13, 2004 11:55 pm, Len Brown wrote:
> Hi Linus, please do a
>
> 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.8
>
> 	Key fixes for suspend/resume, a couple of common
> 	boot failures, and misc. random fixes.

You'll need this fix for ia64 though.  Linus, please apply.

Define acpi_noirq on ia64 since it's used now in pci_link.c.  All ia64 
machines use ACPI, so we can just define it to 0 like we do for acpi_disabled 
and acpi_pci_disabled.

Signed-off-by: Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>

Thanks,
Jesse

--Boundary-00=_TynHBaaPsbMZ9XT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ia64-acpi-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ia64-acpi-build-fix.patch"

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.8-rc4.orig/include/asm-ia64/acpi.h linux-2.6.8-rc4/include/asm-ia64/acpi.h
--- linux-2.6.8-rc4.orig/include/asm-ia64/acpi.h	2004-08-10 09:01:34.000000000 -0700
+++ linux-2.6.8-rc4/include/asm-ia64/acpi.h	2004-08-10 09:26:39.000000000 -0700
@@ -89,6 +89,7 @@ ia64_acpi_release_global_lock (unsigned 
 	((Acq) = ia64_acpi_release_global_lock((unsigned int *) GLptr))
 
 #define acpi_disabled 0	/* ACPI always enabled on IA64 */
+#define acpi_noirq 0	/* ACPI always enabled on IA64 */
 #define acpi_pci_disabled 0 /* ACPI PCI always enabled on IA64 */
 #define acpi_strict 1	/* no ACPI spec workarounds on IA64 */
 static inline void disable_acpi(void) { }

--Boundary-00=_TynHBaaPsbMZ9XT--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
