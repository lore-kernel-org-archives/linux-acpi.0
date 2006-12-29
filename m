From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Help with ACPI events
Date: Thu, 28 Dec 2006 20:21:12 -0600
Message-ID: <45947B98.5050309@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:44355 "EHLO
	mtiwmhc12.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755039AbWL2C0D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Dec 2006 21:26:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

I'm writing for some help with ACPI events, which may be getting in the way of the setting of LEDs
for the bcm43xx module. I have an HP notebook with a "Broadcom Corporation Dell Wireless 1390 WLAN
Mini-PCI Card". This machine has a wireless on/off switch on the front. By experimenting while using
2.6.9.1, I found the necessary code needed to toggle the LED associated with the switch. The same
code does not work with 2.6.20-rc2 and the LED is always off. The state of the switch is correctly
read out by my code, but no deal with changing the LED state.

The reason I'm writing you is that whenever the switch is changed on 2.6.20, a "ACPI: EC: evaluating
_Q10" message is logged just before my code detects the switch change. I looked at the acpi driver a
little, but quickly got lost.

Is there a change in the acpi subsystem in 2.6.20 that might be interfering? Where should I look next?

Thanks,

Larry
