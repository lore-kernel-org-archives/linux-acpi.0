From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Fri, 21 Nov 2003 14:21:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031121132141.GN32464@poupinou.org>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com> <20031121101232.GL32464@poupinou.org> <20031121111323.GB18223@luna.mooo.com> <3FBE0E02.3080203@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FBE0E02.3080203-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 21, 2003 at 02:07:14PM +0100, Luca Capello wrote:
> Hello Micha,
> 
> on 11/21/03 12:13, Micha Feigin wrote:
> | like said here, laptopmode is what you want since it holds back dirty
> | buffer flushes which is what you are experiencing. It will fire up the
> | disk on reads though. I attached a script that you can use to enter
> | laptopmode (was actually distributed with laptopmode as far as I could
> | tell when googling for the original patch). I call it in responce to
> | ac events from acpid to get it running when the power is disconnected.
> | Will have to make sure that you get those event though since I had to
> | twik my dsdt for that.
> thx for the script, I was searching for but I couldn't find :-(
> On the other hand, what do I search for in my DSDT? I mean, in which way
> can I know if the 'laptop_mode' is supported on my DSDT?

laptop-mode and ACPI are complete different things...
This work like a charm in my iBook for instance.

> 
> | I could try making such a patch for ext3 if you want.
> Yes, please :-)
> 

If you active the laptop-mode, then commit interval for ext3 will change
to the sysctl buffer_age, so if that one is changed to be 600 (like in
the script), then commit intervall will auto-magically be 10 min.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
