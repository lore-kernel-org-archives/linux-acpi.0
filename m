From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Can't Play avi/mov files after S4 Resume
Date: Mon, 15 Mar 2004 02:22:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040315012247.GC29651@message-id.gmane0305.slipkontur.de>
References: <C386328088ED7F4E9F81AFBABDDF60DA04A925FF@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA04A925FF-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 12, 2004 at 10:25:25AM +0800, Ow Mun Heng wrote:

> Yes.. X11/XFree86
> 
> Diff -Nau /tmp/xvinfo-boot /tmp/xvinfo-resume
> --- /tmp/xvinfo-boot	2004-03-12 09:19:23.119722264 +0800
> +++ /tmp/xvinfo-resume	2004-03-12 09:15:31.000000000 +0800
> @@ -27,19 +27,19 @@
>                client gettable attribute (current value is 1)
>        "XV_BRIGHTNESS" (range -1000 to 1000)
>                client settable attribute
> -              client gettable attribute (current value is 0)
> +              client gettable attribute (current value is -2)
>        "XV_CONTRAST" (range -1000 to 1000)
>                client settable attribute
> -              client gettable attribute (current value is 0)
> +              client gettable attribute (current value is -12)

> So.. Seems to me that everything's OK I guess. Unless the "-2"
> are at fault.

no, probably your player set them, these are user settable attributes.
but maybe the driver is just plain broken. Try restarting X after resume
(although for me this is almost equivalent to rebooting the machine from
a users viewpoint), maybe it helps.
 
> I've tried all drivers I guess. I'm using "Auto" in Xine.

No. I'm not familiar with xine, but it probably detects that xv should
work and uses it. Although it does not work any longer....
Try explicitly selecting "-vo x11" on mplayer or the equivalent on xine,
but this will disable hardware accelerated scaling.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
