From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: No battery information on a ACER Travelmate 4001LMi
Date: Thu, 04 Nov 2004 20:29:25 +0100
Message-ID: <418A8315.50208@tiscali.be>
References: <418A81FC.9030001@tiscali.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <418A81FC.9030001-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

François Valenduc a écrit :

> Hello everybody,
>
> I own a ACER Travelmate 4001Lmi laptop and I don't manage to get 
> battery information with ACPI. It has an intel centrino 1,5Ghz 
> processor and an Intel 855GM chipset. I have compiled all necessary 
> modules but in fact I can only get information about the fan, the 
> processor and thermal zone. I can no more get the status of the 
> adapter. I have tried different kernel boot parameters (pci=noacpi, 
> acpi=on, acpi=ht), but it's always the same. With the latter, there is 
> even no /proc/acpi directory. Here belows is the kernel configuration 
> concerning ACPI I have choosen:
>
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> # CONFIG_ACPI_SLEEP is not set
> CONFIG_ACPI_AC=m
> CONFIG_ACPI_BATTERY=m
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_FAN=m
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_THERMAL=m
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_CUSTOM_DSDT is not set
> CONFIG_ACPI_BLACKLIST_YEAR=0
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_X86_ACPI_CPUFREQ=m
> # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI is not set
> CONFIG_HOTPLUG_PCI_ACPI=m
> # CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
> CONFIG_SERIAL_8250_ACPI=y
>
> In fact, in side the /proc/ac_adapter and /proc/acpi/battery, there is 
> nothing. So I guess there is something wrong with ac and battery 
> modules. Nevertheless, I am able to load these modules.
>
> Thanks for your advices.
> François Valenduc
>
Hello again,
I forgot to say something important: I am using the 2.6.9 kernel.



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
