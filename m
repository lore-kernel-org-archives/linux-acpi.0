From: David Bronaugh <dbronaugh-Jp3n8lUXroSX6QiC4yPwbg@public.gmane.org>
Subject: Re: [PATCH]Panasonic Hotkey Driver
Date: Sat, 21 Aug 2004 01:44:03 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41270B53.3060903@linuxboxen.org>
References: <41244219.1090603@linuxboxen.org> <87zn4pl116.wl%miura@da-cha.org>
 <87n00pkqc5.wl%miura@da-cha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <87n00pkqc5.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, letsnote-tech-eXqGM+LsbTTAqL8d+zIrHngSJqDPrsil@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thank you for the information from the datasheet on the SINF fields' 
meanings. It makes things much easier for me to understand.

Also, the R1 I have is the CF-R1N62ZVKM.

Hiroshi Miura wrote:

>Reading dsdt, we can understand difference. 
>
>At Sat, 21 Aug 2004 10:42:29 +0900,
>Hiroshi Miura wrote:
>  
>
>>Hi,
>>
>>At Wed, 18 Aug 2004 23:00:57 -0700,
>>David Bronaugh wrote:
>>    
>>
>>>+
>>>+#define	LCD_MAX_BRIGHTNESS 255
>>>      
>>>
>>max brightness is defined on BIOS sinf field 2,3 and 5,6.
>>I should use these value for input check. 
>>    
>>
>
>From  http://triaez.kaisei.org/~t-ogawa/misc/cf-r1n.dsl.gz
>CF-R1N series BIOS is
>
>        Device (HKEY)
>        {
>            Name (_HID, EisaId ("MAT0019"))
>            Name (SIFR, Package (0x09)
>            {
>                0x01,
>                0x00, 
>                0xFF, 		/* ac max */
>                0x14, 		/* ac min */
>                0xFF, 		/* ac current  */
>                0xFF, 		/* dc max */
>                0x14, 		/* dc min */
>                0x7F, 		/* dc current */
>                0x00
>            }
>
>this means when AC
>maximum 0xFF,  minimum 0x14,   default 0xFF
>when on battery,
>maximum 0xFF,  minimum 0x14,   default 0x7F
>
>I think your let's note laptop may be same as above.
>  
>
>CF-R3 series BIOS is (you can get it from http://acpi.sourceforge.net/dsdt/view.php?id=227)
>
>        Device (HKEY)
>        {
>            Name (_HID, EisaId ("MAT0019"))
>            Name (SIFR, Package (0x0A)
>            {
>                0x01, 
>                0x00, 
>                0x14, 	/* ac max */
>                Zero, 	/* ac min */
>                0xFF, 	/* ac current */
>                0x14, 	/* dc max */
>                Zero, 	/* dc min */
>                0x7F, 	/* dc current */
>                0x00, 
>                0x01
>            })			
>
>this version of DSDT is extended one field.
>
>this means when AC
>maximum 0x14,  minimum 0x0,   default 0xFF
>when on battery,
>maximum 0x14,  minimum 0x0,   default 0x7F
>
>but machine returns AC 0x14, battery 0x0F.
>  
>
OK, this all makes sense now. It seems like the best way to do screen 
brightness setting would be to read fields 2 and 3 from SINF into 
internal fields (pcc_max_bright and pcc_min_bright?) to check user input 
and make sure it is not outside these bounds.

I don't think it is necessary to adjust (or read) fields 5 6 and 7 -- 
could you confirm on your R3 that these are not necessary (try the 
things I tried on my R1N)? If you can confirm this, we can simplify the 
driver to only expose 1 field for the 'brightness' control.

It might be nice for userspace applications to have access to max and 
min brightness though; maybe add read-only proc entries for 
max_brightness and min_brightness?

If you like, I could implement these things and send a patch tomorrow.

David Bronaugh


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
