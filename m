From: Andrew Morton <akpm@linux-foundation.org>
Subject: brightness control on thinkpad t61p
Date: Sun, 23 Dec 2007 00:00:57 -0800
Message-ID: <20071223000057.739d5891.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51892 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872AbXLWIBw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Dec 2007 03:01:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>


When I fire up the latest Linus tree on my thinkpad t61p I get:

thinkpad_acpi: ThinkPad ACPI Extras v0.17
thinkpad_acpi: http://ibm-acpi.sf.net/
thinkpad_acpi: ThinkPad BIOS 7LET44WW (1.14 ), EC 7KHT22WW-1.06
thinkpad_acpi: Lenovo ThinkPad T61p
thinkpad_acpi: radio switch found; radios are enabled
ACPI: Lid Switch [LID]
input: Sleep Button (CM) as /class/input/input6
ACPI: Sleep Button (CM) [SLPB]
thinkpad_acpi: standard ACPI backlight interface available, not loading native one...



and /sys/class/backlight/thinkpad_screen/brightness is no longer present, so
my `brightness' script no longer works.  That, my friends, is a regression.

Here's my script:

(
0 sh -c "echo $1 > /proc/acpi/sony/brightness"
0 sh -c "echo $1 > /proc/acpi/sony/brightness_default"
0 sh -c "echo $1 > /sys/class/backlight/sony/brightness"
0 sh -c "echo $1 > /sys/class/backlight/thinkpad_screen/brightness"
) 2>/dev/null

which rather shows how pathetic we are in this area.  Ho hum.


So I go hunting around and find

	/sys/class/backlight/acpi_video0/
and
	/sys/class/backlight/acpi_video1/

Why are there two of them?


Both of these have a `brightness' entry which has contents of 100.  When I set
that to 10, the screen's brightness is not reduced.

So as far as I can tell, we have lost the ability to alter the brightness of
the screen on this machine.


