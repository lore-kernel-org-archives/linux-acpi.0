From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: P State manipulation on Compaq Evo N610c
Date: Mon, 22 Mar 2004 10:08:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040322090811.GM28592@poupinou.org>
References: <200403201847.23668.faye@zippysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200403201847.23668.faye-h3p4nEmjOm7by3iVrkZq2A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Faye Pearson <faye-h3p4nEmjOm7by3iVrkZq2A@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 20, 2004 at 06:47:23PM +0000, Faye Pearson wrote:
> In Oct. of last year, I was attempting to get speedstep working on the Compaq 
> Evo N610c.
> 
> marmite speedstep-detect-0.01 # ./speedstep-detect
> dmi_scan: return:
> DMI 2.3 present.
> 31 structures occupying 1210 bytes.
> DMI table at 0x000FD8F0.
> BIOS Vendor: Compaq
> BIOS Version: 68P4F Ver. F.18
> BIOS Release: 12/09/2003
> System Vendor: Compaq
> Product Name: Evo N610c (DJ121A#ABU)
> Version:
> Board Vendor: Compaq
> Board Name: 07F4
> Board Version: KBC Version   .
> Trying Intel's int15 GSIC:
> BIOS support GSIC call:
>         signature: GSIC
>         command port = 0x00b2
>         command =      0x0082
>         event port =   0x000100b3
>         flags =        0x07d00000
> probing chipsets: No supported chipset found.
> 
> lspci says that it is an 82845 Brookdale chipset.
> The southbridge appears to be an 82801CAM (ICH3)
> 

detect-speedstep do work only with 'problematic' chipsets (PIIX4 and the
like), not with chipset that work already.  Try speedstep-ich.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
