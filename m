From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: Sleep hangs on compaq EVO D500 series
Date: Wed, 1 Jan 2003 23:29:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030101222939.GB28039@digda.intern.quelltext.com>
References: <CB35231B9D59D311B18600508B0EDF2F0531B1CC@caexmta9.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F0531B1CC-9AwBB6hBD6xKF45tlneXZg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: reeja.john-5C7GfCeVMHo@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Reeja,

unfortunately, what you describe below (LCD screen and CPU fan stay on
during S1) seems to be typical behaviour for S1. My machine, a Gericom
1st Supersonic M6-T, acts exactly the same, and so do a lot of other
machines (judging from postings on this list). But I once measured the 
power consumption of my machine with a Watts meter, and noticed it draws
about 30% less power when in S1.

Many people are able to turn the fan off manually by writing a "3" into
the fan state file (/proc/acpi/fan/XXX/state); a "0" should turn it on
again. If this works, one can write a little shell script for entering
S1. You'll want such a script anyway to reload the system clock from
the hardware clock after coming back from S1.

Unfortunately, your machine doesn't seem to expose fan control through
ACPI as the /proc/acpi/fan is missing in the listing you supplied, and
then there doesn't seem to be a universal and general way to turn off
the LCD backlight (other than closing the lid, perhaps).

I don't think any of this is likely to change with 2.4.20 and the current
version of the ACPI patch, but then again, I can't see a reason why you
would not want to use the latest Linux kernel and ACPI version. Many bugs
have been fixed since acpi-20020918.

Good luck,
Arndt


On Tue, Dec 31, 2002 at 01:17:24PM -0800, reeja.john-5C7GfCeVMHo@public.gmane.org wrote:
> Hi,
>       I am a newbie to to the ACPI world. I wanted to enable ACPI on my compaq EVO D500 series machine. It is hard to find any up-to-date documentation on ACPI development status and configuration procedure in linux.
>  
> Here are the steps I followed.
> 	1. Untared linux kernel 2.4.19 source got form kernel.org
> 	2. Applied the ACPI patch acpi-20020918-2.4.19.diff to kernel source.
> 	3. Enabled options Power management support, ACPI support, AC adapter,battry, button,fan,processor and debug statement
> 	4. Compiled the kernel and rebooted the machine.
> 	5. "find /proc/acpi |sort" shows following entries
> 
> 		/proc/acpi/
> 		/proc/acpi/alarm
> 		/proc/acpi/button
> 		/proc/acpi/button/power
> 		/proc/acpi/button/power/PWRF
> 		/proc/acpi/button/power/PWRF/info
> 		/proc/acpi/debug_layer
> 		/proc/acpi/debug_level
> 		/proc/acpi/dsdt
> 		/proc/acpi/event
> 		/proc/acpi/fadt
> 		/proc/acpi/info
> 		/proc/acpi/processor
> 		/proc/acpi/processor/CPU0
> 		/proc/acpi/processor/CPU0/info
> 		/proc/acpi/processor/CPU0/limit
> 		/proc/acpi/processor/CPU0/performance
> 		/proc/acpi/processor/CPU0/power
> 		/proc/acpi/processor/CPU0/throttling
> 		/proc/acpi/sleep
> 
> 	6.When I tried to put the system into sleep "echo 1 > /proc/acpi/sleep" it hanged by giving the following debug message
> 	"hwsleep-0239 [06] acpi_enter_sleep_state: Entering S1". My understanding is that sleep will stop LCD screen, CPU, FAN, 	but nothing happened.
> 
> 	7. When I press the power button it comes out from hanging and gives the prompt again.
> 
> What can be the reasons for the above failure?. Can I expect a better result we I use kernel 2.4.20 and corresponding acpi patch?. How can I verify that my ACPI configuration is correct or not? Do I need to configure/install anything more to make ACPI work on my system. Any help appreciated.
> 
> Thanks in advance
> Reeja

-- 
Arndt Schönewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>, Software Developer
Quelltext AG (http://www.quelltext-ag.de), Dortmund, Germany


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
