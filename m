From: Sebastian <admin-HmhXUwHVxSOoYr4blSSd5g@public.gmane.org>
Subject: Error: Looking up [PBST] in namespace, AE_ALREADY_EXISTS
Date: Mon, 16 Aug 2004 04:11:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040816041138.06d239dc.admin@wodkahexe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi,

I'm getting the following problem since 2.6.7 (maybe earlier,
i don't remember).

There is no problem during boot or while working without X.

As soon as I start X, I'm getting the following in dmesg:

2.6.8.1 (without acpi debug):

atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
    ACPI-0279: *** Error: Looking up [PBST] in namespace, AE_ALREADY_EXISTS
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BST] (Node def26f80), AE_ALREADY_EXISTS

2.6.7 (with acpi debug):

atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
   dswload-0279: *** Error: Looking up [PBST] in namespace, AE_ALREADY_EXISTS
   psparse-0597 [1500] ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
   psparse-1133: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BST] (Node deec4800), AE_ALREADY_EXISTS
   acpi_battery-0207 [1493] acpi_battery_get_statu: Error evaluating _BST
   osl-0895 [2438] os_wait_semaphore     : Failed to acquire semaphore[da55e8a8|1|0], AE_TIME

This only happens, _after_ i started X (Version 4.4.0)

My machine is an Aver Travelmate 291lci with latest bios.

thanks, sebastian


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
