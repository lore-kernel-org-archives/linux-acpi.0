From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.4.21-pre4 acpi 20030122 on Toshiba laptop
Date: Sat, 1 Mar 2003 07:23:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030301062314.GA30201@poup.poupinou.org>
References: <20030227210540.GP21631@freshdot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030227210540.GP21631-ntXksADE/7Pk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 27, 2003 at 10:05:40PM +0100, Sander Smeenk wrote:
> Hi,
> 
> I want to let you know what my experiences are with ACPI on my Toshiba
> Satellite Pro 6000 laptop. I always had trouble with rebooting, and shutting
> down, it just didn't happen.
> 
> With this kernel the machine does shut down properly and reboots
> properly, so that is fixed now. Better not touch it :p
> 
> I tried fixing my DSDT by disassembling it, fixing the warnings that
> turned up with iasl, and putting it back in the kernel with the
> appropriate patches, but it didn't change a thing, so it seems.
> Ofcourse I don't know if I fixed it The Right Way(TM). 

Perhaps a link to your DSDT will be heplfull...

> Okay, next I tried 'sleep modes'. Because I want to be able to suspend
> my laptop. cat /proc/acpi/sleep displays:
> | S0 S3 S4 S4Bios S5
> 
> S0     = Default operation, so that works :p
> S3     = echo: write error: no such device

S3 is not supported in 2.4 series for now.


> S4     = Laptop suspends, wakes up, but after waking up, it hangs
> S4Bios = See S4, exactly the same behaviour

S4 is not supported, then S4 == S4bios for 2.4.

> S5     = Kernel Oops:

Yes, I know.  It is still broken in 2.4, but actually will be disabled.

thank for the report,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
