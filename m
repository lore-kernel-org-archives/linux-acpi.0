From: David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver v0.5 [2/2]
Date: Fri, 20 Aug 2004 10:14:58 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41263192.7010300@linuxboxen.org>
References: <41244219.1090603@linuxboxen.org> <87acwqserw.wl%miura@da-cha.org>
 <87u0uyqqa7.wl%miura@da-cha.org> <4125ABEF.9090106@linuxboxen.org>
 <87pt5mqjxj.wl%miura@da-cha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <87pt5mqjxj.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hiroshi Miura wrote:

>At Fri, 20 Aug 2004 00:44:47 -0700,
>David Bronaugh wrote:
>  
>
>>>-static char*
>>>-read_nothing(char* p)
>>>-{
>>>-	/* nothing to do*/
>>>-	return p;
>>>+	if ((sinf = (int*)kmalloc(sizeof(int) * (num_sifr + 1), GFP_KERNEL)) == NULL ) {
>>>+		status = AE_ERROR;
>>>+	}
>>>
>>>      
>>>
>>Doesn't this introduce a memory leak at module unload time? I don't see 
>>any corresponding kfree()...
>>    
>>
>
>kfree() exists on v0.4 patch, i think. 
>  
>
I've confirmed that nothing will kfree() sinf once it is allocated. So 
it is a memory leak.

>><SNIP>
>>    
>>
>>>+static unsigned long
>>>+acpi_pcc_write_brightness(const char* buffer, unsigned long count)
>>>+{
>>>+	int value1, value2;
>>>+
>>>+	if (sscanf(buffer, "%i,%i", &value1, &value2) == 2 && value1 >= 0 && value1 < 2 && value2 >=0 && value2 < 20) {
>>>+		write_sset((value1 == 1)?7:4, value2);
>>>+	} else
>>>+		printk("write_brightness error\n");
>>>+
>>>+	return count;
>>>+}
>>> 
>>>
>>>      
>>>
>>Why are there two values for brightness? What do they do?
>>    
>>
>
>It's from Panasonic spec.
>
>0,n  -- brightness on AC 
>1,n  -- brightness on battery. 
>
>If pc go suspend/resume, BIOS set brightness according to this value.
>
>I should further study this interface.
>  
>
At least on my R1, this function is incorrect. Brightness values range 
from 0-255 on my R1. Setting field 4 and field 7 of sinf have exactly 
the same effect (it would appear that they map to the same function) 
even though they end up storing different values; disconnecting and 
connecting AC power does not change how bright the screen is at all. I 
believe this is intentional; however, I also believe that using ACPI to 
store values like this is pointless and it would be better to simplify 
the interface.

My experience is that changing the code to accept values from 0-255 
allows me to set the full range of screen brightnesses; however, setting 
values less than 11 makes the screen flicker like crazy (I assume this 
is because I am underpowering the backlight). So perhaps a floor of, 
say, 15 on the screen brightness would be a good choice to avoid problems.

Also a small complaint -- displaying all 6 registers in 
acpi_pcc_read_brightness is confusing (not to me since I understand the 
code, but to end users).

David Bronaugh


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
