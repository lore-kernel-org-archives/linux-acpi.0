From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Zeroed field in /proc/..../CPU/performance
Date: Fri, 22 Aug 2003 15:43:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030822134327.GD19292@poupinou.org>
References: <3F45DB5A.2040001@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F45DB5A.2040001-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 22, 2003 at 10:59:06AM +0200, Gerfried Maier wrote:
> /Dear acpi-list,
> 
> Im running kernel 2.4.21 with acpi-20030619 on my Acer Travelmate.
> Almost everything works quite fine but when looking at 
> /proc/acpi/processor/CPU0/performance the fields which should 
> indicate/display power consumption information are zero:
> 
> cat /proc/acpi/processor/CPU0/performance
> //state count:             2
> //active state:            P0
> //states:
> //   *P0:                  1800 MHz, 0 mW, 250 uS
> //    P1:                  1200 MHz, 0 mW, 250 uS

Those informations are retrieved from BIOS.  Then complaint
to acer.  Note that you can override your DSDT for this purpose (since
those values are publicaly available).  The 250 uS is wrong, btw.  It
should be 100.

> The CPU is an Intel P4-mobile, 1.8G
> The zeros shown are not specific to this version of acpi, the zeros are 
> there since the first time I tried out the acpi-patch somewhen in autumn 
> 2002, but
> I did not worry about them...
> 
> Do these zeros have any effect or are they just for (user-) information?

AFAIK, nobody have done work to use those values, only the frequency one
are used (but under 2.6, not yet in 2.4).

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
