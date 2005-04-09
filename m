From: Doug Gray <dgra1233-bzGI/hKkdgQnC9Muvcwxkw@public.gmane.org>
Subject: ACPI and hyper-threading on a dual Xeon board with a bios without
 acpi module
Date: Sat, 09 Apr 2005 17:59:02 +1000
Message-ID: <42578B46.2000805@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Folks,

The hardware is a GMS V269  VME format dual Xeon board.

How can I get Hyperthreading working when the BIOS does not contain the ACPI support module?

I do not understand why but have seen reference to the requirement to have ACPI available before the 
hyperthreading will function.

Is ACPI required to recognise the Hyperthreaded CPUs?  If so what are the minimal acpi tables 
required to be included in the kernel to enable hyperthreading and can acpi be invoked on the system 
(via kernel) when there is no pre existing support in the BIOS.

Background:

I am having a problem with a dual (physical) Xeon VME single board (from GMS model V269)) getting 
hyperthreading up and going on the CPUs.  Two physical CPUs are recognised but not the logical 
'siblings'.

I have Fedora Core 3 installed with the SMP kernel now upgraded (rpm) to 2.6.10

The board manufacturer has not included the ACPI module in the BIOS (AMIBIOS8) for their own 
reasons.  GMS position is that this is only a power management function and users of this board 
would not require power manangement.

The BIOS Northbridge (Serverworks GC-LE) support does have a switch option to enable hyperthreading, 
this is enabled.

As I understand ACPI the BIOS passes configuration information about the CPUs to the Linux Kernel 
which then know how to initialise the Hyperthreading CPUs.

Apparently Windows does not require this information from the Kernel to run Hyperthreading so 
naturally GMS (the board manufacturer) is not willing to spend the effort to get ht on Linux sorted out.

On booting the Linux dmesg shows the message "ACPI: Unable to locate RSDP"  which I interpret to 
mean the Kernel is unable to find the resource information table which should have been setup by the 
BIOS. The acpi reference manual tells me that the search in the first megabyte of physical memory is 
unable to locate the RSDP signature "RSD PTR".

I am not surprised that the RSDP is not found because the OEM did not include the ACPI module in the 
BIOS.

I have tried the kernel parameter acpi=ht but this did nothing to activate the ht activity. Does 
this need to be be augmented with an acpi=force command?

I hope someone can help.

Thanks
Doug



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
