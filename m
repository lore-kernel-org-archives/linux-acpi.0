From: Chris Collins <chris@eorbit.net>
Subject: hwapci-0142 error
Date: Sat, 19 Jul 2008 17:14:17 -0700
Message-ID: <20080720001417.GA22429@eorbit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from boojiboy.eorbit.net ([66.135.54.188]:18120 "EHLO
	boojiboy.eorbit.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbYGTAcp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 20:32:45 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

ACPI doesn't work on my desktop, a VIA Apollo MVP3 chipset.

I have a 12/20/2000 dated award BIOS.

I've installed a current slackware distro, 12.1.

In my BIOS setup I enabled ACPI, and disabled APM

In my kernel parameters, in Lilo I have tried each 
of these in succession to see what happens:


******************************************
image = /boot/vmlinuz-huge-2.6.24.5
  root = /dev/hda1
  label = Linux1
# append="acpi=ht"
# append="pci=noacpi"
# append="acpi=noirq"
# append="pnpacpi=off"
# append="noapic"
# append="nolapic"
  read-only
******************************************

Here is what happens from bootup

chrie@darkstar:~# grep -i ACPI /var/log/dmesg
 BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)
 BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)
ACPI: RSDP 000F6FF0, 0014 (r0 AWARD )
ACPI: RSDT 17FF3000, 0028 (r1 AWARD  AWRDACPI 42302E31 AWRD        0)
ACPI: FACP 17FF3040, 0074 (r1 AWARD  AWRDACPI 42302E31 AWRD        0)
ACPI: DSDT 17FF30C0, 1EA8 (r1 AWARD  AWRDACPI     1000 MSFT  100000B)
ACPI: FACS 17FF0000, 0040
ACPI: DMI BIOS year==0, assuming ACPI-capable machine
ACPI: PM-Timer IO Port: 0x4008
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 0e20)
ACPI Error (hwacpi-0142): Hardware did not change modes [20070126]
ACPI Error (evxfevnt-0086): Could not transition to ACPI mode [20070126]
ACPI Warning (utxface-0139): AcpiEnable failed [20070126]
ACPI: Unable to enable ACPI
ACPI: Interpreter disabled.
pnp: PnP ACPI: disabled


--Chris
