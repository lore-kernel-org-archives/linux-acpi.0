From: James Courtier-Dutton <James-l7zRWeYnyd2TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Subject: Re: Re: SuSE AMD x86-64 bits installation issue
Date: Fri, 07 Nov 2003 13:07:56 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FAB992C.7000800@superbug.demon.co.uk>
References: <6A7AB4426712514F9E2AB28C407285FA04EBB91B@exchtp02.taipei.via.com.tw> <1068202635.2682.972.camel@dhcppc4> <20031107111339.GA4877@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031107111339.GA4877-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, HurryLin-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, DreamKu-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, StephenChen-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, PearHuang-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, NormanChung-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, KenCho-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andi Kleen wrote:

> 
> The symptom is when IO-APIC is enabled the system does not boot and 
> hangs early in some device driver like IDE. With IO-APIC disabled you obviously
> get a very different /proc/interrupts.
> 
> -Andi
> 
> 
I think I have a solution for the VIA IO-APIC failure. But I don't have 
a VIA motherboard to test it on, so if anyone would like to work with 
me, I think I could fix it.
My current theory is that it has to do with: -
Faulty Motherboards/Bios give: -
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
testing the IO APIC.......................
.................................... done.

Good Motherboards/Bios give: -
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

What is happening, is that the 8254 timer is actually connected to the 
IO-APIC, but there is a VIA register that that switches on/off routing 
of the Timer IRQ to the IO-APIC. I suspect that some BIOS's switch it 
on, and some do not, so we would need to manually switch it on by 
writing to the VIA register before testing the timer.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
