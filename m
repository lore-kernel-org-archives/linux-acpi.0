From: Antonio Distante <antonio.distante-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: presario 2500 hangs on resume s3
Date: Mon, 22 Aug 2005 19:02:08 +0200
Message-ID: <1124730128.10429.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Notebook:      Compaq Presario 2532EA
Graphic card:  ATI igp 345m

My laptop goes into S3 well but hangs on resume. I can hear cdrom spin up,
but nothing more. The screen is off, I can't login with ssh and sometimes the
fan starts up as in high load. I tried alla suggestion from
Documentation/power/video.txt without luck, I think the problem is not video
card. Searching in acpi-devel mailinglist's archive I found this 
Pavel Machek's patch that should play a beep on resume:

 --- clean/arch/i386/kernel/acpi/wakeup.S	2005-01-22 21:24:51.000000000 +0100
 +++ linux/arch/i386/kernel/acpi/wakeup.S	2004-12-25 15:51:04.000000000 +0100
 @@ -11,7 +11,22 @@
  #
  # If physical address of wakeup_code is 0x12345, BIOS should call us with
  # cs = 0x1234, eip = 0x05
 -# 
 +#
 +
 +#define BEEP \
 +	inb	$97, %al; 	\
 +	outb	%al, $0x80; 	\
 +	movb	$3, %al; 	\
 +	outb	%al, $97; 	\
 +	outb	%al, $0x80; 	\
 +	movb	$-74, %al; 	\
 +	outb	%al, $67; 	\
 +	outb	%al, $0x80; 	\
 +	movb	$-119, %al; 	\
 +	outb	%al, $66; 	\
 +	outb	%al, $0x80; 	\
 +	movb	$15, %al; 	\
 +	outb	%al, $66;
  
  ALIGN
  	.align	4096
 @@ -20,6 +35,7 @@
  	wakeup_code_start = .
  	.code16
  
 +	BEEP
   	movw	$0xb800, %ax
  	movw	%ax,%fs
  	movw	$0x0e00 + "L", %fs:(0x10)

I applied it to a 2.6.13-rc5 vanilla kernel and build it without framebuffer
support. I booted the new kernel with "init=/bin/sh" and then tried to S3. On
resume system hangs and I can't hear no beep. I hope this helps. Just ask if you
need some other informations.
Thanks,
Antonio



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
