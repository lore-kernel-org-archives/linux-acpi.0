From: Mirko Werneke <mirko.werneke-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Acer TM 661 does not wake up from STR
Date: Thu, 26 Aug 2004 14:41:06 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <412DDA62.5030505@gmx.net>
References: <412CA779.8000602@gmx.net> <412CC887.9080706@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <412CC887.9080706-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Nate Lawson wrote:
> Mirko Werneke wrote:
> 
>> I compiled a minimal kernel (without usb/wlan drivers, etc.) with a 
>> little patch in wakeup.S.
>> I inserted after .code16 the line "lcall $0xffff,$0". This should - 
>> according to Stefan - immediatly call the BIOS reset code after the 
>> kernel gets control back from BIOS. But the situation did not change 
>> (no "automatic" reboot after resume). So we came to the conclusion, 
>> that the kernel does not get the control back when the system wakes up.
>> So i think that there is a problem with the BIOS or the kernel does 
>> something wrong while suspending.
> 
> 
> So the BIOS is not calling the wake vector.

But why? Because i don't know very much about acpi and there is no error 
message i simply don't know where to start to solve the problem.

> I've been wondering about 
> several deviations from the spec in the sleep path (hwsleep.c).
> 
> I think _GTS should be run immediately before writing the sleep value in 
> EnterSleepState (not Prep). [...]
> I'm suspicious of writing the SLP_TYP and SLP_EN on separate passes. The 
> sample code in the spec (7.3.4) writes this in one pass.

Do you think that this deviations are responsible for the problems i 
encounter? My laptop does not have a _GTS method and writing SLP_TYP and 
SLP_EN in one pass does not make any difference.

best wishes
Mirko


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
