From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: Re: AMD64 - kernel freezes when inserting processor/powernow-k8
 module
Date: Thu, 03 Jun 2004 20:10:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40BF699A.6020507@renninger.de>
References: <40BE06B2.5090808@renninger.de> <c051dde5040602102956373117@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <c051dde5040602102956373117-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Praveen C wrote:
> I too had problems with processor module on my thinkpad R40e. To see
> how I fixed it go to
> 
> http://www.flatface.net/~praveen/tp
Cheers, this prevents the machine to hang.
The hang is caused by some interference between the USB and firewire 
modules.
I recognised that the machine hangs when loading the processor module 
when the ehci_hcd or ohci1394 module has been loaded before.
Otherwise everything works fine...

Are there intentions to get this fixed, can I help/provide more info 
somehow?

     Thomas
> 
> praveen
> 
> On Wed, 02 Jun 2004 18:56:18 +0200, Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org> wrote:
> 
>>Kernel 2.6.5-16 with latest ACPI patches ...
>>
>>loading the powernow-k8 module freezes the machine immediately
>>(POWERNOW-K8_ACPI compiled in and not compiled in)
>>
>>loading the processor module freezes the machine also at once.
>>(could not get any info, even with acpi_debug function trace on, syslog
>>buffering disabled).
>>
>>Other ACPI related modules load and work fine (ac, battery, fan, of
>>course not thermal as it depends on the processor mod).
>>
>>You find the disassembled DSDT in:
>>http://stio1.fh-wuerzburg.de/student/i31990/arima_hw_info/arima_dsdt.dsl
>>
>>My modified (so that it compiles) DSDT is:
>>http://stio1.fh-wuerzburg.de/student/i31990/arima_hw_info/arima_dsdt_modif.dsl
>>
>>and the acpidmp in:
>>http://stio1.fh-wuerzburg.de/student/i31990/arima_hw_info/acpidmp_arima_AMD64
>>
>>If someone has a similar machine (AMD64 3200+), I would appreciate if
>>you can send me your DSDT to compare it with mine.
>>
>>Q: How can I access the Debug object/address used in ASL?
>>
>>My experiences interpreting ASL code are limited..., please help...
>>
>>Thanks.
>>
>>      Thomas
>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by the new InstallShield X.
>>From Windows to Linux, servers to mobile, InstallShield X is the one
>>installation-authoring solution that does it all. Learn more and
>>evaluate today! http://www.installshield.com/Dev2Dev/0504
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
