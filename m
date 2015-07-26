From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/2] ACPI: boot time AML overlay support
Date: Sun, 26 Jul 2015 21:52:50 +0800
Message-ID: <1437918770-3458-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43410 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755194AbbGZNwz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Jul 2015 09:52:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, lenb@kernel.org, lv.zheng@intel.com

Hi, all,

ACPICA support for OSDT (Override System Definition Table) is introduced
recently. commit fe536995f2 (ACPICA: Namespace: Add support of OSDT table)

With this support, it is able to partially override the ACPI namespace by
providing an OSDT table, which either can be used by OEMs to make fast
changes to match their BOM changes, or can be used by end user/developer
to verify/workaround some BIOS bugs.

This patch set introduces boot time AML overlay, by using the
ACPI_INITRD_TABLE_OVERRIDE feature. In this way, people can append the
compiled OSDT table to initrd, and install them at boot time, so that they
are recognized just like any other static tables described in RSDT/XSDT table.

In order to use AML overlay, we need to
1. rebuild the kernel with CONFIG_ACPI_INITRD_TABLE_OVERRIDE set
2. write an OSDT table, for example, I use the following ASL code to
   a. override the existing _SB.ADP1.PSR control method.
   b. override the existing _SB.RUIX name object.
   c. introduce new _SB.ADP2 device object, with its own name/method objects.
   DefinitionBlock ("osdt1.aml", "OSDT", 1, "", "ADPX", 0x00001000)
   {

       External (PWRS, IntObj)
       External (\_SB.ADP1, DeviceObj)

       Scope (_SB.ADP1)
       {
               Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
               {
                   Store ("Customized ADP1", Debug)
                   Return (PWRS) /* External reference */
               }
       }

       Scope (_SB)
       {
           Name (RUIX, 0x02)
           Device (ADP2)
           {
               Name (_HID, "ACPI0003" /* Power Source Device */)
               Name (_STA, 0x0F)  // _STA: Status
               Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
               {
                   Store ("Customized ADP2", Debug)
                   Store (RUIX, Debug)
                   Return (PWRS) /* External reference */
               }
           }
       }

   }
3. compile the asl code to get .aml file (iasl -tc foo.dsl).
4. append the .aml tables into initrd, e.g.
   # directory of .aml files in initrd
   mkdir -p kernel/firmware/acpi
   cp ./foo.aml kernel/firmware/acpi/
   # create a new initrd with .aml and the clean initrd appended
   find kernel | cpio -H newc --create > /boot/initrd.img-new
   cat /boot/initrd.img-origin >>/boot/initrd.img-new
   for more details of using ACPI_INITRD_TABLE_OVERRIDE feature, you can refer
   to https://www.kernel.org/doc/Documentation/acpi/initrd_table_override.txt
5. reboot using the new initrd
6. In the dmesg, you should see something like
   [    0.000000] ACPI: Override [OSDT-ADPX    ], this is unsafe: tainting kernel
   [    0.000000] Disabling lock debugging due to kernel taint
   which means the OSDT table is successfully loaded to ACPI namespace.

I have tested this patch set to override existing method/name objects, and
introduce new device/name/method objects, using the sample ASL code above,
and everything seems to work well.

Any comments are welcome.
 
thanks,
rui
