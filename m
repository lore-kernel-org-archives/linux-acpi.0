From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: S3 freezes on wake on NC6000 laptop
Date: Tue, 08 Feb 2005 11:11:38 +1100
Message-ID: <1107821497.2756.6.camel@desktop.cunninghams>
References: <4207A416.8030400@colitti.com>
	 <20050207223644.GA1394@elf.ucw.cz>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050207223644.GA1394-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

Suspend2 doesn't touch wakeup.S; he should be able to test without
reversing it if he wants to.

Regards,

Nigel

On Tue, 2005-02-08 at 09:36, Pavel Machek wrote:
> Hi!
> 
> > I am trying to get S3 (suspend to RAM) to work on an HP NC6000 laptop with 
> > no success. The system seems to enter the S3 state correctly, but when I 
> > turn back on it freezes completely.
> > 
> > I tried booting with no modules and no processes loaded (init=/bin/sh) and 
> > with a serial console, but I can't see anything helpful. What I see
> > is this:
> 
> Drop radeonfb, and drop swsusp2 patch. Apply this, and lets see if you
> can hear beep during wakeup.
> 									Pavel 
> 
> --- clean/arch/i386/kernel/acpi/wakeup.S	2005-01-22 21:24:51.000000000 +0100
> +++ linux/arch/i386/kernel/acpi/wakeup.S	2004-12-25 15:51:04.000000000 +0100
> @@ -11,7 +11,22 @@
>  #
>  # If physical address of wakeup_code is 0x12345, BIOS should call us with
>  # cs = 0x1234, eip = 0x05
> -# 
> +#
> +
> +#define BEEP \
> +	inb	$97, %al; 	\
> +	outb	%al, $0x80; 	\
> +	movb	$3, %al; 	\
> +	outb	%al, $97; 	\
> +	outb	%al, $0x80; 	\
> +	movb	$-74, %al; 	\
> +	outb	%al, $67; 	\
> +	outb	%al, $0x80; 	\
> +	movb	$-119, %al; 	\
> +	outb	%al, $66; 	\
> +	outb	%al, $0x80; 	\
> +	movb	$15, %al; 	\
> +	outb	%al, $66;
>  
>  ALIGN
>  	.align	4096
> @@ -20,6 +35,7 @@
>  	wakeup_code_start = .
>  	.code16
>  
> +	BEEP
>   	movw	$0xb800, %ax
>  	movw	%ax,%fs
>  	movw	$0x0e00 + 'L', %fs:(0x10)
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
