From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 broken on a Samsung P30
Date: Fri, 12 Nov 2004 22:16:59 +0100
Message-ID: <20041112211659.GD1252@elf.ucw.cz>
References: <1099605010.5191.20.camel@mhcln03> <20041110231802.GA1099@elf.ucw.cz> <1100263919.3523.3.camel@mhcln03> <20041112160435.GC1858@elf.ucw.cz> <1100283009.3608.2.camel@mhcln03> <20041112195530.GA1123@elf.ucw.cz> <1100292909.3499.3.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1100292909.3499.3.camel@mhcln03>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Okay, oops, do
> > 
> > 1:
> > 	jmp 1b
> > 
> > instead.
> 
> I hope the following is correct:
> 
> [snip]
> ENTRY(wakeup_start)
> wakeup_code:
> 	wakeup_code_start = .
> 	.code16
> 
> 	BEEP
> 1:	
> 	jmp	1b
> 	
>  	movw	$0xb800, %ax
> 	movw	%ax,%fs
> [/snip]

Yes, looks ok.

> Tried again with 2.6.10-rc1-bk22 (latest ACPI patches IIRC) and the
> patched wakeup.S
> Still no beep :(

Too bad, I do not know how to debug this further. It is possible that
those patches are not yet merged into mainline, I'm not sure, it was
something like "correcting wakeup address".

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
