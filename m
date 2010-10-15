From: Tim Roberts <timr@probo.com>
Subject: Seeking Direction
Date: Fri, 15 Oct 2010 12:29:56 -0700
Message-ID: <4CB8ABB4.9000006@probo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from remote.itgroupnw.com ([67.136.133.82]:8731 "EHLO
	remote.itgroupnw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579Ab0JOT35 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Oct 2010 15:29:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

 I need to call a _DSM method for a device hardwired to a motherboard
USB slot.  There will be two such devices.  I've done this from Windows,
but I have a couple of questions about a Linux implementation.  I
believe that I am not an idiot, but feel free to express an alternative
opinion.

Everything is pretty clear to me, except for the mechanism to find the
DSDT path for the slots.  I'm hoping I can do all of the USB handling
from user-mode without a custom kernel driver.  Given the sysfs name of
the device in /sys/bus/usb/devices (for example, 1-1.3 or 2-1.3), I can
parse that and hack up the path name (\_SB.PCI0.EHC1.HUBN.PR01.PR13 or
..EHC2...), but that seems rather delicate, and I don't know that the
naming scheme there is standardized, should this need to move to another
manufacturer.  I couldn't find any way to link from the sysfs tree for
the USB device back to the /sys/devices/LNXSYSTM:00 tree, which would
give me the DSDT path.

So, in a udev arrival script for a device, or in a USB kernel driver for
a device, how can I learn the DSDT path to that device's slot, or at
least acquire an acpi_handle so I can call a _DSM?

And am I correct in thinking there is no way to enable a GPE callback
without using a kernel driver?

-- 
Tim Roberts, timr@probo.com
Providenza & Boekelheide, Inc.

