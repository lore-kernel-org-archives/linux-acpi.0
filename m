From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PM][ACPI] /proc/acpi/alarm halfway working
Date: Sun, 28 Sep 2003 01:46:30 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030927234630.GA32525@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I've just tested 2.6.0-test5-mm4, it seems that the /proc/acpi/alarm
has ceased to deadlock my laptop and actually started to work as
expected. The only drawback is:
#v+
irq 9: nobody cared!
Call Trace:
 [<c010c57e>] __report_bad_irq+0x2a/0x8b
 [<c010c668>] note_interrupt+0x6f/0x9f
 [<c010c856>] do_IRQ+0xe2/0xe4
 [<c02d1668>] common_interrupt+0x18/0x20
 [<c01f007b>] sys_shmat+0x1f6/0x2b6
 [<c012256c>] do_softirq+0x40/0x97
 [<c010c83d>] do_IRQ+0xc9/0xe4
 [<c02d1668>] common_interrupt+0x18/0x20
 [<c01fb045>] acpi_os_write_port+0x33/0x35
 [<c020f8aa>] acpi_hw_low_level_write+0x118/0x122
 [<c021e6fe>] acpi_ut_trace+0x28/0x2c
 [<c020f5cf>] acpi_hw_register_write+0xca/0x16b
 [<c020f26a>] acpi_set_register+0x1d0/0x2aa
 [<c02232ce>] acpi_system_write_alarm+0x497/0x520
 [<c0150711>] vfs_write+0xbc/0x127
 [<c0150821>] sys_write+0x42/0x63
 [<c02d14fb>] syscall_call+0x7/0xb

handlers:
[<c01faed6>] (acpi_irq+0x0/0x16)
Disabling IRQ #9
#v-

This happens upon the first echo > proc/acpi/alarm. The echo, however, sets
the time right, and the system is actually woken up successfully (S1, S3,
S4 were tested). Subsequent echos work, but do not generate the above
messages. Since IRQ 9 is what ACPI resides on, almost no new events are
reported (except those explicitely trigerred by _WAK).
The chipset is i845M; tell me if full dmesg is needed.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
