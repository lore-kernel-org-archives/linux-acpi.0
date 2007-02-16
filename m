From: Len Brown <lenb@kernel.org>
Subject: Re: kernel BUG at drivers/acpi/osl.c:373! (acpi-cpufreq)
Date: Fri, 16 Feb 2007 11:52:24 -0500
Message-ID: <200702161152.24710.lenb@kernel.org>
References: <e9f486400702160703pb3912e3m874daae8665c5cbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51446 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbXBPQzT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 11:55:19 -0500
In-Reply-To: <e9f486400702160703pb3912e3m874daae8665c5cbb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henri Hunnekens <henrihunnekens@gmail.com>
Cc: cpufreq <cpufreq@lists.linux.org.uk>, linux-acpi@vger.kernel.org

On Friday 16 February 2007 10:03, Henri Hunnekens wrote:

> Loading the acpi_cpufreq module reports a kernel bug using kernel
> version 2.6.20.  versions 2.6.18 and older work fine.

> kernel BUG at drivers/acpi/osl.c:373!

>  [<e0074455>] acpi_cpufreq_target+0x185/0x290 [acpi_cpufreq]
>  [<c037881f>] __cpufreq_driver_target+0x3f/0x50
>  [<c037a0de>] cpufreq_governor_performance+0x1e/0x30
>  [<c0378984>] __cpufreq_governor+0x24/0xd0
>  [<c0378e9b>] __cpufreq_set_policy+0xeb/0x140
>  [<c03790fe>] cpufreq_set_policy+0x4e/0x80
>  [<c0379d4a>] cpufreq_add_dev+0x31a/0x3e0
>  [<c02bdfc9>] sysdev_driver_register+0x59/0xa0
>  [<c037a027>] cpufreq_register_driver+0x67/0x100
>  [<e007809d>] acpi_cpufreq_init+0x9d/0xa4 [acpi_cpufreq]
>  [<c01423f7>] sys_init_module+0x137/0x1b90
>  [<c0104620>] syscall_call+0x7/0xb
>  =======================
> Code: f9 10 89 e5 53 89 c3 89 d0 74 12 83 f9 20 74 16 83 f9 08 75 16 0f b6 c2 89
>  da ee eb 12 0f b7 c2 89 da 66 ef eb 09 89 da ef eb 04 <0f> 0b eb fe 5b 31 c0 5d
>  c3 55 89 e5 5d c3 55 85 c0 89 e5 89 c1
> EIP: [<c027dbd9>] acpi_os_write_port+0x2d/0x36 SS:ESP 0068:dd3d1c8c

acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
{
        switch (width) {
        case 8:
                outb(value, port);
                break;
        case 16:
                outw(value, port);
                break;
        case 32:
                outl(value, port);
                break;
        default:
373:            BUG();
        }

        return AE_OK;
}

Well, acpi_os_write_port itself has not changed -- so it
is either acpi_cpufreq, cpufreq, or how they've read and interpreted the tables.

Please attach the output from acpidump > acpidump.out into a new bugzilla entry here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

You can get acpidump from the latest pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Also, you can build with CONFIG_ACPI_DEBUG=y and boot with "acpi_dbg_layer=2"
plus "acpi_dbg_level=0xffffffff" and capture the console log.
(or you can set these values after booted in /proc/acpi just before
you try to load the module)

and, maybe some clues from the cpufreq subsystem will help.
cpufreq.debug=3 looks like it may give us a clue.

thanks,
-Len
