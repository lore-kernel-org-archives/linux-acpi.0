From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Interrupt Routing
Date: Fri, 10 Jan 2003 22:31:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030110213137.GA10841@brodo.de>
References: <1042232352.2868.31.camel@rodan.monsters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1042232352.2868.31.camel-EWEM0Crkbjs/2vX+WiJxEB2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stephen L Johnson <sjohnson-WpdXj7kV/NVg9hUCZPvPmw@public.gmane.org>
Cc: ACPI Dev Mailing List <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Stephen,

Could you please send me a dmesg? CONFIG_ACPI_DEBUG should be enabled :-)

	Dominik

On Fri, Jan 10, 2003 at 02:59:12PM -0600, Stephen L Johnson wrote:
> Somewhere along the way, the interrupt routing on my laptopn has gone
> back to cramming everything onto the same interrupt. Here is my
> /proc/interrupts output:
> 
> sjohnson@rodan:~> cat /proc/interrupts 
>            CPU0       
>   0:     565260          XT-PIC  timer
>   1:       6943          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   9:      72990          XT-PIC  acpi, ohci1394, usb-uhci, usb-uhci,
> usb-uhci, Ricoh Co Ltd RL5c475, Texas Instruments PCI1410 PC card
> Cardbus Controller, Intel 82801CA-ICH3, eth0
>  11:        484          XT-PIC  sonypi
>  12:      76803          XT-PIC  PS/2 Mouse
>  14:      29615          XT-PIC  ide0
> NMI:          0 
> LOC:     565211 
> ERR:          0
> MIS:          0
> 
> This is on a Sony Vaio R505-ES running 2.4.20 with acpi-20021212.
> 
> 
> -- 
> Stephen L Johnson <sjohnson-WpdXj7kV/NVg9hUCZPvPmw@public.gmane.org>
> 
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
