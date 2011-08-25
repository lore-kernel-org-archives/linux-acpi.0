From: Santiago Garcia Mantinan <manty@manty.net>
Subject: two power button events on each press
Date: Thu, 25 Aug 2011 20:18:15 +0200
Message-ID: <CAJk_L2G6JLWZxMS_PHK_div5M0JSs8QAWm2zp_nh-fOHmgivRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65212 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab1HYSSR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2011 14:18:17 -0400
Received: by bke11 with SMTP id 11so1944420bke.19
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2011 11:18:16 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!

My system seems to be duplicating the acpi power button events and
it's getting two power button events each time I press the power
button, usually this is not a problem as the system will shutdown
normally and this is why I hadn't realised till now, but lately I
changed the power button script to hibernate instead of shutdown and
saw it hibernate twice on each button press.

This only happens when pressing the motherboard's power button, I have
tried attaching an USB keyboard with power button and this one works
OK, I only get the power button event once on each press.

I have tried this using latest Debian kernel, based on 3.0.2 right
now, and also Debian's stable 2.6.32 and it is happening on both.

I don't know what other info could be of interest here, so I'll try to
describe my system the best I can:

It's running Debian unstable amd64 and the motherboard is an Asrock
939SLI-eSATA2 which has the latest bios provided by the manufacturer
(1.50 dated 2006) about the bios the web page of the motherboard says:

- 2Mb AMI BIOS
- AMI Legal BIOS
- Supports "Plug and Play"
- ACPI 1.1 Compliance Wake Up Events
- Supports Jumperfree
- SMBIOS 2.3.1 Support

I believe that this can be a problem with the motherboard or the bios
it has, but I don't know if it could be somehow solved/workarounded on
the kernel. What can I do to help debug/solve this problem?

Regards...
-- 
Manty/BestiaTester -> http://manty.net
