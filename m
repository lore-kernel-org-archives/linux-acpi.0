From: Alf <alfredo.mapelli-y7mWNqJcIDpfJ/NunPodnw@public.gmane.org>
Subject: Re: No Thermal
Date: Wed, 25 Feb 2004 01:03:30 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <403C2CA2.4090006@terra.com.br>
References: <403852B9.3060504@terra.com.br> <1077518771.12669.58.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077518771.12669.58.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

OK I already check my Kernel and it is everything OK, dmesg only find 3 
devices, CPU1, CPU2 and Power Button.
I am pretty sure that my MB suports fan and thermal control cause the 
Bios Recognize it, I am kind of newby so how the hell do I disasemble 
the acpidmp?

Len Brown wrote:

>On Sun, 2004-02-22 at 01:56, Alf wrote:
>  
>
>>Hi,
>>I trying to use ACPI for linux in a Asus MotherBoard (P4P800) but I am 
>>unable to use thermal and fan the only ACPI that works is Buttons if I 
>>cat /proc/acpi/event and press the power button it gives up a message, 
>>but under /thermal_zone and /fan there is nothing... The BIOS from this 
>>MB says that it is ACPI 2.0 enabled, but as I sayd before I cannot use ACPI.
>>Can anyone tell me if it is possibel to use? If /button woks, why 
>>/thermal_zone or /fan does not?
>>thaks
>>
>>Alfredo
>>
>>first check your .config has them enabled, eg.
>>    
>>
>
>CONFIG_ACPI=y
>CONFIG_ACPI_BOOT=y
>CONFIG_ACPI_INTERPRETER=y
>CONFIG_ACPI_SLEEP=y
>CONFIG_ACPI_SLEEP_PROC_FS=y
>CONFIG_ACPI_AC=m
>CONFIG_ACPI_BATTERY=m
>CONFIG_ACPI_BUTTON=m
>CONFIG_ACPI_FAN=m
>CONFIG_ACPI_PROCESSOR=m
>CONFIG_ACPI_THERMAL=m
># CONFIG_ACPI_ASUS is not set
># CONFIG_ACPI_TOSHIBA is not set
># CONFIG_ACPI_DEBUG is not set
>CONFIG_ACPI_BUS=y
>CONFIG_ACPI_EC=y
>CONFIG_ACPI_POWER=y
>CONFIG_ACPI_PCI=y
>CONFIG_ACPI_SYSTEM=y
>
>Then see what dmesg says -- ACPI will tell you what it finds.
>If you think it doesn't find something it should, dump the DSDT with
>acpidmp, disassemble it, and look for "Device" and see what's in there.
>
>Some MB's have ACPI fan control, other's don't.
>
>cheers,
>-Len
>
>
>
>
>-------------------------------------------------------
>SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>Build and deploy apps & Web services for Linux with
>a free DVD software kit from IBM. Click Now!
>http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
>  
>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
