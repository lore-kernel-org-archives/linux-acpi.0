From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Mon, 1 Nov 2004 16:41:28 +0100
Message-ID: <20041101154127.GB1056@elf.ucw.cz>
References: <20041018020816.48673359@localhost.localdomain> <20041018112632.GB4400@openzaurus.ucw.cz> <20041021001331.69c6c965@localhost.localdomain> <20041020225334.GC29863@elf.ucw.cz> <20041101145410.GB12006@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041101145410.GB12006-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Cc: ole.rohne-vJEk5272eHo@public.gmane.org, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> The attached patch provides acpi_sleep=s3_late_bios boot option. This is
> just a trivial wrap-up of Ole's patch. It hooks into pci_default_resume
> (on X86 only and even then only when the flag is given), so you actually
> can resume the video without a framebuffer driver (and if you do have
> one, well, it should do what it takes to handle resume).

Patch looks good to me...

> +	# Fixup 16-bit CS descriptor
> +	movl	%ecx, %edx
> +	movw	%dx, go_real_cseg - wakeup_start + 2 (%eax)
> +	shrl	$16, %edx
> +	movb	%dl, go_real_cseg - wakeup_start + 4 (%eax)
> +	movb	%dh, go_real_cseg - wakeup_start + 7 (%eax)

Uff, this looks pretty ugly. But I guess it is i386 being ugly...

> --- linux.orig/drivers/pci/pci-driver.c	2004-10-26 10:19:42.000000000 +0200
> +++ linux/drivers/pci/pci-driver.c	2004-11-01 01:33:04.000000000 +0100
> @@ -336,6 +336,20 @@
>  	/* if the device was busmaster before the suspend, make it busmaster again */
>  	if (pci_dev->is_busmaster)
>  		pci_set_master(pci_dev);
> +#if	defined(CONFIG_X86) && defined(CONFIG_ACPI_SLEEP)
> +	if (((pci_dev->class ^ (PCI_CLASS_DISPLAY_VGA << 8)) & 0xffff00)==0)

The use of xor here is certainly interesting. Is it possible to say

	pci_dev->class & 0xffff00 == PCI_CLASS_DISPLAY_VGA << 8

?

> +	{
> +		/* This is a no-op, and returns -1, in case s3_bios_late
> +		 * hasn't been specified on the kernel command line
> +		 */
> +		int rc;
> +		rc=acpi_vgapost (pci_dev->bus->number << 8 | pci_dev->devfn);
> +		if (rc==0) {
> +			printk(KERN_INFO "resumed pci graphics adapter %s\n",
> +				pci_name(pci_dev));
> +		}

Please do it without the variable, and use 

	foo = bar(baz, xyzzy);

style of formatting.

> --- linux.orig/include/asm-i386/acpi.h	2004-10-26 10:19:50.000000000 +0200
> +++ linux/include/asm-i386/acpi.h	2004-11-01 02:15:12.000000000 +0100
> @@ -187,6 +187,9 @@
>  /* early initialization routine */
>  extern void acpi_reserve_bootmem(void);
>  
> +/* real mode excursion to post code from vga rom ; must come once pci is up. */
> +extern int acpi_vgapost (unsigned long);
                          ~-- 
                             \ kill this space.

> --- linux.orig/arch/i386/kernel/acpi/sleep_hacks.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux/arch/i386/kernel/acpi/sleep_hacks.h	2004-11-01 02:53:47.000000000 +0100
> @@ -0,0 +1,16 @@
> +#ifndef ACPI_SLEEP_HACKS_H_
> +#define ACPI_SLEEP_HACKS_H_
> +
> +#ifdef	CONFIG_ACPI_SLEEP
> +
> +#define	ACPI_SLEEP_S3_BIOS	1
> +#define	ACPI_SLEEP_S3_MODE	2
> +#define	ACPI_SLEEP_S3_LATE_BIOS	4
> +#define	ACPI_SLEEP_S3_LATE_MODE	8
> +#define	ACPI_SLEEP_S3_LATE_MASK	12
> +#define ACPI_SLEEP_S3_LATE_BITS(X)	(((X)&12)>>2)
> +
> +#endif
> +
> +
> +#endif	/* ACPI_SLEEP_HACKS_H_ */

Does it really deserve its own header file? Hmm and it should probably
be common between x86-64 and i386, as we might need 64-bit version in
future...

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
