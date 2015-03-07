From: "Valerio Vanni" <valerio@valeriovanni.com>
Subject: usb ports working only with pci=noacpi (bugzilla 94261)
Date: Sat, 7 Mar 2015 09:57:37 +0100
Message-ID: <3DB27E9477684FBABF4B0592CAE4098F@vanni.it>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.ngi.it ([88.149.128.112]:48829 "EHLO smtp1.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076AbbCGJHC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 7 Mar 2015 04:07:02 -0500
Received: from newtonxpscorta (88-149-244-243.v4.ngi.it [88.149.244.243])
	by smtp1.ngi.it (Postfix) with SMTP id 07B9722182
	for <linux-acpi@vger.kernel.org>; Sat,  7 Mar 2015 09:57:51 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Here all details (dmesg, lspci etc):
https://bugzilla.kernel.org/show_bug.cgi?id=94261

The machine is:
LENOVO 90BX0018IX/Aptio CRB, BIOS O07KT49AUS 12/18/2014

OS is a Debian Wheezy amd64.

The issue is that USB ports work only starting the kernel with
"pci=noacpi" parameter.
Without it, nothing plugged into usb ports is detected.
In particular, "lsusb" returns "unable to initialize libusb: -99".
The same happens with a 3.13.11 kernel (same config).

I've tried newer kernels (3.18.8, 3.19) and they show the same issue. With
the difference that, with "pci=noacpi" they don't start at all. 

