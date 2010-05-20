From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: Linux doesn't shutdown (turn off) the computer
Date: Thu, 20 May 2010 17:07:42 -0300
Message-ID: <4bf59692.1508c00a.42ee.0c0b@mx.google.com>
References: <phlm97-dol.ln1@tux.abusar.org.br>
	<alpine.LFD.2.00.1005192340540.2921@localhost.localdomain>
	<4bf5673d.1408c00a.5301.03d2@mx.google.com>
	<alpine.LFD.2.00.1005201320540.29212@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f171.google.com ([209.85.221.171]:61633 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab0ETUHz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 16:07:55 -0400
Received: by qyk1 with SMTP id 1so265835qyk.5
        for <linux-acpi@vger.kernel.org>; Thu, 20 May 2010 13:07:54 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005201320540.29212@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Thu, 20 May 2010 13:27:48 -0400 (EDT)
Len Brown <lenb@kernel.org> wrote:

> Hmm, your config powers off fine for me.

	Interesting, so it doesn't have anything to do with the kernel.

> I had to add Intel graphics, Intel ethernet, and mouse support to
> make it useful on the machine in front of me, but even without that
> poweroff worked fine.  You might try mine, as it enables PM_DEBUG
> and ACPI_DEBUG.

	Nothing. I was reading debug.txt from acpi dir and there are two
entries: acpi.debug_layer and acpi.debug_level kernel command line
options. Shouldn't I set them for it to show debug messages?

fraga@tux /usr/src/linux/Documentation/acpi$ cat /sys/module/acpi/parameters/debug_layer
Description                     Hex        SET
ACPI_UTILITIES                  0x00000001 [ ]
ACPI_HARDWARE                   0x00000002 [ ]
ACPI_EVENTS                     0x00000004 [ ]
ACPI_TABLES                     0x00000008 [ ]
ACPI_NAMESPACE                  0x00000010 [ ]
ACPI_PARSER                     0x00000020 [ ]
ACPI_DISPATCHER                 0x00000040 [ ]
ACPI_EXECUTER                   0x00000080 [ ]
ACPI_RESOURCES                  0x00000100 [ ]
ACPI_CA_DEBUGGER                0x00000200 [ ]
ACPI_OS_SERVICES                0x00000400 [ ]
ACPI_CA_DISASSEMBLER            0x00000800 [ ]
ACPI_COMPILER                   0x00001000 [ ]
ACPI_TOOLS                      0x00002000 [ ]
ACPI_BUS_COMPONENT              0x00010000 [ ]
ACPI_AC_COMPONENT               0x00020000 [ ]
ACPI_BATTERY_COMPONENT          0x00040000 [ ]
ACPI_BUTTON_COMPONENT           0x00080000 [ ]
ACPI_SBS_COMPONENT              0x00100000 [ ]
ACPI_FAN_COMPONENT              0x00200000 [ ]
ACPI_PCI_COMPONENT              0x00400000 [ ]
ACPI_POWER_COMPONENT            0x00800000 [ ]
ACPI_CONTAINER_COMPONENT        0x01000000 [ ]
ACPI_SYSTEM_COMPONENT           0x02000000 [ ]
ACPI_THERMAL_COMPONENT          0x04000000 [ ]
ACPI_MEMORY_DEVICE_COMPONENT    0x08000000 [ ]
ACPI_VIDEO_COMPONENT            0x10000000 [ ]
ACPI_PROCESSOR_COMPONENT        0x20000000 [ ]
ACPI_ALL_DRIVERS                0xFFFF0000 [ ]
--
debug_layer = 0x00000000 ( * = enabled)

fraga@tux /usr/src/linux/Documentation/acpi$ cat /sys/module/acpi/parameters/debug_level 
Description                     Hex        SET
ACPI_LV_INIT                    0x00000001 [ ]
ACPI_LV_DEBUG_OBJECT            0x00000002 [ ]
ACPI_LV_INFO                    0x00000004 [*]
ACPI_LV_INIT_NAMES              0x00000020 [ ]
ACPI_LV_PARSE                   0x00000040 [ ]
ACPI_LV_LOAD                    0x00000080 [ ]
ACPI_LV_DISPATCH                0x00000100 [ ]
ACPI_LV_EXEC                    0x00000200 [ ]
ACPI_LV_NAMES                   0x00000400 [ ]
ACPI_LV_OPREGION                0x00000800 [ ]
ACPI_LV_BFIELD                  0x00001000 [ ]
ACPI_LV_TABLES                  0x00002000 [ ]
ACPI_LV_VALUES                  0x00004000 [ ]
ACPI_LV_OBJECTS                 0x00008000 [ ]
ACPI_LV_RESOURCES               0x00010000 [ ]
ACPI_LV_USER_REQUESTS           0x00020000 [ ]
ACPI_LV_PACKAGE                 0x00040000 [ ]
ACPI_LV_ALLOCATIONS             0x00100000 [ ]
ACPI_LV_FUNCTIONS               0x00200000 [ ]
ACPI_LV_OPTIMIZATIONS           0x00400000 [ ]
ACPI_LV_MUTEX                   0x01000000 [ ]
ACPI_LV_THREADS                 0x02000000 [ ]
ACPI_LV_IO                      0x04000000 [ ]
ACPI_LV_INTERRUPTS              0x08000000 [ ]
ACPI_LV_AML_DISASSEMBLE         0x10000000 [ ]
ACPI_LV_VERBOSE_INFO            0x20000000 [ ]
ACPI_LV_FULL_TABLES             0x40000000 [ ]
ACPI_LV_EVENTS                  0x80000000 [ ]
--
debug_level = 0x0000000C (* = enabled)


-- 
