From: klug <klugster-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: No longer able to turn lcd backlight off with 2.6.11->2.6.12-rc2
Date: Tue, 12 Apr 2005 11:42:24 -0400
Message-ID: <425BEC60.6060001@comcast.net>
References: <425B0364.6000602@blarg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <425B0364.6000602-90T4dkFmkpLYtjvyW6yDsg@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

I tested 2.6.10, and had the same results as with 2.6.11->2.6.12-rc2. So 
it appears this is where the problem began.

klug wrote:

> After upgrading to 2.6.11.6 from 2.6.9 I am no longer able to turn the 
> lcd backlight off with the command "echo lcd_out:0 > 
> /proc/acpi/toshiba/video". I have since tried, 2.6.11, 2.6.11.7, 
> 2.6.12-rc1, and 2.6.12-rc2 with no luck. With that command I have been 
> able to turn the lcd backlight off with all 2.6 kernels up to and 
> including 2.6.9. Previous to the upgrade, nothing appeared in my 
> kernel logs after giving the command, however, now with 
> 2.6.11->2.6.12-rc2 I get the entry "[kernel] video bus notify". I have 
> also tried the new option "CONFIG_BACKLIGHT_LCD_SUPPOT", but again 
> that does not allow me to turn the backlight off. My complete setup 
> including hardware/kernel options is avaiable at, 
> http://bugme.osdl.org/show_bug.cgi?id=4468
>
> -klug
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
