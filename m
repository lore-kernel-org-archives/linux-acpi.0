From: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Subject: Re: [Solved] Re: power-off (Acer TM632)
Date: Mon, 19 Jul 2004 13:59:04 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040719175904.GC2690@smeagol>
References: <20040531213726.GA3298@zimen.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040531213726.GA3298-VaXaUECoPuY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mizu <michal-VaXaUECoPuY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 31, 2004 at 11:37:26PM +0200, mizu wrote:
>   I guess, Problem was in "Enhanced RTC driver". If i have this driver
>   inside a kernel (or like module), my laptop will never poweroff().
>   last message was like this:
>   		...
> 		call_power_off()   
> 		...HANG...
>   (also i have inserted HPET timer inside kernel, not like module)
> 
>   Is this some unresolved dependency with RTC ?
>   Can i have both timers ? (RTC, HPET )

Here is my update for the Acer TravelMate 634.

I have the following set (or rather _NOT_ set) in my kernel and I can now 
power off correctly:
	# CONFIG_HPET_EMULATE_RTC is not set
	# CONFIG_RTC is not set
	# CONFIG_GEN_RTC is not set

Also. I had been having problems with my computer randomly freezing. I
thought this was a problem with ACPI, or perhaps an old BIOS, however it
is not.

When I upgraded to the 2.6 kernel I did not have the right drivers
installed for my touch pad. It was half installed and as a result it 
was causing all kinds of problems. I now have the Synaptics drivers 
properly installed and everything (seems to be) working again. A _huge_ 
thank you to Hartwig Felger for helping me to track this problem down!

emma

-- 
Emma Jane Hogbin
[[ 416 417 2868 ][ www.xtrinsic.com ]]


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
