From: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>
Subject: Re: Samsung P35
Date: Fri, 12 Nov 2004 16:29:50 +0100
Message-ID: <4194D6EE.9020109@helios.de>
References: <6EDC9204B3704C4C8522539D5C1185E559CB72@mssmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6EDC9204B3704C4C8522539D5C1185E559CB72-g/v8ENnfjb4gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Starikovskiy, Alexey Y wrote:

> nolapic means turning off use of Local APIC (Advanced Programmable
> Interrupt Controller), present in any Pentium processor. It has nothing
> to do with ACPI (stands for Advanced Configuration and Power Interface).

ok my fault I did not look close enough on that parameter stuff. But this
only answers the first of my questions. Any idea, why I get so much errors
on my fixed dsdt?

>> My problem:
>> Suspend does not work. Neither Fn + Sleep Key nor echo mem|disk >
>> /sys/.../state
>>
>> mem does something - display is switching to text mode but returns
>> immediately.
>>
>> As I read about problem with suspend-to-* on P30, I thought its a good
>> idea to edit the dsdt to correct a call for suspend.
>>
>> So in a second step I built my own kernel (kernel-source-2.6.8 from
>> debian distrib) with initrd patch to load my own dsdt. I dumped the
>> dsdt corrected all warnings an errors and cat it to the end of my initrd.
>>
>> Here is the result:
>> ---snip---
>> or: Method execution failed [\_SB_.PCI0.LPCB.PS2M._STA] (Node dff273e0),
>> AE_AML_REGION_LIMIT
>>    ACPI-0154: *** Error: Method execution failed
>> [\_SB_.PCI0.LPCB.PS2M._STA] (Node dff273e0), AE_AML_REGION_LIMIT
>>     ACPI-1133: *** Error: Method execution failed
>> [\_SB_.PCI0.IDEC.SECD.S_D0._STA] (Node dff27a40),
>>     ACPI-1133: *** Error: Method execution failed
>> [\_SB_.PCI0.LPCB.EC0_._Q69] (Node dff26c00), AE_AML_REGION_LIMIT
>> ---snip---
>>
>> the last few messages occur when I try to change display brightness.
>> The fan isn't working any more - this is maybe because the kernel isn't
>> able to access the corresponding acpi funcion any more.
>>
>> I wasn't able to get the beginning of the dmesg buffer because it was
>> alredy rolled out.
>>
>> Can anyone help me interpret this? What the hell went wron? The built
>> indsdt is damaged but it succeeds to handle a lot of acpi events. My own
>> one compiled without any warning or error seems to be badly damaged,
>> nearly each call fails on several errors.
>>
>> I now got a vanilla kernel 2.6.9 and start compiling but there went
>> something wrong with DRM so this is still in progress (btw. I could not
>> find any cramfs patch for 2.6.9 any more, is this path obsolete for 2.6
>> and even more, debian is using a bunch of patches, which of them are
>> really necessary, any idea?)
>>
>> Where do I need to start at?

Bye,
Oliver


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
