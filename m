From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 resume and Wake events
Date: Fri, 2 Apr 2004 12:31:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040402103150.GA677@elf.ucw.cz>
References: <EB6B0A91B0F6AC44842492A8F6852CDE11AAB6@fcexmb01.efi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EB6B0A91B0F6AC44842492A8F6852CDE11AAB6-jfDmLf0o5iKyvBr3IBtpkhUaVx6/PbGo@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Manpreet Singh <Manpreet.Singh-IrU4XInhIXM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I am attempting to resume from S3 using a magic packet from an NIC. The NIC
> asserts the PME# and the status bit gets set in the I/O controller, but it
> turns out that the ACPI suspend code in the kernel disables *all* GPEs before
> sleeping and so I can't wake the system up after it goes to sleep.
> 
> Tracing through the code (on the 2.6.4 stock kernel), at one point, the
> function acpi_enter_sleep_state() calls acpi_disable_non_wakeup_gpes() which
> disables all GPEs, even the ones that are potentially the wake-up events like
> the PME_EN bit.

This needs some work. API should be invented to tell the kernel what
GPEs may wake us up.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
