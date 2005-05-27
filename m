From: klug <klug-90T4dkFmkpLYtjvyW6yDsg@public.gmane.org>
Subject: Re: Fw: Re: [Linux-fbdev-devel] Fw: [Bugme-new] [Bug 4468] New: Upgrade
 to 2.6.11.6 results in no longer being able to turn the lcd backlight off.
Date: Thu, 26 May 2005 20:04:43 -0400
Message-ID: <4296641B.2050106@blarg.org>
References: <20050525223709.17f8c725.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050525223709.17f8c725.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

With a little tinkering I discovered that, at least in my case, setting 
both config_acpi_video=y and config_acpi_toshiba=y seems to build a 
conflict. With the hardware I was able to test, toshiba satellite 
5005-S504 & 5005-S507, not setting config_acpi_video=y fixed the 
backlight problem I was having with 2.6.10->current. I tested 2.6.10, 
2.6.11.0->10, and 2.6.12-rc1->5 all with success.



Andrew Morton wrote:
> hm, we seem to have several reports of Tochiba backlight failures.
> 
> Is anything likely to get fixed here?  It _used_ to work, but then
> we broke it.
> 
> 
> 
> Begin forwarded message:
> 
> Date: Thu, 14 Apr 2005 13:51:25 +0800
> From: "Antonino A. Daplas" <adaplas-ktR7oAotx3zQT0dZR+AlfA@public.gmane.org>
> To: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> Cc: klug-90T4dkFmkpLYtjvyW6yDsg@public.gmane.org
> Subject: Re: [Linux-fbdev-devel] Fw: [Bugme-new] [Bug 4468] New: Upgrade to 2.6.11.6 results in no longer being able to turn the lcd backlight off.
> 
> 
> On Monday 11 April 2005 08:28, Andrew Morton wrote:
> 
> 
>>Previous to my 2.6.11.6 upgrade I was running 2.6.9. With all unpatched 2.6
>>kernel versions up to and including 2.6.9, I could turn the lcd backlight
>>off by running "echo lcd_out:0 > /proc/acpi/toshiba/video" as root. I
>>upgraded directly from 2.6.9 to 2.6.11.6. With the upgrade I am no longer
>>able to turn the lcd backlight off. There is no effect after running "echo
>>lcd_out:0 >
>>/proc/acpi/toshiba/video" and the /proc/acpi/toshiba/video lcd_out option
> 
> 
> Looks more like an acpi problem than fbdev/backlight.
> 
> 
>>remains unchanged as 1. I recompiled the 2.6.11.6 kernel with the new
>>option CONFIG_BACKLIGHT_LCD_SUPPORT=y. Enabling this option did not allow
> 
> 
> Does not matter as intelfb does not use the backlight/lcd architecture yet.
> 
> Tony
> 


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
