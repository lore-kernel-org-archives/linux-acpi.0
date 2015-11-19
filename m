From: Stephan =?utf-8?Q?G=C3=BCnther?= <moepi@moepi.net>
Subject: [Apple] MacBook8,1 keyboard/trackpad
Date: Thu, 19 Nov 2015 23:10:16 +0100
Message-ID: <47df5f3035c4c23ad05817544273df0d@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from freya.moepi.net ([78.46.170.12]:46652 "EHLO freya.moepi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934234AbbKSWVE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Nov 2015 17:21:04 -0500
Received: from bifrost.moepi.net (bifrost.moepi.net [129.187.145.241])
	by freya.moepi.net (Postfix) with ESMTPS id B084330083B4
	for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2015 23:11:01 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The MacBook8,1 (12" retina model, not the 13" MacBookPro12,1) released
in April 2015 has no Linux support for its internal trackpad/keyboard so
far although the 13" model (MacBookPro12,1) recently got supported.

The problem is that the internal keyboard/trackpad is connected via SPI,
which differs from previous models.


However, according to all I figured out the internal keyboard/trackpad
of the MacBookPro12,1 is connected in precisely the same way:

1) OSX reports both as SPI devices, not USB.

2) Booting Linux the input devices magically show up as USB devices for
the MacBookPro12,1 but remain completely hidden on the MacBook8,1.


I tried to track the problem by mining various kernel modules with
printks. The result for *both* MacBooks:

1) Input devices are behind pci0000:00/0000:00:15.4 (the Intel Lynxpoint
/ Wildcat Point-LP SPI controler).

2) In the ACPI namespace the input devices are located at
PNP0A08:00/INT33C1:00/APP000D:00.

3) __acpi_match_device() is called with the APPLE-SPI-TOPCASE has hwid.
That is what's behind APP000D:00. But it returns NULL and the device is
not enabled.

Now, for any reason I do not understand (I have no idea of ACPI)
anything makes the touchpad controller (bcm5974), which is that
APPLE-SPI-TOPCASE, show up as USB device on the MacBookPro12,1. But on
the MacBook8,1 nothing happens.


Request for help: is it a firmware problem, a missing identifier in the
kernel sources, or is there really no Linux support at all? Maybe it is
not even a problem with ACPI at all...

I can provide you with any logs and even dunps of the DSDT.


Best,
Stephan
