From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: S3 broken on a Samsung P30
Date: Fri, 12 Nov 2004 21:55:09 +0100
Message-ID: <1100292909.3499.3.camel@mhcln03>
References: <1099605010.5191.20.camel@mhcln03>
	 <20041110231802.GA1099@elf.ucw.cz> <1100263919.3523.3.camel@mhcln03>
	 <20041112160435.GC1858@elf.ucw.cz> <1100283009.3608.2.camel@mhcln03>
	 <20041112195530.GA1123@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041112195530.GA1123-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

Hello Pavel,

Am Freitag, den 12.11.2004, 20:55 +0100 schrieb Pavel Machek:

[...]

> 
> Okay, oops, do
> 
> 1:
> 	jmp 1b
> 
> instead.

I hope the following is correct:

[snip]
ENTRY(wakeup_start)
wakeup_code:
	wakeup_code_start = .
	.code16

	BEEP
1:	
	jmp	1b
	
 	movw	$0xb800, %ax
	movw	%ax,%fs
[/snip]

Tried again with 2.6.10-rc1-bk22 (latest ACPI patches IIRC) and the
patched wakeup.S
Still no beep :(

-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
