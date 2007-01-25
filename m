From: Corentin CHARY <corentincj@iksaif.net>
Subject: [patch 0/7] New misc/asus-laptop.c driver
Date: Thu, 25 Jan 2007 12:54:33 +0100
Message-ID: <200701251254.34491.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:35130 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbXAYLyh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jan 2007 06:54:37 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Hi,
I've done a lot of work on asus_acpi, see :

diff asus_acpi.c asus-laptop.c -u | diffstat
 asus-laptop.c | 1663 
++++++++++++++++++++++++----------------------------------
 1 file changed, 711 insertions(+), 952 deletions(-)

So because the new driver work in a very different way, and have a new 
interface (no more /proc/acpi/asus/), I think it's time for 
misc/asus-laptop.c, but we should also keep asus_acpi.c for sometime.

In asus_acpi, we had to add all models by hand, and the list was growing very 
fast... The new detection system is inspired by ibm-acpi (we search well 
known acpi method, and if we found one then the feature is available).

Now leds are handled by /sys/class/led/asus:*/ , backlight 
with /sys/class/backlight/asus-laptop/ .
asus-laptop is now a platform driver, so files like wlan, bluetooth, 
ls_switch, ls_level, info, etc .. are now 
in /sys/devices/platform/asus-laptop/ .

These patch are designed to apply to  acpi-test-20060707-2.6.20-rc4, but as 
it's a new driver, it's easy to apply against other trees.

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
