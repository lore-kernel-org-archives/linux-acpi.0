From: Marek Hobler <kernellist@neutrinus.com>
Subject: Re: toshiba_acpi bluetooth patch
Date: Sun, 12 Aug 2007 20:22:04 +0200
Message-ID: <dc79c3e511835b7b2e7cf151ea9beaeb@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from neutrinus.com ([85.10.192.131]:3736 "EHLO neutrinus.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760132AbXHLSTk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Aug 2007 14:19:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: romal@gmx.de

> getting this patch into the kernel would be great.
yeah, but we need more pople to test this patch.


> Anything I can help ?
test, test and test :)

to enable bluetooth just check that the wireless_kill_switch is _off_ and run:

echo "power:1" > /proc/acpi/toshiba/bluetooth
echo "attach:1" > /proc/acpi/toshiba/bluetooth


regards,
Marek Hobler, 'neutrinus'

