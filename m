From: =?ISO-8859-1?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
Subject: Writing to the EC
Date: Sun, 04 Nov 2007 20:55:40 +0100
Message-ID: <472E23BC.2010909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:50021 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752866AbXKDTzm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Nov 2007 14:55:42 -0500
Received: from [192.168.0.102] (90.224.104.93) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 471EF804002F6359 for linux-acpi@vger.kernel.org; Sun, 4 Nov 2007 20:55:27 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I'm currently in the process of trying to write routines for controllin=
g
the backlight on my Clevo M72R.

Pressing the hotkeys do work but I do belive this is the result of that
the embedded controller is hardwired to the keyboard.

To make a long story short, I've hacked up a kernel module that dumps
the EC (with inspiration from the ibm acpi driver) using the exported
ec_read and ec_write symbols from the ec.c in the kernel acpi source an=
d
I've been able to locate a register which change when I manually push
the brightness hotkey buttons (0xC9).

The bad part is that writing to the EC using the ec_write function
doesn't work at all. Sure it completes the operation, but when probing
the register afterwards, no change of value is seen.

My questions to you ACPI and EC gurus are:

1. Is it possible that the EC is read-only from the OS perspective?

2. Are there any common quirks / initialization that is needed to
getting the EC to register commands?

3. Does anyone have a recommendation of programs to use for snooping I/=
O
accesses in windows?

With kind regards
Erik Andr=E9n
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
