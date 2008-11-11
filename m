From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Namespace lookup failure error on QuadCore E5420
Date: Tue, 11 Nov 2008 10:24:52 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308580D7E5799@orsmsx503.amr.corp.intel.com>
References: <20081109134804.GA32033@frix.fri.uniza.sk>
 <1226280769.15014.21.camel@rzhang-dt>
 <20081110052650.GA2133@frix.fri.uniza.sk>
 <1226299630.15014.30.camel@rzhang-dt>
 <4911F71203A09E4D9981D27F9D8308580D6704B1@orsmsx503.amr.corp.intel.com>
 <1226366099.30025.36.camel@minggr.sh.intel.com>
 <4911F71203A09E4D9981D27F9D8308580D7E5371@orsmsx503.amr.corp.intel.com>
 <20081111043014.GA8085@frix.fri.uniza.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7016 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbYKKSZk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 13:25:40 -0500
In-Reply-To: <20081111043014.GA8085@frix.fri.uniza.sk>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Strazovec <bubak@frix.fri.uniza.sk>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

It looks like a BIOS problem.


>-----Original Message-----
>From: Peter Strazovec [mailto:bubak@frix.fri.uniza.sk]
>Sent: Monday, November 10, 2008 8:30 PM
>To: Moore, Robert
>Cc: linux-acpi
>Subject: Re: Namespace lookup failure error on QuadCore E5420
>
>Hi, if you say "machine has bad AML code" -what does it mean? Is it bios
>problem? Bios setting problem? CPU problem? Something other...?
>
>Can I solve it somehow?
>
>Thanks
>Pete
>
>On Mon, Nov 10, 2008 at 05:53:42PM -0800, Moore, Robert wrote:
>> I figured so.
>>
>> After all, we are *interpreting* the AML code, which by definition is
>single pass, byte-by-byte.
>>
>> Only in the main table can we perform a multi-pass load to resolve
>forward references, because we aren't really "interpreting" at that time.
>>
>> So, I think we can say that the machine has bad AML code.
>>
>> Bob
>>
>>
>> >-----Original Message-----
>> >From: Lin, Ming M
>> >Sent: Monday, November 10, 2008 5:15 PM
>> >To: Moore, Robert
>> >Cc: Zhang, Rui; bubak@frix.fri.uniza.sk; linux-acpi; Len Brown
>> >Subject: RE: Namespace lookup failure error on QuadCore E5420
>> >
>> >On Tue, 2008-11-11 at 01:45 +0800, Moore, Robert wrote:
>> >> The first question would be, what does Windows do with this?
>> >>
>> >> To answer your question:
>> >>
>> >> ACPICA does not support forward references within control methods, it
>> >never has. There is good reason for this:
>> >>
>> >> Return (CS01)
>> >> If (ABCD)
>> >> {
>> >>     Name (CS01, 1)
>> >> }
>> >> Else
>> >> {
>> >>     Name (CS01, 2)
>> >> }
>> >>
>> >> What should be returned?
>> >>
>> >>
>> >> Lin Ming, here is a simplified version of the code example, please run
>it
>> >on Windows:
>> >
>> >Tested XP and Vista in KVM.
>> >They both don't support forward references within control methods.
>> >
>> >Lin Ming
>> >
>> >>
>> >>
>> >> DefinitionBlock ("gr.aml", "DSDT", 1, "TEST", "CPU0CST", 1)
>> >> {
>> >>     Name (ABCD, 1)
>> >>
>> >>     Method (_CST, 0, NotSerialized)
>> >>     {
>> >>         If (LAnd (ABCD, 0x10))
>> >>         {
>> >>             Return (CS03)
>> >>         }
>> >>
>> >>         Return (CS01)
>> >>
>> >>         Name (CS01, 1)
>> >>         Name (CS03, 3)
>> >>     }
>> >> }
>> >>
>> >> >-----Original Message-----
>> >> >From: Zhang, Rui
>> >> >Sent: Sunday, November 09, 2008 10:47 PM
>> >> >To: Moore, Robert; Lin, Ming M
>> >> >Cc: bubak@frix.fri.uniza.sk; Zhang, Rui; linux-acpi; Len Brown
>> >> >Subject: Re: Namespace lookup failure error on QuadCore E5420
>> >> >
>> >> >Hi, Bob and Ming,
>> >> >
>> >> >Please look at this piece of AML code in the cpu0cst (a dynamic SSDT
>> >> >table).
>> >> >Method (_CST, 0, NotSerialized)
>> >> >        {
>> >> >            If (LAnd (PDC1, 0x10))
>> >> >            {
>> >> >                Return (CS03)
>> >> >            }
>> >> >
>> >> >            Return (CS01)
>> >> >            Name (CS01, Package (0x02)
>> >> >            {
>> >> >               ...
>> >> >            })
>> >> >            Name (CS03, Package (0x04)
>> >> >            {
>> >> >              ...
>> >> >            })
>> >> >}
>> >> >
>> >> >CS01/CS03 is evaluated before it's defined, causing an AE_NOT_FOUND
>> >> >error.
>> >> >Should we fix it in ACPICA?
>> >> >
>> >> >thanks,
>> >> >rui
>> >> >
>> >> >On Mon, 2008-11-10 at 13:26 +0800, Peter Strazovec wrote:
>> >> >> On Mon, Nov 10, 2008 at 09:32:49AM +0800, Zhang Rui wrote:
>> >> >> > On Sun, 2008-11-09 at 21:48 +0800, Peter Strazovec wrote:
>> >> >> > > I have problem with Namespace lookup failure error on E5420.
>> >> >> > > ( ACPI Error (psargs-0358): [CS03] Namespace lookup failure,
>> >> >AE_NOT_FOUND )
>> >> >> > > Thus acpi not functional (cpufrequ via p-states, etc...).
>> >> >> > >
>> >> >> > ACPI is enabled on your system, except the cpu c-state.
>> >> >> >
>> >> >> > First please download the latest pmtools at
>> >> >> > http://www.lesswatts.org/projects/acpi/utilities.php
>> >> >> >
>> >> >> > and then please run
>> >> >> > "./acpidump > acpidump.log"
>> >> >> > "./acpidump --addr 0xcfe5f800 --length 0xd8 > cpu0cst"
>> >> >> > ???"./acpidump --addr 0xcfe5f900 --length 0xd8 > cpu1cst"
>> >> >> > ???"./acpidump --addr 0xcfe5fa00 --length 0xd8 > cpu2cst"
>> >> >> > ???"./acpidump --addr 0xcfe5fb00 --length 0xd8 > cpu3cst"
>> >> >> > and attach all these files.
>> >> >> >
>> >> >> > Btw, how do you know p-state is not functional?
>> >> >> > the p-state sysfs I/F
>(/sys/devices/system/cpu/cpuX/cpufreq/)doesn't
>> >> >> > work for you?
>> >> >> >
>> >> >> > thanks,
>> >> >> > rui
>> >> >> >
>> >> >> > > Does anyone know about some patch or some hint?
>> >> >> > >
>> >> >> > > CONFIG_ACPI_DEBUG=y, CONFIG_ACPI_DEBUG_FUNC_TRACE=y,
>> >> >> > > dmesg, interrupts and cpuinfo attached.
>> >> >> > >
>> >> >> > > thanks
>> >> >> > > Pete
>> >> >> >
>> >> >> > --
>> >> >> > To unsubscribe from this list: send the line "unsubscribe linux-
>> >acpi"
>> >> >in
>> >> >> > the body of a message to majordomo@vger.kernel.org
>> >> >> > More majordomo info at  http://vger.kernel.org/majordomo-
>info.html
>> >> >>
>> >> >>
>> >> >> I though, that 'namespace' error is like 'not working'.... anyhow:
>> >> >>
>> >> >> @cpu c-state
>> >> >> mhmm, I've been talking about p-state (  CONFIG_X86_ACPI_CPUFREQ )
>and
>> >> >not
>> >> >> working because:
>> >> >> #cpufreq-set -g performance
>> >> >> wrong, unknown or unhandled CPU?
>> >> >> #ls /sys/devices/system/cpu/cpu0/
>> >> >> cache  thermal_throttle  topology
>> >> >> -> no cpufreq dir there
>> >> >> #cat /proc/acpi/processor/CPU0/throttling
>> >> >> <not supported>
>> >> >>
>> >> >> acpidumps attached
>> >> >>
>> >> >>
>> >> >> Thanks
>> >> >> Pete
>>
>
>--
>------------------------------------------------------------------------
>
>mail me : bubak@frix.fri.utc.sk
>
>call me (sms me) : +421 904 536459

