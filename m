From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: [RFC] filling in ACPI files in sysfs
Date: Thu, 08 Apr 2004 00:36:21 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081373781.23176.30.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, alex.williamson-VXdhtT5mjnY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Alex,

I patch-ed a 2.6.5 kernel, and boot-ed an IBM T30 Thinkpad Laptop.
It looks nice at first sight, and now I want _Qxx methods in /EC to play
with :)

What I found strange is the following behaviour:
If I boot with my second battery inserted, I have the corresponding
entries for BAT1 in /proc/acpi/battery and /sys/.../EC/BAT1
If I boot without my second battery inserted, and I insert it later on,
I don't have the corresponding BAT1 directory for it in /proc/acpi and
/sys/.../EC/.
And this is true for other acpi devices too.
I think that the problem is that it does not (yet) update the list of
active devices in real time, but uses the list with devices detected at
boot time.

Anyway, this is a good start, and I am waiting for more patches to test.

Thanks,
Paul


>   Seems like it's about time the ACPI sysfs namespace started >doing
>more than looking pretty.  Here's a stab at adding in some basic
>functionality.  I'd like to get some feedback before I start filling in
>the more complicated features.  This has been lightly tested on a
>sampling of HP ia64 boxes.  Does this seem like a reasonable start? 
>Comments and reports from other platforms welcome.  Thanks,




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
