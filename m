From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: acpi-thermal: fix confusing define
Date: 20 Oct 2004 17:13:20 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098306800.26603.4347.camel@d845pe>
References: <20041020181221.GA25015@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041020181221.GA25015-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Rusty trivial patch monkey Russell <trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Wed, 2004-10-20 at 14:12, Pavel Machek wrote:
> Hi!
> 
> We have PASSIVE, ACTIVE and CRT cooling policies... Ouch, the last one
> should probably be called CRITICAL otherwise everyone thinks
> "TV?". This patch fixes it, please apply,
>                                                                 Pavel
> 
> --- foo/drivers/acpi/thermal.c  9 Oct 2004 04:09:18 -0000       1.27
> +++ foo/drivers/acpi/thermal.c  20 Oct 2004 17:53:41 -0000
> @@ -60,8 +60,8 @@
>  #define ACPI_THERMAL_NOTIFY_HOT                0xF1
>  #define ACPI_THERMAL_MODE_ACTIVE       0x00
>  #define ACPI_THERMAL_MODE_PASSIVE      0x01
> -#define ACPI_THERMAL_MODE_CRT          0xff
> +#define ACPI_THERMAL_MODE_CRITICAL             0xff
>  #define ACPI_THERMAL_PATH_POWEROFF     "/sbin/poweroff"
> 
>  #define ACPI_THERMAL_MAX_ACTIVE        10
> 
> @@ -953,7 +964,7 @@
>                 seq_puts(seq, "<setting not supported>\n");
>         }
> 
> -       if ( tz->cooling_mode == ACPI_THERMAL_MODE_CRT )
> +       if ( tz->cooling_mode == ACPI_THERMAL_MODE_CRITICAL )
>                 seq_printf(seq, "cooling mode:  critical\n");
>         else
>                 seq_printf(seq, "cooling mode:  %s\n",
> @@ -1262,7 +1276,7 @@
>                         tz->cooling_mode = ACPI_THERMAL_MODE_ACTIVE;
>                 } else {
>                         /* _ACx and _PSV are optional, but _CRT is
> required */
> -                       tz->cooling_mode = ACPI_THERMAL_MODE_CRT;
> +                       tz->cooling_mode = ACPI_THERMAL_MODE_CRITICAL;
>                 }
>         }
> 
> --
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
