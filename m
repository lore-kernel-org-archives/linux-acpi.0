From: =?ISO-8859-15?Q?Robert_W=F6rle?= <robert@linuxdevelopment.de>
Subject: Black screen-dead unit on S3 resume - Intel Atom
Date: Sat, 27 Mar 2010 14:00:20 +0100
Message-ID: <4BAE0164.9060503@linuxdevelopment.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50615 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab0C0NAF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Mar 2010 09:00:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear List

I am approaching this list now as one of my last hopes i ve to fix S3 on 
Intel Atom based Tablet PC.

The overall description of the situation is as follows.

- entereing into S3 via "echo mem > /sys/power/state will result in a 
suspend into the bios which is comparable to the one when running windows.
The acitivity led starts blinking and it sits there. Power consumption 
measurments show the equally amounts of mA take.

The system then reacts on the power button only with a changing power 
led to static. ( after around 1 sec)
But that is all i can get as reaction.
No hdd activity at all.

So it stucks on the resume situation as early as acpi calls the waking 
vektor. That is my assumption.

Tests taken :
- All /sys/power/pm_test  `scenarios runs fine without any obvious issue.
- All test are done with mininal system scenario with only hdd, usb and 
framebuffer drivers compiled in.
- s3_beep kernel option also doesnt beep on resume , beepdriver is 
compiled in.
- testet various options, like acpi old_ordering, rsdt, sci_force_enable 
and some more
- most tests where done on 2.6.34-rc1.  but others where with 2.6.27 
(openSuse 11.1) and 2.6.20

I am about to recieve a ami bios post code - debug card. That one should 
help to determine the bios side.

So i am stuck without any further debug information beside the dmesg 
from the bootet system and the pm_test runs.


I can attach or mail any log you guys want me to. Also i ve all acpidump 
`ed tables

Any hints, help or suggstions are welcome at this point.

Regards Rob


