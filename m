From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Strange speedstep-related code in some DSDT
Date: Tue, 8 Nov 2005 10:55:03 +0100
Message-ID: <20051108095503.GE24086@poupinou.org>
References: <20051102140113.4B8E510334@paperstreet.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051102140113.4B8E510334-ikQ2XB4hBiN4bLtxfhijqcrri8PcjVMM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Colin Leroy <colin-5s/l0yV9g/OsTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 02, 2005 at 03:00:10PM +0100, Colin Leroy wrote:
> Hi,
> 
> After I upgraded the BIOS on an Asus M6B600C laptop, I found it to be
> stuck at 600MHz. After investigating for a while using debug.cpufreq=3,
> I found out that the DSDT looked strange, and after I fixed it, cpufreq
> worked again.
> 
> The things I had to fix were mainly:
> -            Name (APCT, Package (0x02)
> +            Name (_PCT, Package (0x02)
> 
> and
> -            Name (NPSS, 0x00)
> -            Name (APSS, Package (0x0A)
> +            Name (NPSS, 0x05)
> +            Name (_PSS, Package (0x0A)
> 
> I am wondering whether such objects should be recognized, or is it
> Asus' fault? I read somewhere that they ship a (windows-based)
> proprietary speed controller software for their laptops, so they
> probably don't care about specs in this regard.
> 
> Do you think a patch would be ok to handle these in
> processor_perflib.c? 
> 

I'll suspect more that after upgrading your bios you forgot to enable
or disable speedstep stuff based upon a bios option...

DSDT is likely generated on POST and renaming _PST is a cheap way
to disable speedstep if the processor is forced to the lowest
frequency in the BIOS.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
