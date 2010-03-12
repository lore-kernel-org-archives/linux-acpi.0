From: Thomas Renninger <trenn@suse.de>
Subject: Reserved method has too many arguments (_OSC requires 4)
Date: Fri, 12 Mar 2010 15:00:53 +0100
Message-ID: <201003121500.53220.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42584 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757656Ab0CLOAz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Mar 2010 09:00:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devel@acpica.org

Hi,

I have a laptop freezing early, acpi=off and noapic helps.
I wonder whether this could have to do with the broken _OSC method.

I cannot access the machine myself, eventually I can get more info
if needed, but the machine is freezing really early (after ACPI
initialization, somewhere around bringing up CPUs (possibly when
starting PCI init already?).

This is not the first time I see this message.
It would be great to get (from include/linux/kernel.h):
#define FW_BUG          "[Firmware Bug]: "
#define FW_WARN         "[Firmware Warn]: "
#define FW_INFO         "[Firmware Info]: "
marked messages into ACPICA and blame the guys who are responsible
for that.

My other concern/question is: what exactly happens in such a case?
Will _OSC get invoked at all?
If yes, what will be the last argument, zero, -1?

Hmm, I doubt it has to do with the freeze, but it would still be
great if someone knowing these parts could comment what people
with such a BIOS could expect to happen.

Thanks,

  Thomas

Method (_OSC, 5, NotSerialized)
{
   Store (Arg3, Local0)
   Multiply (Local0, 0x04, Local1)
   Name (BUF1, Buffer (Local1) {})
   Store (Arg4, BUF1)
   Store (Zero, Local1)
   Store (Zero, Local2)
   While (Local0)
   {
       Multiply (Local1, 0x04, Local2)
       CreateDWordField (BUF1, Local2, CAPB)
       If (Arg2)
       {
           If (LEqual (Local1, Zero))
           {
               And (CAPB, 0xFFFFFFFC)
           }
       }
       Increment (Local1)
       Decrement (Local0)
   }
   Return (BUF1)
}
