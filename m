From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/6] ACPI based physical cpu hotplug
Date: Wed, 8 Sep 2004 18:16:54 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908181654.A7287@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: LHNS list <lhns-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI Developer <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi All,
	As everybody knows that we have logical cpu online/offline support in the kernel, the following set of patches extends this feature to provide ACPI based physical CPU hotplug and I am asking this set of patches to be included in the acpi-test tree. 

Please let me know if anyone see any issues or comments or even flames welcome:). 

Complete patches which applies cleanly on to 2.6.8.1-rc1-mm2 follows this mail.

Context:
--------
This set of patches supports physical CPU hotplug notification happening directly on ACPI_PROCESSOR_HID in which case the notification is services within the processor driver or  if the processor is described within the ACPI container object(i.e ACPI004 or PNP0A05 or PNP0A06) and hotplug notifications happens on the Container object then the container driver(which is a new additional driver, patch 6/6) will service this request.

The interaction between the container driver and the processor driver is implicit i.e when the container driver is notified about the hotadd as a result of notification happening on ACPI container object(i.e ACPI004 or PNP0A05 or PNP0A06), the container driver will call acpi_bus_scan() api which will add the individual devices within its namespace and the respective driver's .add routine will be called in this case acpi_processor_add() routine gets called which will handle the setting up of new processor.

For Hotadd case, the kernel mode just initializes the minimal data structures (like mapping between acpiid<->apicid<->logical_cpu_number) and populates the sysfs entries(/sys/devices/system/cpu/cpuX/online) and issues an /sbin/hotplug notification to user mode agent script at which point the hotadded CPU will be in logical offline state. User mode agent script will turn the CPU online. This is designed as kernel/usermode (i.e setting up things in kernel and actual onlining from usermode agent) because at some point in future for the Container device which contains both CPU and Memory then there needs to some order in which you can bring up the child devices of the container(i.e all memory devices first and then the cpu devices). Also if it is in user mode, the script can implement the policy whether to continue onlineing of the devices if one fails etc.

For Hotremove case, the kernel mode again just sends the notification to user land and the agent script is responsible for offlining the devices and then calling "echo "\_SB_.LSB0" > /sys/firmware/acpi/eject". This eject is a new interface which has been designed to handle this hotremove. With this kind of an interface user mode initiated hotremoval is also possible if that is required for some platform. Again in this user mode initiated hotremoval the agent script can offline the devices and then can echo the acpi_handle name onto the eject file.

Some of the contribution to this patches has come from multiple people from with in Intel and also from Fujitsu's who are also involved in this work and Fujitsu has also hosted lhns.sourceforge.net opensource project specifically to address hotplug work and I am cc'ing lhns mail-list from where I borrowed the initial design concepts.
Thanks to all for those who participated in bringing the code to this quality.

All the testing has been done in an emulation environment and for more information on setting up the emulation environment for the hotplug testing please visit lhns.sourceforge.net.

TBD - Works that needs to be done:
1) Full NUMA based systems
2) Arch specific acpi enhancements for IA32 platforms to support physical CPU hotplug.

Thanks,

-Anil Keshavamurthy
Sr. Software Engineer
Linux OS Technology Team
Intel Corp.
(w) 503-712-4476


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
