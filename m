From: "Carlo E. Prelz" <fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org>
Subject: Re: ASUS M2400N / M3700N / S1300N temperature
Date: Thu, 14 Aug 2003 07:52:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030814055240.GA19083@casa.fluido.as>
References: <20030813224646.GA3838@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030813224646.GA3838-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

	Subject: [ACPI] ASUS M2400N / M3700N / S1300N temperature
	Date: gio, ago 14, 2003 at 12:46:46 +0200

Quoting Karol Kozimor (sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org):

> Could all the people having ASUS Centrino notebooks and problems with
> thermal_zone/*/temperature always reporting 60 degrees try the following:

<cut>

> And change the fourth line to If (Local0)?
> Provided that I understand it correctly, and that the original call to EC
> is correct, this should fix the temperature readings and the fan control (at
> least partially -- it should now properly react to temperature changes). Of
> course, it's late, I'm tired and I may be completely wrong.

Thanks a lot for the effort. Sadly, I have bad things to report. With
my M3700N and the change you suggest, the machine crashes when loading
the thermal module. If I had not loaded the fan module before, I have
the following oops:

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

Unable to handle kernel paging request at virtual address 9a2eba62
 printing eip:
c0236e59
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[acpi_ns_map_handle_to_node+23/30]    Not tainted
EFLAGS: 00010246
EIP is at acpi_ns_map_handle_to_node+0x17/0x1e
eax: 00000000   ebx: 00001001   ecx: df73ef00   edx: 9a2eba62
esi: 9a2eba62   edi: de2f1ea4   ebp: c02428fc   esp: de2f1e6c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 408, threadinfo=de2f0000 task=de808080)
Stack: c02362d3 9a2eba62 de2f1ea4 df592ea0 df596668 df592e00 c023fec1 9a2eba62
       c02428fc de2f1ea4 de2f1ebc c0241dba 9a2eba62 de2f1ea4 00000000 00000000
       c0241f38 9a2eba62 de2f1ebc 00000000 00000000 c02420cb 9a2eba62 00000000
Call Trace:
 [acpi_get_data+58/91] acpi_get_data+0x3a/0x5b
 [acpi_bus_get_device+29/52] acpi_bus_get_device+0x1d/0x34
 [acpi_bus_data_handler+0/1] acpi_bus_data_handler+0x0/0x1
 [acpi_power_get_context+34/56] acpi_power_get_context+0x22/0x38
 [acpi_power_off_device+31/169] acpi_power_off_device+0x1f/0xa9
 [acpi_power_transition+155/174] acpi_power_transition+0x9b/0xae
 [acpi_bus_set_power+187/326] acpi_bus_set_power+0xbb/0x146
 [__crc_parport_ieee1284_epp_write_data+606644/8264746] acpi_thermal_remove+0x5/0x81 [thermal]
 [__crc_parport_ieee1284_epp_write_data+602892/8264746] acpi_thermal_active+0x79/0xce [thermal]
 [__crc_parport_ieee1284_epp_write_data+603319/8264746] acpi_thermal_check+0x142/0x252 [thermal]
 [__crc_parport_ieee1284_epp_write_data+606518/8264746] acpi_thermal_add+0xc4/0x13d [thermal]
 [acpi_bus_driver_init+44/138] acpi_bus_driver_init+0x2c/0x8a
 [acpi_driver_attach+91/152] acpi_driver_attach+0x5b/0x98
 [acpi_bus_register_driver+66/79] acpi_bus_register_driver+0x42/0x4f
 [__crc_parport_ieee1284_epp_write_data+622046/8264746] acpi_thermal_init+0x2a/0x4b [thermal]
 [sys_init_module+290/607] sys_init_module+0x122/0x25f
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 80 3a aa 0f 44 c2 c3 8b 44 24 04 c3 ff 35 ac d2 57 c0 e8 eb
Kernel logging (proc) stopped.
Kernel log daemon terminating.

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

If I first load the fan module, I get:

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

ACPI: Fan [FN00] (off)
ACPI: Thermal Zone [THRM] (255 C)

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

and the machine turns off (possibly quite afraid of having caught fire...) 

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
