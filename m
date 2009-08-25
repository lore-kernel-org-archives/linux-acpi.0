From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: ACPI explodes in -next (ACPI video it seems)
Date: Tue, 25 Aug 2009 15:40:37 +0100
Message-ID: <20090825154037.675e8848@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45710 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755172AbZHYOjY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Aug 2009 10:39:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, rui.zhang@intel.com


Trace is during a modprobe

strcmp of NULL pointer from
acpi_device_probe + 0xA3/0x123
driver_probe_device
__driver_attach
bus_for_each_dev
driver_attach
__driver_attach
bus_add_driver
driver_register
acpi_bus_register_driver
acpi_video_register [video]
acpi_video_init [video]
_stext + 49
acpi_video_init + 0x0
..
..
sys_init_module

/sbin/modprobe -b acpi:LNXVIDEO: abnormal exit

IRQ routing has also broken which worked fine before (resulting in no USB)

HP (Compaq) Presario V5000 F.15 (Intel Video, Intel Celeron CPU @1.46GHz)


(note I'm not subscribed to linux-acpi)
