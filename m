From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: Latest ACPI + cpufreq on a Dell Inspiron 2650
Date: Tue, 03 Dec 2002 09:14:14 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <002401c29acd$e1316880$3746028e@bio.dfo.ca>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B95D@orsmsx107.jf.intel.com>
 <200212030136.30159.chris@chrishowells.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

From: "Chris Howells" <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
>
> * When going into S1 from within X, the screen does not seem to be turned off,
> only much darker -- I can still see the contents of the screen albeit darkly
> when the system is supposedly asleep.

That's very normal on the Dell.  If you ever figure out how to actually turn off
the backlight, please let me know.
>
> * Entering S1 halts the system clock so the time when leaving S1 is the same
> as when it entered S1

As it should.  You have to reset the clock.
>
> * The CPU & hard disk fan seems to continue to run while in S1

Don't know about that...
>
> * The /proc/acpi/ac_adapter, fan, thermal_zone and power_resource directories
> are empty.

I've never had fan & thermal_zones successfully on my i2500, and never even seen
a "power_resource", but ac_adapter works fine.
--
derek



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
