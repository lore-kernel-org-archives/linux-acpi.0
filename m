From: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
Subject: Backlight dark and wireless button not working on Fujitsu E753
Date: Mon, 24 Jun 2013 18:33:01 +0200
Message-ID: <CAO_aot70KoE=fvO11HJsg1OW-EGOreNVOcyjb8XsEMmbAbn=Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:56505 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab3FXQdC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jun 2013 12:33:02 -0400
Received: by mail-qa0-f45.google.com with SMTP id ci6so2400870qab.11
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jun 2013 09:33:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

on my Fujitsu Lifebook E753 I experienced some "regressions" with
current kernel versions compared to linux 3.5 (used in Ubuntu 12.04
for instance):
- on bootup backlight is extremely dark (I can change it though)
- the wireless button does not work any more
Today I did a bisect and found out, that the "regression" was
introduced with commit "a57f7f9175b8ccbc9df83ac13860488913115de4".
Searching the internet I read about a bootloader option
"acpi_osi="!Windows 2012" which solved the issue for me.
If you want/need some further information for a patch just tell me. I
don't have any insight into ACPI escpecially the new Windows8 changes
so if you can't do anything about it I apologize for the noise.

Regards

jhs
