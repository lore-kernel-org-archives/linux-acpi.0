From: Matt Bennett <matt-ewjRka4qIRJg9hUCZPvPmw@public.gmane.org>
Subject: Re: Re:  acpi on r40e
Date: Wed, 25 Feb 2004 19:09:55 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <403CF303.8050008@unixhead.org>
References: <W3110617218168451077731629@mail.mailsnare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <W3110617218168451077731629-OQ2JkDkuTc4TqzVU8YkfAqxOck334EZe@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Praveen C <praveen-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Praveen C wrote:

>>-----Original Message-----
>>From: Yu, Luming [mailto:luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
>>Sent: Wednesday, February 25, 2004 09:29 AM
>>To: 'Praveen C'
>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: RE: acpi on r40e
>>
>>    
>>
>>>>Can you please tell me what the processor module is doing to IDE ? 
>>>>praveen
>>>>        
>>>>
>>To get more debug information, would you please add
>>acpi_dbg_layer=0x01000000
>>acpi_dbg_level=0xffffffff
>>in function acpi_processor_init?
>>
>>And post deubg info, I think that will help us
>>a lot.
>>
>>Maybe it is related to SCI.
>>
>>--Luming
>>    
>>
>
>I made the above modification and boot. I see some debug statements during boot but I cannot copy them since the system hangs subsequently during IDE setup as I have written previously. If I compile the processor as a module and do modprobe after full boot, then system hangs but I dont get any debug messages in /var/log.
>praveen
>  
>


OK I have two PC's here so gave this a run, identical situation to 
Praveen except I'm using 2.6.3-mm2 although I have the same results with 
all kernels I've tried with the processor/thermal modules from 2.4 and 
2.6. Unfortunately half the messages are gone by the time the 
framebuffer initializes and without framebuffer the messages zoom past 
too quickly to read and can't be scrolled back.

This is what I could see:
 
acpi_processor-1328 [0001] [37] acpi_processor_get_thr: ----Entry
acpi_processor-1364 [0001] [37] acpi_processor_get_thr: Throtting state 
is T0 (0% throttling applied)
acpi_processor-1366 [0001] [37] acpi_processor_get_thr: ----Exit- 
0000000000000
acpi_processor-1534 [0001] [37] acpi_processor_get_thr: ----Exit- 
0000000000000
acpi_processor-1800 [0001] [36] acpi_processor_get_lim: ----Entry
acpi_processor-1808 [0001] [36] acpi_processor_get_lim: ----Exit- 0000000000
acpi_processor-2228 [0001] [35] acpi_processor_get_inf: ----Exit- 0000000000
acpi_processor-2063 [0001] [35] acpi_processor_add_fs : ----Entry
acpi_processor-2122 [0001] [35] acpi_processor_add_fs : ----Exit - 
000000000000
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
acpi_processor-2337 [0001] [34] acpi_processor_add   : ----Exit - 
0000000000000
acpi_processor-2402 [0001] [30] acpi_processor_init : ----Exit -  
0000000000000
ACPI: Thermal Zone [THM0] (69 C)


..skipped some info..


ide0 at...
hda: FUJITSU MHT2030AT, ATA DISK drive
ide1 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DW-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
_

[PC hangs up here]



Hope thats of some use.

cheers,
Matt Bennett


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
