From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Vaio PGC-FXA47 Troubles
Date: Thu, 22 Aug 2002 12:44:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020822104409.GA24939@poup.poupinou.org>
References: <200208182302.01068.andre@masella.dynodns.net> <200208191052.55710.jbr.1@gmx.net> <200208211258.05198.andre@masella.dynodns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200208211258.05198.andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Andre Masella <andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 21, 2002 at 12:58:05PM -0400, Andre Masella wrote:
...
>  Linux version 2.4.18 (root-8G9VKVXhOGCR/P4XRbzFoNRsSGLKypYs8uQkFQZpldM@public.gmane.org) (gcc version 2.95.3 
> 20010315 (release)) #5 Wed Aug 21 14:49:05 _TIMEZONE_ 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000c0000 - 00000000000d4000 (reserved)
>  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
>  BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
>  BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
>  BIOS-e820: 000000000ff00000 - 0000000010000000 (usable)
>  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
> ACPI: have wakeup address 0xc0001000
> On node 0 totalpages: 65536
> zone(0): 4096 pages.
> zone(1): 61440 pages.
> zone(2): 0 pages.
> ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7710
> ACPI: RSDT (v001 SONY   K5       01540.00000) @ 0x0fef9a51
> ACPI: FADT (v001 SONY   K5       01540.00000) @ 0x0fefee4c
> ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0fefeec0
> ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x0fefeee8
> Kernel command line: ro vga=0x318 root=/dev/hda1 mem=262144K
                                                   ^^^^^^^^^^^

Try to decrease this kernel argument.  Something like mem=254M should
be OK.

Anyway, you don't need to pass a mem argument at all, but if you use
grub, this boot loader can add it  automagically, but sometimes grub
is wrong.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
