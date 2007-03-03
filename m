From: "Henri Hunnekens" <henrihunnekens@gmail.com>
Subject: Re: kernel BUG at drivers/acpi/osl.c:373! (acpi-cpufreq)
Date: Sat, 3 Mar 2007 08:54:46 +0100
Message-ID: <e9f486400703022354n2f92ce77t54c9fddcb1318076@mail.gmail.com>
References: <EB12A50964762B4D8111D55B764A845401485EFD@scsmsx413.amr.corp.intel.com>
	 <EB12A50964762B4D8111D55B764A845401485F3A@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:22003 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbXCCHys (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Mar 2007 02:54:48 -0500
Received: by nf-out-0910.google.com with SMTP id b2so1463404nfe
        for <linux-acpi@vger.kernel.org>; Fri, 02 Mar 2007 23:54:47 -0800 (PST)
In-Reply-To: <EB12A50964762B4D8111D55B764A845401485F3A@scsmsx413.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>
Cc: cpufreq <cpufreq@lists.linux.org.uk>, linux-acpi@vger.kernel.org

Dear Len, Venki

Thanks for you replies. I've done some analysis and with the following results.

- The bit_width field contains value 1, which causes the OOPS using
the acpi_os_write_port routine. The local copy of this function used
in kernel version 2.6.18 accepted this bit_width value.

- I've analysed the acpi tables. There are no _PSS or _PCC tables.

    Scope (\_PR)
    {
        Processor (\_PR.CPU0, 0x00, 0x0000F010, 0x06) {}
        Processor (\_PR.CPU1, 0x01, 0x0000F010, 0x06) {}
        Processor (\_PR.CPU2, 0x02, 0x0000F010, 0x06) {}
        Processor (\_PR.CPU3, 0x03, 0x0000F010, 0x06) {}
    }

I've contacted the hardware manufacturer about this. He answered that
this was correctly, since i'm using a celeron 341 D processor which
doesn't support performance states. (p-states).

When this processor doesn't support p-states, how is it possible that
I was able to switch between P0 and P1 using kernel version 2.6.18?
The cpufreq driver did really work in kernel version 2.6.18 since the
power consumption was 60 watts in powersave mode and 75 watts in
performance mode.

Where does the cpufreq driver get it's information from when the _PSS
and _PCC data are not available? I want to know why the bit_width
field contains value 1, and why the cpufreq is able to work when there
is no _PSS and _PCC data available.

Best regards,
Henri Hunnekens






2007/2/16, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>:
>
> Looks like the BIOS is having wrong value in ACPI _PSS table for
> bit_width field. Previous code use to ignore the error silently and the
> new code has a BUG statement to catch the error. With both previous and
> current code, due to this bug, cpufreq would not have worked correctly
> on your platform.
>
> We need to look at what BIOS has in bit_width field. So, I will have to
> repeat Len's comment from below.
>
> >>Please attach the output from acpidump > acpidump.out into a
> >>new bugzilla entry here:
> >>http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> >>
> >>You can get acpidump from the latest pmtools here:
> >>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> >>
>
> Thanks,
> Venki
>
> >-----Original Message-----
> >From: cpufreq-bounces@lists.linux.org.uk
> >[mailto:cpufreq-bounces@lists.linux.org.uk] On Behalf Of
> >Pallipadi, Venkatesh
> >Sent: Friday, February 16, 2007 9:49 AM
> >To: Len Brown; Henri Hunnekens
> >Cc: cpufreq; linux-acpi@vger.kernel.org
> >Subject: RE: kernel BUG at drivers/acpi/osl.c:373! (acpi-cpufreq)
> >
> >
> >Hmm.. I recently changed acpi-cpufreq to use acpi_os_write_port(),
> >instead of its local copy of read port. Let me look at that patch
> >again...
> >
> >Thanks,
> >Venki
> >
> >>-----Original Message-----
> >>From: cpufreq-bounces@lists.linux.org.uk
> >>[mailto:cpufreq-bounces@lists.linux.org.uk] On Behalf Of Len Brown
> >>Sent: Friday, February 16, 2007 8:52 AM
> >>To: Henri Hunnekens
> >>Cc: cpufreq; linux-acpi@vger.kernel.org
> >>Subject: Re: kernel BUG at drivers/acpi/osl.c:373! (acpi-cpufreq)
> >>
> >>On Friday 16 February 2007 10:03, Henri Hunnekens wrote:
> >>
> >>> Loading the acpi_cpufreq module reports a kernel bug using kernel
> >>> version 2.6.20.  versions 2.6.18 and older work fine.
> >>
> >>> kernel BUG at drivers/acpi/osl.c:373!
> >>
> >>>  [<e0074455>] acpi_cpufreq_target+0x185/0x290 [acpi_cpufreq]
> >>>  [<c037881f>] __cpufreq_driver_target+0x3f/0x50
> >>>  [<c037a0de>] cpufreq_governor_performance+0x1e/0x30
> >>>  [<c0378984>] __cpufreq_governor+0x24/0xd0
> >>>  [<c0378e9b>] __cpufreq_set_policy+0xeb/0x140
> >>>  [<c03790fe>] cpufreq_set_policy+0x4e/0x80
> >>>  [<c0379d4a>] cpufreq_add_dev+0x31a/0x3e0
> >>>  [<c02bdfc9>] sysdev_driver_register+0x59/0xa0
> >>>  [<c037a027>] cpufreq_register_driver+0x67/0x100
> >>>  [<e007809d>] acpi_cpufreq_init+0x9d/0xa4 [acpi_cpufreq]
> >>>  [<c01423f7>] sys_init_module+0x137/0x1b90
> >>>  [<c0104620>] syscall_call+0x7/0xb
> >>>  =======================
> >>> Code: f9 10 89 e5 53 89 c3 89 d0 74 12 83 f9 20 74 16 83 f9
> >>08 75 16 0f b6 c2 89
> >>>  da ee eb 12 0f b7 c2 89 da 66 ef eb 09 89 da ef eb 04 <0f>
> >>0b eb fe 5b 31 c0 5d
> >>>  c3 55 89 e5 5d c3 55 85 c0 89 e5 89 c1
> >>> EIP: [<c027dbd9>] acpi_os_write_port+0x2d/0x36 SS:ESP 0068:dd3d1c8c
> >>
> >>acpi_status acpi_os_write_port(acpi_io_address port, u32
> >>value, u32 width)
> >>{
> >>        switch (width) {
> >>        case 8:
> >>                outb(value, port);
> >>                break;
> >>        case 16:
> >>                outw(value, port);
> >>                break;
> >>        case 32:
> >>                outl(value, port);
> >>                break;
> >>        default:
> >>373:            BUG();
> >>        }
> >>
> >>        return AE_OK;
> >>}
> >>
> >>Well, acpi_os_write_port itself has not changed -- so it
> >>is either acpi_cpufreq, cpufreq, or how they've read and
> >>interpreted the tables.
> >>
> >>Please attach the output from acpidump > acpidump.out into a
> >>new bugzilla entry here:
> >>http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> >>
> >>You can get acpidump from the latest pmtools here:
> >>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> >>
> >>Also, you can build with CONFIG_ACPI_DEBUG=y and boot with
> >>"acpi_dbg_layer=2"
> >>plus "acpi_dbg_level=0xffffffff" and capture the console log.
> >>(or you can set these values after booted in /proc/acpi just before
> >>you try to load the module)
> >>
> >>and, maybe some clues from the cpufreq subsystem will help.
> >>cpufreq.debug=3 looks like it may give us a clue.
> >>
> >>thanks,
> >>-Len
>
