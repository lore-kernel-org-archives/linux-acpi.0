From: Tobias Karnat <tobias.karnat@googlemail.com>
Subject: Re: acpi_button: random oops on boot
Date: Tue, 07 Dec 2010 16:02:02 +0100
Message-ID: <1291734122.29072.14.camel@Tobias-Karnat>
References: <1291477752.5096.27.camel@Tobias-Karnat>
	 <201012060928.11307.bjorn.helgaas@hp.com>
	 <1291676503.24968.25.camel@Tobias-Karnat>
	 <201012061626.45962.bjorn.helgaas@hp.com>
	 <1291679699.6246.11.camel@Tobias-Karnat>
	 <20101207051521.GA16804@helgaas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:62865 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab0LGPCG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Dec 2010 10:02:06 -0500
In-Reply-To: <20101207051521.GA16804@helgaas.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, richard.coe@med.ge.com, jslaby@novell.com

Am Montag, den 06.12.2010, 22:15 -0700 schrieb Bjorn Helgaas:
> In addition to the isolation ideas I suggested above, you might
> boot with "maxcpus=1" and turn on all the Kconfig memory debug
> switches.

Booting with mminit_loglevel=4 maxcpus=1 causes this to show up:

[   17.364026] usb 1-6: device descriptor read/64, error -110
[   32.579024] usb 1-6: device descriptor read/64, error -110
[   32.794012] usb 1-6: new high speed USB device using ehci_hcd and address 6
[   47.907019] usb 1-6: device descriptor read/64, error -110
[   63.121019] usb 1-6: device descriptor read/64, error -110
[   63.335022] usb 1-6: new high speed USB device using ehci_hcd and address 7
[   73.748031] usb 1-6: device not accepting address 7, error -110
[   73.861018] usb 1-6: new high speed USB device using ehci_hcd and address 8
[   84.274018] usb 1-6: device not accepting address 8, error -110
[   84.285143] hub 1-0:1.0: unable to enumerate USB device on port 6

I have nothing connected to 1-6:

Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 003: ID 046d:c20a Logitech, Inc. WingMan RumblePad
Bus 004 Device 002: ID 03eb:3301 Atmel Corp. at43301 4-Port Hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 003: ID 046d:c062 Logitech, Inc. 
Bus 002 Device 002: ID 413c:2105 Dell Computer Corp. Model L100 Keyboard
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 005: ID 0dda:2026 Integrated Circuit Solution, Inc. USB2.0 Card Reader
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

It shows up at the same time as the crash happens without maxcpus.
However SysRq does work in this case.

-Tobias

