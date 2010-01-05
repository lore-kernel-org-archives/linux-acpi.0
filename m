From: Neil Sikka <neilsikka@gmail.com>
Subject: TV_out with toshiba acpi_extras
Date: Mon, 4 Jan 2010 22:23:29 -0500
Message-ID: <39648cc21001041923o5aea8cf8k2e723fd44477f031@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.223.194]:63307 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407Ab0AEDXa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2010 22:23:30 -0500
Received: by iwn32 with SMTP id 32so554815iwn.33
        for <linux-acpi@vger.kernel.org>; Mon, 04 Jan 2010 19:23:29 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello. I am trying to get the different display modes working with my
portege M400 laptop. Im running 2.6.32 with the toshiba_acpi module.
the problem is that when i do:

echo "lcd_out:0;crt_out:1" > /proc/acpi/toshiba/video
cat /proc/acpi/toshiba/video

i get:
lcd_out: 1
crt_out: 0
tv_out: 0

I am following the guide at
http://memebeam.org/toys/ToshibaAcpiDriver. Why does the state of the
crt_out variable not change? the kernel file where this is handled is:
kernel/drivers/portability/
x86/toshiba_acpi.c. I have the same problem as these guys here:

http://osdir.com/ml/linux.hardware.toshiba/2003-04/msg00216.html

I tried doing what was suggested at that link, but that did not work
either. Is there a known bug where the state of the driver (as seen by
cat /proc/acpi/toshiba/video) is not updated by writing to it(echo
"lcd_out:0;crt_out:1" > /proc/acpi/toshiba/video)? It seems that the
state written to this file is not persistant. I have posted my problem
in full detail here
(http://www.linuxquestions.org/questions/linux-laptop-and-netbook-25/tvout-from-toshiba-portege-m400-777822/).
thanks.

-- 
Neil Sikka
