From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Unable to turn cooling device on - Asus M3N - test9bk4
Date: Sat, 1 Nov 2003 22:52:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031101215223.GB20858@hell.org.pl>
References: <20031101201812.GA19277@austinchronicle.com> <20031101203319.GA19334@austinchronicle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031101203319.GA19334-lfYnT2qr6k+7/ODoCphcOEEOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lindsey Simon <lsimon-kAMMLXQ8Af9Wk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Lindsey Simon:
> You'd think I might've checked that the fan module was insmodded, oh
> well, sorry bout that.
> 
> Anyway, I get these errors with it insmodded:
> 
>      osl-0892 [454] os_wait_semaphore     : Failed to acquire semaphore[cf73e580|1|0], AE_TIME
>      osl-0892 [449] os_wait_semaphore     : Failed to acquire semaphore[cf73e580|1|0], AE_TIME
> 
> Thanks for your help! My laptop fan used to constantly be on, which sucked. Now it never comes on. I guess we should be careful what we wish for :)
> -l
> 

Those messages are, generally, not really important. ASUS doesn't
apparently care that much about the ACPI spec and the fan device on most
ASUS laptops (there are exceptions) cannot be controlled in the way the
spec says it should. In general, the fan state shown in
/proc/acpi/fan/*/state should not differ from the real state, but it's
impossible to change it using that file -- it is controlled internally by a
longish ACPI method run at every thermal GPE.

What you're seeing is the OS-specific subsytem kicking in (mostly at boot,
unless you have thermal_zone/*/polling_frequency set) when it sees a
discrepancy between the actual system temperature and the desired fan state
(indicated by the thermal trip point). For example, the L3C's fan has its
trip point at 40 C. Upon a cold boot, it may happen that the temperature,
being initially below the active thermal trip point, hits that trip point.
If the in-kernel ACPI code notices that before the actual thermal GPE is
issued, the SLMT method is run and the fan powered on, it will try to power
the fan on by itself, using the standard ACPI methods. This, as said above,
will not succeed, hence the error message.

You have, however, a more serious problem if the fan is not really spinning
at all. You'd need to verify that using a wide range of temperatures,
though.

FYI: switching cooling_mode back and forth from active to passive may cause
the fan to adjust its speed. Resuming from S1 stand-by may also help.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
