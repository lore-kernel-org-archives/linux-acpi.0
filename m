From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Problems since commit Recognize that Interrupt Line 255 means "not
 connected"
Date: Sat, 6 Feb 2016 00:00:32 +0100
Message-ID: <56B52990.3030103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36330 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392AbcBEXAv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2016 18:00:51 -0500
Received: by mail-wm0-f54.google.com with SMTP id p63so46069944wmp.1
        for <linux-acpi@vger.kernel.org>; Fri, 05 Feb 2016 15:00:51 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Since commit a44c386a361e "x86/PCI/ACPI: Recognize that Interrupt Line 255
means "not connected"" I get several "PCI INT not connected" warnings on
a Zotac CI321 and EHCI failes to load:

ehci-pci 0000:00:1d.0: PCI INT not connected
ehci-pci 0000:00:1d.0: EHCI Host Controller
ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 3
ehci-pci 0000:00:1d.0: debug port 2
ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
ehci-pci 0000:00:1d.0: request interrupt -2147483648 failed
ehci-pci 0000:00:1d.0: USB bus 3 deregistered
ehci-pci 0000:00:1d.0: init 0000:00:1d.0 fail, -107
ehci-pci: probe of 0000:00:1d.0 failed with error -107

XHCI brings the "PCI INT not connected" warning too but loads properly
(most likely because it uses a MSI interrupt).

Not sure whether this commit is to blame or a broken BIOS.
Just let me know in case you need additional information.

Regards, Heiner
