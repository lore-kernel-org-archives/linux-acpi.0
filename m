From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: s3_late_bios
Date: Mon, 8 Nov 2004 22:35:58 +0100
Message-ID: <20041108213558.GB4607@elf.ucw.cz>
References: <20041108144947.GA31267@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041108144947.GA31267-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
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
Cc: ole.rohne-vJEk5272eHo@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Sorry I've been off for a week. Here is the version of the s3_late_bios
> patch with the segment info coded in C.
> 
> If somebody comes up with an attempt at resuming the video from the early
> real mode phase by calling the pci bios, I'm all for testing it.

It looks good to me...
								Pavel

> --- linux.orig/Documentation/power/video.txt	2004-08-14 23:10:42.000000000 +0200
> +++ linux/Documentation/power/video.txt	2004-11-01 14:29:51.000000000 +0100
> @@ -26,12 +26,17 @@
>    point, but it happens to work on some machines. Use
>    acpi_sleep=s3_bios (Athlon64 desktop system)
>  
> +* systems where an excursion into real mode _after_ the pci subsystem
> +  wakes up is sufficient. It has better chances of working than s3_bios.
> +  Use acpi_sleep=s3_late_bios (Dell D600, Fujitsu P2120 ; both run radeon
> +  boards, but not all radeons seem to like this).
> +
>  * radeon systems, where X can soft-boot your video card. You'll need
>    patched X, and plain text console (no vesafb or radeonfb), see
>    http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. (Acer TM 800)
>  
>  Now, if you pass acpi_sleep=something, and it does not work with your
> -bios, you'll get hard crash during resume. Be carefull.
> +bios, you'll get hard crash during resume. Be careful.
>  
>  You may have system where none of above works. At that point you
>  either invent another ugly hack that works, or write proper driver for
> --- linux.orig/arch/i386/kernel/acpi/sleep.c	2004-10-31 10:55:40.000000000 +0100
> +++ linux/arch/i386/kernel/acpi/sleep.c	2004-11-06 23:57:44.000000000 +0100
> @@ -7,6 +7,8 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/bootmem.h>
> +#include <asm/processor.h>
> +#include <asm/desc.h>
>  #include <asm/smp.h>
>  
>  
> @@ -63,6 +65,86 @@
>  	zap_low_mappings();
>  }
>  
> +/*
> + * acpi_vgapost - trip into real mode in order to post the vga card.
> + *
> + * slot is typically pdev->bus->number << 8 | pdev->devfn
> + * where pdev is a struct pci_dev *
> + */
> +extern struct Xgt_desc_struct go_real_gdtr;
> +extern struct Xgt_desc_struct go_real_idtr;
> +extern u16 go_real_jmp_seg;
> +
> +extern void do_vgapost_lowlevel (void);
> +
> +int acpi_vgapost (unsigned long slot)
> +{
> +	unsigned long flags;
> +	unsigned long saved_video_flags;
> +	u32 low_mapping;
> +	struct user_desc info;
> +	struct desc_struct gdt[3];
> +
> +	if ((acpi_video_flags & ACPI_SLEEP_S3_LATE_MASK) == 0)
> +		return -1;
> +	if (num_online_cpus() != 1)	/* do you dare ? */
> +		return -EPERM;
> +
> +	/* Load the required info for the jump to real mode. The code in
> +	 * here could maybe go to acpi_reserve_bootmem instead, so that
> +	 * it's done once and for all.
> +	 */
> +
> +	low_mapping = virt_to_phys((void*)acpi_wakeup_address);
> +		
> +	go_real_jmp_seg = low_mapping >> 4;
> +
> +	/* ldt and gdt descriptors are the same, hence the ldt macros.
> +	 * however, we want the privilege flag be set to 0 (reboot is
> +	 * waiting at the corner otherwise). */
> +	memset(gdt,0,sizeof(gdt));
> +
> +	memset(&info,0,sizeof(info));
> +	info.limit = 0xffff;
> +	info.base_addr = low_mapping;
> +	info.seg_32bit = 0;
> +	
> +	info.contents = MODIFY_LDT_CONTENTS_CODE;
> +	gdt[1].a = LDT_entry_a(&info);
> +	gdt[1].b = LDT_entry_b(&info) & ~(0x6000);	/* clear dpl */
> +
> +	info.contents = MODIFY_LDT_CONTENTS_DATA;
> +	gdt[2].a = LDT_entry_a(&info);
> +	gdt[2].b = LDT_entry_b(&info) & ~(0x6000);	/* clear dpl */
> +
> +	go_real_gdtr.size = sizeof(gdt)-1;
> +	go_real_gdtr.address = (u32) &gdt;
> +	go_real_idtr.size = (1<<10)-1;
> +	go_real_idtr.address = 0;
> +
> +	/* Copy the wakeup code again (this time with the _late_ flags).  */
> +
> +	saved_video_flags = acpi_video_flags;
> +	acpi_video_flags = (slot & 0xffff) << 16 |
> +		ACPI_SLEEP_S3_LATE_BITS(acpi_video_flags);
> +	
> +	acpi_save_state_mem();
> +
> +	/* Tunnel thru real mode, call the wakeup code, and return. We're
> +	 * typically called here from pci_default_resume, hence w/ irqs
> +	 * on. */
> +	local_irq_save(flags);
> +	do_vgapost_lowlevel();
> +	local_irq_restore(flags);
> +
> +	/* Restore mapping etc */
> +	acpi_restore_state_mem();
> +
> +	/* restore normal acpi_video_flags for next resume */
> +	acpi_video_flags = saved_video_flags;
> +	return 0;
> +}
> +
>  /**
>   * acpi_reserve_bootmem - do _very_ early ACPI initialisation
>   *
> @@ -87,9 +169,17 @@
>  {
>  	while ((str != NULL) && (*str != '\0')) {
>  		if (strncmp(str, "s3_bios", 7) == 0)
> -			acpi_video_flags = 1;
> +			acpi_video_flags = ACPI_SLEEP_S3_BIOS;
>  		if (strncmp(str, "s3_mode", 7) == 0)
> -			acpi_video_flags |= 2;
> +			acpi_video_flags |= ACPI_SLEEP_S3_MODE;
> +		if (strncmp(str, "s3_late_bios", 12) == 0)
> +			acpi_video_flags |= ACPI_SLEEP_S3_LATE_BIOS;
> +		/* This last one is there for ``symmetry'', but frankly I
> +		 * don't think it's any useful. Well, for vesafb lovers maybe.
> +		 * Don't forget to celebrate if it works for you (???).
> +		 */
> +		if (strncmp(str, "s3_late_mode", 12) == 0)
> +			acpi_video_flags |= ACPI_SLEEP_S3_LATE_MODE;
>  		str = strchr(str, ',');
>  		if (str != NULL)
>  			str += strspn(str, ", \t");
> --- linux.orig/arch/i386/kernel/acpi/wakeup.S	2004-10-31 10:55:40.000000000 +0100
> +++ linux/arch/i386/kernel/acpi/wakeup.S	2004-11-06 23:54:30.000000000 +0100
> @@ -2,6 +2,7 @@
>  #include <linux/linkage.h>
>  #include <asm/segment.h>
>  #include <asm/page.h>
> +#include <asm/acpi.h>
>  
>  #
>  # wakeup_code runs in real mode, and at unknown address (determined at run-time).
> @@ -41,15 +42,16 @@
>  	cmpl	$0x12345678, %eax
>  	jne	bogus_real_magic
>  
> -	testl	$1, video_flags - wakeup_code
> +	testl	$ACPI_SLEEP_S3_BIOS, video_flags - wakeup_code
>  	jz	1f
> +	movw	video_flags - wakeup_code + 2, %ax
>  	lcall   $0xc000,$3
>  	movw	%cs, %ax
>  	movw	%ax, %ds					# Bios might have played with that
>  	movw	%ax, %ss
>  1:
>  
> -	testl	$2, video_flags - wakeup_code
> +	testl	$ACPI_SLEEP_S3_MODE, video_flags - wakeup_code
>  	jz	1f
>  	mov	video_mode - wakeup_code, %ax
>  	call	mode_set
> @@ -159,6 +161,27 @@
>  
>  _setbad: jmp setbad
>  
> +#
> +#	Real mode switch - verbatim from reboot.c
> +#
> +go_real:
> +	movl	%cr0, %eax
> +	andl	$0x00000011, %eax
> +	orl	$0x60000000, %eax
> +	movl	%eax, %cr0
> +	movl	%eax, %cr3
> +	movl	%cr0, %ebx
> +	andl	$0x60000000, %ebx
> +	jz	1f
> +	wbinvd
> +1:	andb	$0x10, %al
> +	movl	%eax, %cr0
> +	.byte	0xea
> +	.word	0x0000
> +.globl go_real_jmp_seg
> +go_real_jmp_seg:
> +	.word	0x0000
> +
>  	.code32
>  	ALIGN
>  
> @@ -244,6 +267,7 @@
>  ENTRY(saved_magic)	.long	0
>  ENTRY(saved_eip)	.long	0
>  
> +.text
>  save_registers:
>  	leal	4(%esp), %eax
>  	movl	%eax, saved_context_esp
> @@ -284,6 +308,42 @@
>  	call acpi_enter_sleep_state_s4bios
>  	ret
>  
> +ENTRY(do_vgapost_lowlevel)
> +	# Save state and registers
> +	call	save_processor_state
> +	call	save_registers
> +	# Reload page table with low mapping
> +	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
> +	movl	%eax, %cr3
> +	# Load IDTR and GDTR for real mode
> +	lidt	go_real_idtr
> +	lgdt	go_real_gdtr
> +	# Load DS & al ; 0x10 = third segment desc. in gdt (data segment)
> +	movl	$0x0010, %eax
> +	movl	%eax, %ss
> +	movl	%eax, %ds
> +	movl	%eax, %es
> +	movl	%eax, %fs
> +	movl	%eax, %gs
> +	# Load CS ; 0x08 = second segment desc. in gdt (code segment)
> +	ljmpl	$0x0008, $(go_real - wakeup_start)
> +	# returns occurs from ret_point in do_suspend_lowlevel. cpu
> +	# state and registers will be restored from there, and we'll
> +	# eventually return to acpi_vgapost where we came from.
> +	
> +       .align  8
> +       .word   0
> +.globl go_real_gdtr
> +go_real_gdtr:
> +       .word   0
> +       .long   0
> +
> +       .word   0
> +.globl go_real_idtr
> +go_real_idtr:
> +       .word   0
> +       .long   0
> +
>  ALIGN
>  # saved registers
>  saved_gdt:	.long	0,0
> --- linux.orig/drivers/pci/pci-driver.c	2004-10-26 10:19:42.000000000 +0200
> +++ linux/drivers/pci/pci-driver.c	2004-11-01 19:14:20.000000000 +0100
> @@ -336,6 +336,19 @@
>  	/* if the device was busmaster before the suspend, make it busmaster again */
>  	if (pci_dev->is_busmaster)
>  		pci_set_master(pci_dev);
> +#if	defined(CONFIG_X86) && defined(CONFIG_ACPI_SLEEP)
> +	if ((pci_dev->class & 0xffff00) ==  (PCI_CLASS_DISPLAY_VGA << 8)
> +		&& (pci_dev->dev.power_state != 4))
> +	{
> +		/* This is a no-op, and returns -1, in case s3_bios_late
> +		 * hasn't been specified on the kernel command line
> +		 */
> +		if (!acpi_vgapost(pci_dev->bus->number << 8 | pci_dev->devfn)) {
> +			printk(KERN_INFO "resumed pci graphics adapter %s\n",
> +				pci_name(pci_dev));
> +		}
> +	}
> +#endif
>  }
>  
>  static int pci_device_resume(struct device * dev)
> --- linux.orig/include/asm-i386/acpi.h	2004-10-26 10:19:50.000000000 +0200
> +++ linux/include/asm-i386/acpi.h	2004-11-01 19:31:28.000000000 +0100
> @@ -27,6 +27,7 @@
>  #define _ASM_ACPI_H
>  
>  #ifdef __KERNEL__
> +#ifndef __ASSEMBLY__
>  
>  #include <asm/system.h>		/* defines cmpxchg */
>  
> @@ -187,10 +188,26 @@
>  /* early initialization routine */
>  extern void acpi_reserve_bootmem(void);
>  
> +/* real mode excursion to post code from vga rom ; must come once pci is up. */
> +extern int acpi_vgapost(unsigned long);
> +
>  #endif /*CONFIG_ACPI_SLEEP*/
>  
>  extern u8 x86_acpiid_to_apicid[];
>  
> +#endif /*__ASSEMBLY__*/
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
> +#endif	/*CONFIG_ACPI_SLEEP*/
> +
>  #endif /*__KERNEL__*/
>  
>  #endif /*_ASM_ACPI_H*/

> --- linux.orig/drivers/video/aty/radeon_pm.c	2004-10-31 10:55:40.000000000 +0100
> +++ linux/drivers/video/aty/radeon_pm.c	2004-11-01 19:32:53.000000000 +0100
> @@ -909,6 +909,12 @@
>  	if (pdev->dev.power_state == 0)
>  		return 0;
>  
> +	pci_restore_state(pdev, pdev->saved_config_space);
> +
> +	/* Only effective if enabled via acpi_sleep=s3_bios_late */
> +	if (pdev->dev.power_state != 4)
> +		acpi_vgapost(pdev->bus->number << 8 | pdev->devfn);
> +
>  	acquire_console_sem();
>  
>  	/* Wakeup chip */

> --- linux.orig/arch/x86_64/kernel/acpi/sleep.c	2004-08-14 23:10:21.000000000 +0200
> +++ linux/arch/x86_64/kernel/acpi/sleep.c	2004-11-01 19:30:44.000000000 +0100
> @@ -120,9 +120,18 @@
>  {
>  	while ((str != NULL) && (*str != '\0')) {
>  		if (strncmp(str, "s3_bios", 7) == 0)
> -			acpi_video_flags = 1;
> +			acpi_video_flags = ACPI_SLEEP_S3_BIOS;
>  		if (strncmp(str, "s3_mode", 7) == 0)
> -			acpi_video_flags |= 2;
> +			acpi_video_flags |= ACPI_SLEEP_S3_MODE;
> +#if 0
> +		/* These could be as useful as for x86, but it's totally
> +		 * untested.
> +		 */
> +		if (strncmp(str, "s3_late_bios", 12) == 0)
> +			acpi_video_flags |= ACPI_SLEEP_S3_LATE_BIOS;
> +		if (strncmp(str, "s3_late_mode", 12) == 0)
> +			acpi_video_flags |= ACPI_SLEEP_S3_LATE_MODE;
> +#endif
>  		str = strchr(str, ',');
>  		if (str != NULL)
>  			str += strspn(str, ", \t");
> --- linux.orig/arch/x86_64/kernel/acpi/wakeup.S	2004-02-18 04:58:43.000000000 +0100
> +++ linux/arch/x86_64/kernel/acpi/wakeup.S	2004-11-01 19:28:47.000000000 +0100
> @@ -3,6 +3,7 @@
>  #include <asm/segment.h>
>  #include <asm/page.h>
>  #include <asm/msr.h>
> +#include <asm/acpi.h>
>  
>  # Copyright 2003 Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, distribute under GPLv2
>  #
> @@ -41,7 +42,7 @@
>  	cmpl	$0x12345678, %eax
>  	jne	bogus_real_magic
>  
> -	testl	$1, video_flags - wakeup_code
> +	testl	$ACPI_SLEEP_S3_BIOS, video_flags - wakeup_code
>  	jz	1f
>  	lcall   $0xc000,$3
>  	movw	%cs, %ax
> @@ -49,7 +50,7 @@
>  	movw	%ax, %ss
>  1:
>  
> -	testl	$2, video_flags - wakeup_code
> +	testl	$ACPI_SLEEP_S3_MODE, video_flags - wakeup_code
>  	jz	1f
>  	mov	video_mode - wakeup_code, %ax
>  	call	mode_seta
> --- linux.orig/include/asm-x86_64/acpi.h	2004-10-26 10:19:51.000000000 +0200
> +++ linux/include/asm-x86_64/acpi.h	2004-11-01 19:27:54.000000000 +0100
> @@ -27,6 +27,7 @@
>  #define _ASM_ACPI_H
>  
>  #ifdef __KERNEL__
> +#ifndef __ASSEMBLY__
>  
>  #define COMPILER_DEPENDENT_INT64   long long
>  #define COMPILER_DEPENDENT_UINT64  unsigned long long
> @@ -166,6 +167,19 @@
>  
>  extern u8 x86_acpiid_to_apicid[];
>  
> +#endif /*__ASSEMBLY__*/
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
> +#endif /*__ASSEMBLY__*/
> +
>  #endif /*__KERNEL__*/
>  
>  #endif /*_ASM_ACPI_H*/


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
