From: Peter Carlsson <maillist.peter@home.se>
Subject: Suspend to RAM
Date: Wed, 05 Jul 2006 20:16:27 +0200
Message-ID: <44AC01FB.7080908@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxfep02.bredband.com ([195.54.107.73]:36258 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S964954AbWGESQc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Jul 2006 14:16:32 -0400
Received: from [192.168.0.3] ([82.182.68.99] [82.182.68.99])
          by mxfep02.bredband.com with ESMTP
          id <20060705181629.IHCR1253.mxfep02.bredband.com@[192.168.0.3]>
          for <linux-acpi@vger.kernel.org>; Wed, 5 Jul 2006 20:16:29 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!

I'm trying to get suspend to RAM working on my Gigabyte
GA-K8N51PVMT-9 running Debian (testing).

What I initially want to manage is to have the system
suspend and then wake up on a specific date/time.

I was thinking that the suspend was done by:

- Create a file /etc/acpi/events/suspend containing:
event=suspend
action=/etc/acpi/suspend.sh

The /etc/acpi/suspend.sh will contain necessary actions
to unload modules etcetera and the following line:

echo '2006-07-05 20:27:00' > /proc/acpi/alarm

The wake up will then take place when the date/time is.

What else is necessary for the wake up?

Is it possible to trigger an event with for example:

echo 'suspend' > /proc/acpi/event

I can't get this to work which makes me feel I am wrong
with my understanding of how ACPI works. Any help or
information would be greatly appreciated.

Below are some information that might be helpful.

dmesg | grep ACPI
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
ACPI wakeup devices:
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:0e.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 177
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 185
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 22 (level, low) -> IRQ 193
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 20 (level, low) -> IRQ 209
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [APSJ] -> GSI 23 (level, low) -> IRQ 185
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 217
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI 22 (level, low) -> IRQ 193
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: PCI Interrupt Link [APC7] enabled at IRQ 16
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APC7] -> GSI 16 (level, low) -> IRQ 217
ACPI: PCI interrupt for device 0000:01:06.0 disabled
ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 217


Best regards,
Peter Carlsson
