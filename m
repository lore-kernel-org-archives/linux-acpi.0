From: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Subject: report: acpi-20021122 on Asus L2000D
Date: Tue, 3 Dec 2002 17:53:08 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212031653.gB3Gr9D11339@ikffws2.ikff.uni-stuttgart.de>
Reply-To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-MD5: ARTh7XSyw8ZDInysltIoHQ==
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

Hi,

I just wanted to let you know how acpi-20021122 is doing on my
Asus L2000D (Medion MD9688) Laptop.
Kernel: 2.4.20 vanilla, patched with acpi-20021126-2.4.20-rc3.diff,
crypto support and a special framebuffer driver for my SiS 730 card.

Summary: fan state is reported wrong, processor is always in C1=20
and button events are generated twice. Everything else is fine.

Long version:
Events for power button, lid switch and sleep button are generated,
but twice for each time a button is pressed. After sending the
computer to S1 (which works perfect), two power button events are
generated after waking up again - so I can't really use this button
to shut my computer down.
AC adaptor, battery, buttons and thermal zone are reported correctly.
There's an empty directory named "embedded_controller".=20
In power_resource/FN0/state, something is reported as on at system=20
level S0.=20
In fan/FAN0/state it always sais the fan was on, even when it is off.
It goes on at about 80 degrees (thermal_zone/THRM/temperature) and
off again at about 73 degrees.
There's only one real problem: In processor/CPU0/info it sais
"no" to everything. I've seen that before, though. So the result is

active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[--] demotion[--] latency[000] usage[0000=
0000]
    C2:                  <not supported>
    C3:                  <not supported>

Well, always in C1 isn't that great for a laptop!

With ACPI 20011018 on 2.4.19 I got this in processor/0/status:

Bus Mastering Activity:  00000000
C-State Utilization:     C1[6330] C2[23219] C3 [0]

So this looks like C3 or at least C2 should be possible.

I've checked dmesg and the kernel logs for things that might indicate
a problem with ACPI, and here's what I found:

(dmesg)
(...)
ACPI: Fan [FAN0] (on)
acpi_processor-2107 [06] acpi_processor_get_inf: Invalid PBLK length [5]
acpi_processor-0897 [08] acpi_processor_get_per: Unsupported address space =
[127]
 (control_register)
ACPI: Processor [CPU0] (supports C1)
acpi_bus-0439 [08] acpi_bus_set_power    : Device is not power manageable
acpi_thermal-0549 [07] acpi_thermal_active   : Unable to turn cooling devic=
e [cd
f6a668] 'on'
ACPI: Thermal Zone [THRM] (77 C)
(...)

(/var/log/messages)
(...)
spurious 8259A interrupt: IRQ7.
acpi_bus-0439 [05] acpi_bus_set_power    : Device is not power manageable
acpi_thermal-0549 [04] acpi_thermal_active   : Unable to turn cooling devic=
e [cd
f6a668] 'on'
acpi_bus-0439 [05] acpi_bus_set_power    : Device is not power manageable
acpi_thermal-0549 [04] acpi_thermal_active   : Unable to turn cooling devic=
e [cd
f6a668] 'on'
(...)

Please let me know if I should provide you with more information.
And thank you for the great work so far!


Jens

--=20
Jens Haug
IKFF Universit=E4t Stuttgart              Tel. 0711/685-6422
Pfaffenwaldring 9                       Fax  0711/685-6356
70550 Stuttgart=09                haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
