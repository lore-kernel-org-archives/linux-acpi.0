From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] 2.6: use scaling_available_freqs in acpi-cpufreq-ioport driver
Date: Wed, 3 Mar 2004 17:22:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040303162255.GK2869@poupinou.org>
References: <20040220083149.GA10215@dominikbrodowski.de> <20040224125628.GA438@elf.ucw.cz> <20040224210040.GA8166@dreamcraft.com.au> <20040224221642.GB9145@elf.ucw.cz> <20040226172823.GJ2869@poupinou.org> <20040226215006.GB397@elf.ucw.cz> <20040301175430.GY2869@poupinou.org> <20040301180325.GA562@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040301180325.GA562-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Tomasz Ciolek <tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 01, 2004 at 07:03:25PM +0100, Pavel Machek wrote:
> 
> As long as people don't want to change rvo, irt, etc, we should be
> fine.

Yes, probably, but in case of powernow-k7 I need to pass specifically
fsb and latency.  And I much prefer to do it atomic.  Also I want to
check that the user do not enter stupid things.  For example, I
requested that frequency being passed even though it's actually only
here in order to check that frequency and FID being OK with something
like
if (frequency != table[vid] * fsb * ...) then fail.
for each entry passed.

> First step in that direction would be to have voltage in milivolts in
> those frequency tables, so that core can print them etc... like this:
> 
> --- clean/include/linux/cpufreq.h	2004-01-09 20:24:26.000000000 +0100
> +++ linux/include/linux/cpufreq.h	2004-03-01 19:02:48.000000000 +0100
> @@ -316,6 +316,7 @@
>  	unsigned int	index;     /* any */
>  	unsigned int	frequency; /* kHz - doesn't need to be in ascending
>  				    * order */
> +	unsigned int	voltage;   /* mV */
>  };

Well, why not?

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
