From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver v0.5 [2/2]
Date: Fri, 20 Aug 2004 10:43:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41263840.1010003@root.org>
References: <41244219.1090603@linuxboxen.org> <87acwqserw.wl%miura@da-cha.org> <87u0uyqqa7.wl%miura@da-cha.org> <4125ABEF.9090106@linuxboxen.org> <87pt5mqjxj.wl%miura@da-cha.org> <41263192.7010300@linuxboxen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41263192.7010300-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Cc: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

David Bronaugh wrote:
> Hiroshi Miura wrote:
>> It's from Panasonic spec.
>>
>> 0,n  -- brightness on AC 1,n  -- brightness on battery.
>> If pc go suspend/resume, BIOS set brightness according to this value.
>>
>> I should further study this interface.
>>
> At least on my R1, this function is incorrect. Brightness values range 
> from 0-255 on my R1. Setting field 4 and field 7 of sinf have exactly 
> the same effect (it would appear that they map to the same function) 
> even though they end up storing different values; disconnecting and 
> connecting AC power does not change how bright the screen is at all. I 
> believe this is intentional; however, I also believe that using ACPI to 
> store values like this is pointless and it would be better to simplify 
> the interface.
> 
> My experience is that changing the code to accept values from 0-255 
> allows me to set the full range of screen brightnesses; however, setting 
> values less than 11 makes the screen flicker like crazy (I assume this 
> is because I am underpowering the backlight). So perhaps a floor of, 
> say, 15 on the screen brightness would be a good choice to avoid problems.
> 
> Also a small complaint -- displaying all 6 registers in 
> acpi_pcc_read_brightness is confusing (not to me since I understand the 
> code, but to end users).

We handle these different laptops correctly in the FreeBSD 
acpi_panasonic driver.  It may be a good example for you.

-- 
Nate


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
