From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
Date: Thu, 4 Sep 2003 00:04:58 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCFB@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Martin Mokrejs <mmokrejs-V2lp6ZUObelkZyP8+xg2CQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Martin,
Does this still happen with 2.4.22?
If yes, can I trouble you to drop the info into bugzilla so we can put
it in the queue?

Thanks,
-Len
----
Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Componenet: ACPI

Please attach the output from dmidecide, available in /usr/sbin/, or
here: 
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.


> -----Original Message-----
> From: Martin Mokrejs [mailto:mmokrejs-V2lp6ZUObelkZyP8+xg2CQ@public.gmane.org] 
> Sent: Thursday, August 21, 2003 12:15 PM
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
> 
> 
> Hi,
>   I observe time to time on cold boot hang of my laptop. I 
> remember to see 
> such hangs at least since 2.4.21-pre3. Here's my latest 
> running kernel:
> 
> # ksymoops --system-map=/boot/System.map-2.4.22-pre7 
> --vmlinux=/usr/src/linux-2.4.22-pre7/vmlinux ./cr
> ksymoops 2.4.9 on i686 2.4.22-pre7.  Options used
>      -v /usr/src/linux-2.4.22-pre7/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.22-pre7/ (default)
>      -m /boot/System.map-2.4.22-pre7 (specified)
> 
> EFLAGS: 00010246
> eax: 00000000 ebx: 638a05f0 ecx: 00000000 edx: 00000006
> esi: 638a05f0 edi: f7ebddd0 ebp: f7ebdd78 esp: f7ebdd74
> ds: 0018 es: 0018 ss: 0018
> Process keventd: (pid 2, stackpage=f7ebd000)
> Stack: f7ebdda4 f7ebdd90 c01ede68 638a05f0 f7ebdda4 f7ebddd0 
> 638a05f0 f7ebddc0
>        c01fc0f2 638a05f0 c01fc072 f7ebddd0 00010000 c0337755 
> c033770a 00000050
>        f7ebddd4 f7ebddd4 638a05f0 f7ebddf0 c02037c2 638a05f0 
> f7ebddd0 00000000
> Call Trace:     [<c01ede68>] [<c01fc0f2>] [<c01fc072>] 
> [<c02037c2>] [<c01f8a2a>]
>   [<c0203b8d>] [<c0203ee7>] [<c01fc4c7>] [<c01f8a00>] 
> [<c0207aed>] [<c0207e5e>]
>   [<c0208b60>] [<c01dce5a>] [<c01d4f7d>] [<c011ff0a>] 
> [<c01282e5>] [<c01281b0>]
>   [<c0105000>] [<c01057ee>] [<c01281b0>]
> Code: 80 3b aa 0f 44 c3 5b 5d c3 a1 d4 55 40 c0 eb f6 55 89 e5 8b
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> 
> >>edi; f7ebddd0 <_end+37a9304c/3a4f02dc>
> >>ebp; f7ebdd78 <_end+37a92ff4/3a4f02dc>
> >>esp; f7ebdd74 <_end+37a92ff0/3a4f02dc>
> 
> Trace; c01ede68 <acpi_get_data+34/60>
> Trace; c01fc0f2 <acpi_bus_get_device+45/a9>
> Trace; c01fc072 <acpi_bus_data_handler+0/3b>
> Trace; c02037c2 <acpi_power_get_context+46/a6>
> Trace; c01f8a2a <acpi_ut_trace+29/2b>
> Trace; c0203b8d <acpi_power_off_device+46/19d>
> Trace; c0203ee7 <acpi_power_transition+111/138>
> Trace; c01fc4c7 <acpi_bus_set_power+15f/273>
> Trace; c01f8a00 <acpi_ut_debug_print_raw+29/2a>
> Trace; c0207aed <acpi_thermal_active+bf/187>
> Trace; c0207e5e <acpi_thermal_check+295/2e2>
> Trace; c0208b60 <acpi_thermal_notify+a6/105>
> Trace; c01dce5a <acpi_ev_notify_dispatch+54/7a>
> Trace; c01d4f7d <acpi_os_execute_deferred+3a/6c>
> Trace; c011ff0a <__run_task_queue+5a/70>
> Trace; c01282e5 <context_thread+135/1d0>
> Trace; c01281b0 <context_thread+0/1d0>
> Trace; c0105000 <_stext+0/0>
> Trace; c01057ee <arch_kernel_thread+2e/40>
> Trace; c01281b0 <context_thread+0/1d0>
> 
