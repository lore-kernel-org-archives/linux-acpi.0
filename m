From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] acpi: acpica: fix acpi operand cache leak
Date: Fri, 24 Feb 2017 13:13:58 +0100
Message-ID: <6316430.DDm6VSBqH3@aspire.rjw.lan>
References: <1487292003-25769-1-git-send-email-kkamagui@gmail.com> <2603831.y6gs7thvtv@aspire.rjw.lan> <CAHjaAcRefSRTfOcU3-0VMrO4FM4mTBxY88gQEUYZBBskHs5acg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45248 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751082AbdBXMTG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Feb 2017 07:19:06 -0500
In-Reply-To: <CAHjaAcRefSRTfOcU3-0VMrO4FM4mTBxY88gQEUYZBBskHs5acg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seunghun Han <kkamagui@gmail.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org

On Friday, February 24, 2017 09:15:52 PM Seunghun Han wrote:
> Hi, Rafael.
> 
> I added my opinion below.
> 
> 2017-02-24 20:50 GMT+09:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > On Friday, February 24, 2017 08:52:42 PM Seunghun Han wrote:
> >> Hi, Lv Zheng.
> >>
> >> I added my handcrafted ACPI table under your request, because
> >> "acpidump -c on" and "acpidump -c off" doesn't work.
> >>
> >> 2017-02-21 19:36 GMT+09:00 Seunghun Han <kkamagui@gmail.com>:
> >> > Hello,
> >> >
> >> > I attached the test results below,
> >> >
> >> > 2017-02-21 9:53 GMT+09:00 Rowafael J. Wysocki <rjw@rjwysocki.net>:
> >> >> On Tuesday, February 21, 2017 12:33:08 AM Zheng, Lv wrote:
> >> >>> Hi,
> >> >>>
> >> >>> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Seunghun
> >> >>> > Han
> >> >>> > Subject: [PATCH v2] acpi: acpica: fix acpi operand cache leak
> >> >>> >
> >> >>> > I'm Seunghun Han, and I work for National Security Research Institute of
> >> >>> > South Korea.
> >> >>> >
> >> >>> > I have been doing a research on ACPI and making a handcrafted ACPI table
> >> >>> > for my research.
> >> >>> > Errors of handcrafted ACPI tables are handled well in Linux kernel while boot
> >> >>> > process, and Linux kernel goes well without critical problems.
> >> >>> > But I found some ACPI operand cache leaks in ACPI early abort cases.
> >> >>> >
> >> >>> > Boot log of ACPI operand cache leak is as follows:
> >> >>> > >[    0.174332] ACPI: Added _OSI(Module Device)
> >> >>> > >[    0.175504] ACPI: Added _OSI(Processor Device)
> >> >>> > >[    0.176010] ACPI: Added _OSI(3.0 _SCP Extensions)
> >> >>> > >[    0.177032] ACPI: Added _OSI(Processor Aggregator Device)
> >> >>> > >[    0.178284] ACPI: SCI (IRQ16705) allocation failed
> >> >>> > >[    0.179352] ACPI Exception: AE_NOT_ACQUIRED, Unable to install System Control Interrupt handler
> >> >>> > (20160930/evevent-131)
> >> >>> > >[    0.180008] ACPI: Unable to start the ACPI Interpreter
> >> >>> > >[    0.181125] ACPI Error: Could not remove SCI handler (20160930/evmisc-281)
> >> >>> > >[    0.184068] kmem_cache_destroy Acpi-Operand: Slab cache still has objects
> >> >>> > >[    0.185358] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc3 #2
> >> >>> > >[    0.186820] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> >> >>> > >[    0.188000] Call Trace:
> >> >>> > >[    0.188000]  ? dump_stack+0x5c/0x7d
> >> >>> > >[    0.188000]  ? kmem_cache_destroy+0x224/0x230
> >> >>> > >[    0.188000]  ? acpi_sleep_proc_init+0x22/0x22
> >> >>> > >[    0.188000]  ? acpi_os_delete_cache+0xa/0xd
> >> >>> > >[    0.188000]  ? acpi_ut_delete_caches+0x3f/0x7b
> >> >>> > >[    0.188000]  ? acpi_terminate+0x5/0xf
> >> >>> > >[    0.188000]  ? acpi_init+0x288/0x32e
> >> >>> > >[    0.188000]  ? __class_create+0x4c/0x80
> >> >>> > >[    0.188000]  ? video_setup+0x7a/0x7a
> >> >>> > >[    0.188000]  ? do_one_initcall+0x4e/0x1b0
> >> >>> > >[    0.188000]  ? kernel_init_freeable+0x194/0x21a
> >> >>> > >[    0.188000]  ? rest_init+0x80/0x80
> >> >>> > >[    0.188000]  ? kernel_init+0xa/0x100
> >> >>> > >[    0.188000]  ? ret_from_fork+0x25/0x30
> >> >>>
> >> >>> I'm more interested in the way of triggering AE_NOT_ACQUIRED error.
> >> >>> So could you send us the handcrafted ACPI table or both the "acpidump -c on" and "acpidump -c off" output?
> >>
> >> I modified FACP, FACS, APIC table in VirtualBox for Linux.
> >> Here are raw dumps of table.
> >
> > So, excuse me, but what's the security issue here?
> >
> > You hacked your ACPI tables into pieces which requires root privileges anyway.
> >
> > Thanks,
> > Rafael
> >
> 
> As you mentioned earlier, I hacked my ACPI table for research, so it seems that
> it is not a security issue.
> 
> But, if new mainboard are released and they have a vendor-specific ACPI table
> which has invalid data, the old version of kernel (<=4.9) will possibly expose
> kernel address and KASLR will be neutralized unintentionally.

But that would mean a basically non-functional system, so I'm not sure how
anyone can actually take advantage of the "KASLR neutralization".

> I know the vendors collaborate with Linux kernel developers, but the problem
> can still occur.
> 
> Hardware vendors release so many kinds of mainboard in a year, and the major
> Linux distros (Ubuntu, Fedora, etc.) will have 4.8 kernel for a long time.
> 
> For this reason, I think this issue has a security aspect.

Well, not quite IMO.

If the system needs ACPI tables and the kernel cannot use them, it just won't
work no matter what.

Thanks,
Rafael

