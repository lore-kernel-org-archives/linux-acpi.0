From: reeja.john-5C7GfCeVMHo@public.gmane.org
Subject: Sleep hangs on compaq EVO D500 series
Date: Tue, 31 Dec 2002 13:17:24 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CB35231B9D59D311B18600508B0EDF2F0531B1CC@caexmta9.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
      I am a newbie to to the ACPI world. I wanted to enable ACPI on my compaq EVO D500 series machine. It is hard to find any up-to-date documentation on ACPI development status and configuration procedure in linux.
 
Here are the steps I followed.
	1. Untared linux kernel 2.4.19 source got form kernel.org
	2. Applied the ACPI patch acpi-20020918-2.4.19.diff to kernel source.
	3. Enabled options Power management support, ACPI support, AC adapter,battry, button,fan,processor and debug statement
	4. Compiled the kernel and rebooted the machine.
	5. "find /proc/acpi |sort" shows following entries

		/proc/acpi/
		/proc/acpi/alarm
		/proc/acpi/button
		/proc/acpi/button/power
		/proc/acpi/button/power/PWRF
		/proc/acpi/button/power/PWRF/info
		/proc/acpi/debug_layer
		/proc/acpi/debug_level
		/proc/acpi/dsdt
		/proc/acpi/event
		/proc/acpi/fadt
		/proc/acpi/info
		/proc/acpi/processor
		/proc/acpi/processor/CPU0
		/proc/acpi/processor/CPU0/info
		/proc/acpi/processor/CPU0/limit
		/proc/acpi/processor/CPU0/performance
		/proc/acpi/processor/CPU0/power
		/proc/acpi/processor/CPU0/throttling
		/proc/acpi/sleep

	6.When I tried to put the system into sleep "echo 1 > /proc/acpi/sleep" it hanged by giving the following debug message
	"hwsleep-0239 [06] acpi_enter_sleep_state: Entering S1". My understanding is that sleep will stop LCD screen, CPU, FAN, 	but nothing happened.

	7. When I press the power button it comes out from hanging and gives the prompt again.

What can be the reasons for the above failure?. Can I expect a better result we I use kernel 2.4.20 and corresponding acpi patch?. How can I verify that my ACPI configuration is correct or not? Do I need to configure/install anything more to make ACPI work on my system. Any help appreciated.

Thanks in advance
Reeja

	






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
