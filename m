From: Mirko Werneke <mirko.werneke-hi6Y0CQ0nG0@public.gmane.org>
Subject: Acer TM 661 does not wake up from STR
Date: Wed, 25 Aug 2004 16:51:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <412CA779.8000602@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi list!

I'm using kernel 2.6.8.1 with ACPI 20040715

I've a really big problem with my Acer Travelmate 661 laptop: Once 
suspended to ram, it won't wake up again! The laptop seems to suspend 
corretly (no error messages while suspending; Power LED switches from 
green to orange). But after a key press to wake it up the only reaction 
the laptop shows is switching the power led to green again. Nothing more 
happens. I've to press the power button for 4 seconds to switch the 
laptop completely off. After that i can reboot normally.

Besides from playing around withh several parameters ("noapic", 
"pci=routeirq", "acpi_sleep=s3_bios"/"s3_mode") i tried with help from 
Stefan Dösinger the following:

I compiled a minimal kernel (without usb/wlan drivers, etc.) with a 
little patch in wakeup.S.
I inserted after .code16 the line "lcall $0xffff,$0". This should - 
according to Stefan - immediatly call the BIOS reset code after the 
kernel gets control back from BIOS. But the situation did not change (no 
"automatic" reboot after resume). So we came to the conclusion, that the 
kernel does not get the control back when the system wakes up.
So i think that there is a problem with the BIOS or the kernel does 
something wrong while suspending.

Any ideas how i can get a sign of life after waking up the laptop or 
continiue debug the problem?

Let me know if you need more information.

Regards
Mirko Werneke


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
