From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: S3 broken on a Samsung P30
Date: Fri, 12 Nov 2004 13:51:59 +0100
Message-ID: <1100263919.3523.3.camel@mhcln03>
References: <1099605010.5191.20.camel@mhcln03>
	 <20041110231802.GA1099@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nEyOEAa+RDhp3+9uzF05"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041110231802.GA1099-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-nEyOEAa+RDhp3+9uzF05
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Donnerstag, den 11.11.2004, 00:18 +0100 schrieb Pavel Machek:

> See recent threads of adding beeping to begining of wakeup.S. Does it
> beep for you?

No it doesn't.
I've googled for the beep patch. The one I found is attached as I'm not
sure if it is the right one.

Thanks
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-nEyOEAa+RDhp3+9uzF05
Content-Description: 
Content-Disposition: attachment; filename=wakeup.S-beep.patch
Content-Type: text/x-patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- clean-mm/arch/i386/kernel/acpi/wakeup.S	2004-08-24 09:02:23.000000000 +0200
+++ linux-mm/arch/i386/kernel/acpi/wakeup.S	2004-09-07 21:15:17.000000000 +0200
@@ -11,8 +11,23 @@
 #
 # If physical address of wakeup_code is 0x12345, BIOS should call us with
 # cs = 0x1234, eip = 0x05
-# 
+#
 
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
+	
 ALIGN
 	.align	4096
 ENTRY(wakeup_start)
@@ -20,6 +35,7 @@
 	wakeup_code_start = .
 	.code16
 
+	BEEP
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)

--=-nEyOEAa+RDhp3+9uzF05--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
