From: "Praveen C" <praveen-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>
Subject: Re:  Re:  acpi on r40e
Date: Thu, 26 Feb 2004 13:12:42 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <W9954624460321491077801162@mail.mailsnare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matt Bennett <matt-ewjRka4qIRJg9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello
I will add some more info that I could read. I dont know how to copy them=
 so am typing them myself. I compiled processor/thermal as modules and di=
d modprobe after full boot. I kept an xterm open with "cat /proc/kmsg" an=
d did "modprobe processor" in another xterm. I was then able to see the d=
ebug messages in the first xterm. 

Context switch from TID 1 to TID C3C
acpi_processor-2385 [0C3C][18] acpi_processor_init : Entry
acpi_processor-2279 [0C3C][22] acpi_processor_add : Entry
acpi_processor-2155 [0C3C][23] acpi_processor_get_inf : Entry
acpi_processor-0262 [0C3C][24] acpi_processor_errata : Entry
acpi_processor-0275 [0C3C][24] acpi_processor_errata : Exit- 0000000000
acpi_processor-2179 [0C3C][23] acpi_processor_get_inf : Bus mastering arb=
itration control present
acpi_processor-2205 [0C3C][23] acpi_processor_get_inf : Processor [0:1]
acpi_processor-0602 [0C3C][24] acpi_processor_get_pow : Entry
acpi_processor-0610 [0C3C][24] acpi_processor_get_pow : lvl2[0x00008014] =
lvl3[0x00008015]
acpi_processor-0520 [0C3C][25] acpi_processor_get_pow : Entry
acpi_processor-0592 [0C3C][25] acpi_processor_get_pow : Exit- 0000000000
acpi_processor-0744 [0C3C][24] acpi_processor_get_pow : Exit- 0000000000
acpi_processor-0813 [0C3C][24] acpi_processor_get_pla : Entry
acpi_processor-0830 [0C3C][24] acpi_processor_get_pla : Exit- 0000000000
acpi_processor-1454 [0C3C][24] acpi_processor_get_thr: Entry
acpi_processor-1460 [0C3C][24] acpi_processor_get_thr: pblk_address[0x000=
08010] duty_offset[1] duty_width[3]
acpi_processor-1509 [0C3C][24] acpi_processor_get_thr: Found 8 throttling=
 states

Remaining messages are similar to Matt's:

> 
>acpi_processor-1328 [0001] [37] acpi_processor_get_thr: ----Entry
>acpi_processor-1364 [0001] [37] acpi_processor_get_thr: Throtting state =

>is T0 (0% throttling applied)
>acpi_processor-1366 [0001] [37] acpi_processor_get_thr: ----Exit- 
>0000000000000
>acpi_processor-1534 [0001] [37] acpi_processor_get_thr: ----Exit- 
>0000000000000
>acpi_processor-1800 [0001] [36] acpi_processor_get_lim: ----Entry
>acpi_processor-1808 [0001] [36] acpi_processor_get_lim: ----Exit- 000000=
0000
>acpi_processor-2228 [0001] [35] acpi_processor_get_inf: ----Exit- 000000=
0000
>acpi_processor-2063 [0001] [35] acpi_processor_add_fs : ----Entry
>acpi_processor-2122 [0001] [35] acpi_processor_add_fs : ----Exit - 
>000000000000
>ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
>acpi_processor-2337 [0001] [34] acpi_processor_add   : ----Exit - 
>0000000000000
>acpi_processor-2402 [0001] [30] acpi_processor_init : ----Exit -  
>0000000000000
>ACPI: Thermal Zone [THM0] (69 C)
>
>
>..skipped some info..
>
>
>ide0 at...
>hda: FUJITSU MHT2030AT, ATA DISK drive
>ide1 at 0x1f0-0x1f7,0x3f6 on irq 14
>hdc: DW-224E, ATAPI CD/DVD-ROM drive
>ide1 at 0x170-0x177,0x376 on irq 15
>hda: max request size: 128KiB
>_
>
>[PC hangs up here]
>
>
>
>Hope thats of some use.
>
>cheers,
>Matt Bennett
>
>






-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
