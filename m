From: Nickolai Zeldovich <kolya-DPNOqEs/LNQ@public.gmane.org>
Subject: RE: [patch] Fix GDT re-load on ACPI resume
Date: Wed, 12 Jan 2005 17:33:32 -0500 (EST)
Message-ID: <Pine.GSO.4.58L.0501121730150.4652@contents-vnder-pressvre.mit.edu>
References: <16A54BF5D6E14E4D916CE26C9AD305758EF0BA@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305758EF0BA-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Is there any plan to integrate hiroit-s3IJUFpODnp4Eiagz67IpQ@public.gmane.org's patch that copies the
GDT into lower memory into the mainline kernel?    It's been two months
now, and that patch isn't in 2.6.10-rc1 -- not surprisingly, resulting in
the same failure-to-resume-from-S3 problems.

Thanks in advance,

-- kolya

On Tue, 16 Nov 2004, Li, Shaohua wrote:

> >The ACPI resume code currently uses a real-mode 16-bit lgdt instruction
> to
> >reload the GDT.  This only restores the lower 24 bits of the GDT base
> >address.  In recent kernels, the GDT seems to have moved out of the
> lower
> >16 megs, thereby causing the ACPI resume to fail -- an invalid GDT was
> >being loaded.
> >
> >This simple patch adds the 0x66 prefix to lgdt, which forces it to load
> >all 32 bits of the GDT base address, thereby removing any restrictions
> on
> >where the GDT can be placed in memory.  This makes ACPI resume work for
> me
> >on a Thinkpad T40 laptop.
> >
> >-- kolya
> >
> >--- linux-2.6.9/arch/i386/kernel/acpi/wakeup.S	2004/11/15 09:00:34
> 1.1
> >+++ linux-2.6.9/arch/i386/kernel/acpi/wakeup.S	2004/11/15 20:33:27
> >@@ -67,6 +67,8 @@
> > 	movw	$0x0e00 + 'i', %fs:(0x12)
> >
> > 	# need a gdt
> >+	.byte	0x66			# force 32-bit operands in case
> >+					# the GDT is past 16 megabytes
> > 	lgdt	real_save_gdt - wakeup_code
> >
> > 	movl	real_save_cr0 - wakeup_code, %eax
> There is a patch from hiroit-s3IJUFpODnp4Eiagz67IpQ@public.gmane.org to fix the GDT issue. You can try
> it.
> Please cc 'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org' for suspend/resume issue.
>
> Thanks,
> Shaohua
>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
