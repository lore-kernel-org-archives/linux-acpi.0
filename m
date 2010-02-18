From: Pedro Ribeiro <pedrib@gmail.com>
Subject: T400 does not enter C4/C6 sleep state with USB devices connected
Date: Thu, 18 Feb 2010 13:39:42 +0000
Message-ID: <74fd948d1002180539xc1ff413mb3c8a600e6d85d50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50423 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab0BRNjo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Feb 2010 08:39:44 -0500
Received: by ewy19 with SMTP id 19so6846456ewy.21
        for <linux-acpi@vger.kernel.org>; Thu, 18 Feb 2010 05:39:42 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I spent lots of hours trying to figure out why my T400 would not enter
C4 and C6 sleep states.

Here are my findings:

- When a USB device is connected, even if it supports USB autosuspend,
the cpu will never go down more than C3 (apparently the mode is
disabled by the BIOS).

- After removing all the USB devices, in AC it enters C4 and in
battery it enters C6.
The BIOS apparently replaces C3 with C4 and C6, respectively, because
/sys/devices/system/cpu/cpu0/cpuidle/

always shows 4 states, whatever the situation.

So one more reason not to use USB devices while on battery...

Is this normal behaviour or I have a retarded BIOS? And if so, is
there a workaround?

(please mail directly to me as in not in the linux-acpi list)

Regards,
Pedro
