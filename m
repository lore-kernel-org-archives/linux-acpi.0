From: Seunghun Han <kkamagui@gmail.com>
Subject: Re: [PATCH v2] acpi: acpica: fix acpi operand cache leak
Date: Sat, 25 Feb 2017 07:37:14 +0900
Message-ID: <CAHjaAcQJmJ9H3Qr1mWUax31JR+uSBw-8nR0RJcdjsQKkzS+tBg@mail.gmail.com>
References: <1487292003-25769-1-git-send-email-kkamagui@gmail.com>
 <6316430.DDm6VSBqH3@aspire.rjw.lan> <CAHjaAcT7OoTDEweCBwL=BuC-RL6DjKo0AMGS-8HearCdy4_7QQ@mail.gmail.com>
 <3660439.lHcxWCEFi4@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34758 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXWhq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Feb 2017 17:37:46 -0500
In-Reply-To: <3660439.lHcxWCEFi4@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org

Hi, Rafael.

I agree with you and I added my opinion below.

2017-02-25 1:50 GMT+09:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Friday, February 24, 2017 09:56:21 PM Seunghun Han wrote:
>> Hi, Rafeal.
>>
>> I added my opinion below.
>>
>> 2017-02-24 21:13 GMT+09:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> > On Friday, February 24, 2017 09:15:52 PM Seunghun Han wrote:
>> >> Hi, Rafael.
>> >>
>> >> I added my opinion below.
>> >>
>> >> 2017-02-24 20:50 GMT+09:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> >> > On Friday, February 24, 2017 08:52:42 PM Seunghun Han wrote:
>> >> >> Hi, Lv Zheng.
>> >> >>
>> >> >> I added my handcrafted ACPI table under your request, because
>> >> >> "acpidump -c on" and "acpidump -c off" doesn't work.
>> >> >>
>> >> >> 2017-02-21 19:36 GMT+09:00 Seunghun Han <kkamagui@gmail.com>:
>> >> >> > Hello,
>> >> >> >
>> >> >> > I attached the test results below,
>> >> >> >
>> >> >> > 2017-02-21 9:53 GMT+09:00 Rowafael J. Wysocki <rjw@rjwysocki.net>:
>> >> >> >> On Tuesday, February 21, 2017 12:33:08 AM Zheng, Lv wrote:
>> >> >> >>> Hi,
>> >> >> >>>
>> >> >> >>> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Seunghun
>> >> >> >>> > Han
>> >> >> >>> > Subject: [PATCH v2] acpi: acpica: fix acpi operand cache leak
>> >> >> >>> >
>> >> >> >>> > I'm Seunghun Han, and I work for National Security Research Institute of
>> >> >> >>> > South Korea.
>> >> >> >>> >
>> >> >> >>> > I have been doing a research on ACPI and making a handcrafted ACPI table
>> >> >> >>> > for my research.
>> >> >> >>> > Errors of handcrafted ACPI tables are handled well in Linux kernel while boot
>> >> >> >>> > process, and Linux kernel goes well without critical problems.
>> >> >> >>> > But I found some ACPI operand cache leaks in ACPI early abort cases.
>> >> >> >>> >
>> >> >> >>> > Boot log of ACPI operand cache leak is as follows:
>> >> >> >>> > >[    0.174332] ACPI: Added _OSI(Module Device)
>> >> >> >>> > >[    0.175504] ACPI: Added _OSI(Processor Device)
>> >> >> >>> > >[    0.176010] ACPI: Added _OSI(3.0 _SCP Extensions)
>> >> >> >>> > >[    0.177032] ACPI: Added _OSI(Processor Aggregator Device)
>> >> >> >>> > >[    0.178284] ACPI: SCI (IRQ16705) allocation failed
>> >> >> >>> > >[    0.179352] ACPI Exception: AE_NOT_ACQUIRED, Unable to install System Control Interrupt handler
>> >> >> >>> > (20160930/evevent-131)
>> >> >> >>> > >[    0.180008] ACPI: Unable to start the ACPI Interpreter
>> >> >> >>> > >[    0.181125] ACPI Error: Could not remove SCI handler (20160930/evmisc-281)
>> >> >> >>> > >[    0.184068] kmem_cache_destroy Acpi-Operand: Slab cache still has objects
>> >> >> >>> > >[    0.185358] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc3 #2
>> >> >> >>> > >[    0.186820] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>> >> >> >>> > >[    0.188000] Call Trace:
>> >> >> >>> > >[    0.188000]  ? dump_stack+0x5c/0x7d
>> >> >> >>> > >[    0.188000]  ? kmem_cache_destroy+0x224/0x230
>> >> >> >>> > >[    0.188000]  ? acpi_sleep_proc_init+0x22/0x22
>> >> >> >>> > >[    0.188000]  ? acpi_os_delete_cache+0xa/0xd
>> >> >> >>> > >[    0.188000]  ? acpi_ut_delete_caches+0x3f/0x7b
>> >> >> >>> > >[    0.188000]  ? acpi_terminate+0x5/0xf
>> >> >> >>> > >[    0.188000]  ? acpi_init+0x288/0x32e
>> >> >> >>> > >[    0.188000]  ? __class_create+0x4c/0x80
>> >> >> >>> > >[    0.188000]  ? video_setup+0x7a/0x7a
>> >> >> >>> > >[    0.188000]  ? do_one_initcall+0x4e/0x1b0
>> >> >> >>> > >[    0.188000]  ? kernel_init_freeable+0x194/0x21a
>> >> >> >>> > >[    0.188000]  ? rest_init+0x80/0x80
>> >> >> >>> > >[    0.188000]  ? kernel_init+0xa/0x100
>> >> >> >>> > >[    0.188000]  ? ret_from_fork+0x25/0x30
>> >> >> >>>
>> >> >> >>> I'm more interested in the way of triggering AE_NOT_ACQUIRED error.
>> >> >> >>> So could you send us the handcrafted ACPI table or both the "acpidump -c on" and "acpidump -c off" output?
>> >> >>
>> >> >> I modified FACP, FACS, APIC table in VirtualBox for Linux.
>> >> >> Here are raw dumps of table.
>> >> >
>> >> > So, excuse me, but what's the security issue here?
>> >> >
>> >> > You hacked your ACPI tables into pieces which requires root privileges anyway.
>> >> >
>> >> > Thanks,
>> >> > Rafael
>> >> >
>> >>
>> >> As you mentioned earlier, I hacked my ACPI table for research, so it seems that
>> >> it is not a security issue.
>> >>
>> >> But, if new mainboard are released and they have a vendor-specific ACPI table
>> >> which has invalid data, the old version of kernel (<=4.9) will possibly expose
>> >> kernel address and KASLR will be neutralized unintentionally.
>> >
>> > But that would mean a basically non-functional system, so I'm not sure how
>> > anyone can actually take advantage of the "KASLR neutralization".
>>
>> I think an attacker can take advantage of the "KASLR neutralization". As you
>> know, KASLR is good technology to protect kernel from kernel exploits.
>>
>> If the kernel has vulnerabilities, the attacker can make exploit using them.
>> But, the exploit usually needs gadgets (small code), therefore the attacker
>> should know where the gadgets are in kernel. If the KASLR is working in kernel,
>> the attacker should find the actual kernel address, and he can get kernel
>> address information from kernel warning.
>
> If the system basically doesn't work, that information isn't  particularly useful.
>
>> >> I know the vendors collaborate with Linux kernel developers, but the problem
>> >> can still occur.
>> >>
>> >> Hardware vendors release so many kinds of mainboard in a year, and the major
>> >> Linux distros (Ubuntu, Fedora, etc.) will have 4.8 kernel for a long time.
>> >>
>> >> For this reason, I think this issue has a security aspect.
>> >
>> > Well, not quite IMO.
>> >
>> > If the system needs ACPI tables and the kernel cannot use them, it just won't
>> > work no matter what.
>> >
>> > Thanks,
>> > Rafael
>> >
>> Yes, you are right. But, Linux kernel has well-defined exception handlers, so
>> some systems may work fine like my test machine. Moreover the users may not
>> recognize what the problem is, and I think that they will use the system in
>> insecure status for a long time.
>
> A virtual box or a guest can run without ACPI tables.  A bare metal system
> where ACPI tables are necessary will be more-or-less unusable if the kernel
> cannot use them (it won't be able to detect interrupt controllers and the PCI
> host bridge just for starters).
>
> Running a guest with totally broken ACPI tables requires root privileges on the
> host.  Running a bare metal system with totally broken ACPI tables (which seems
> to be your basic concern) may be a good research project, but nobody will do
> that in practice.  And everybody who tries that will notice what's going on.
>
> Yes, you found a bug, but I still am not convinced about how this is security-related.

I totally agree with you that this case is not in practice now.
I just started researching on ACPI, and I don't have enough ideas to occur
a security problem using a bug. I just think that it has a little possibility
which is security-related.

Thank you so much for your guides.
It helps me a lot to change my research direction.

So, could my patch be merged in next kernel (4.11 rc-1)? or do I need to do
something for it?
Please let me know.

Best regards.

>
> Thanks,
> Rafael
>
