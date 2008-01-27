From: Bruno =?iso-8859-1?q?Pr=E9mont?= <bonbons@linux-vserver.org>
Subject: Troubles waking up from suspend (S3) - how to debug?
Date: Sun, 27 Jan 2008 18:42:37 +0100
Message-ID: <200801271842.38007.bonbons@linux-vserver.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757949AbYA0SIU@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

I'm currently trying out suspend (S3) on a few machines but none of them wakes 
up completely/properly (I have a few more hosts I'm planning to try suspend 
on once I can get useful information out of those not waking up properly).

Tested kernels: 2.6.24(-rc8), on one 2.6.23.8

To suspend I enter the following from console:
  echo -n mem > /sys/power/state


Fujitsu-Siemens S7020 laptop (i915GM based):
  Works fine except backlight that remains asleep and Xorg vesa driver
  crashing Xorg.
  It looks like a suspend cycle discards the VideoBIOS shadow copy.
  Adjusting brightness using hotkeys or acpi-fujitsusiemens does not help
  waking up the backlight.
  At best backlight comes back when suspending from Xorg with
  xf86-video-intel-2.2.x but then mode is distorded. Any attempt to fix this
  using xrandr or switch to/from console puts backlight asleep.


Acer Travelmate 660 laptop (i855GM based):
  Laptop suspends as expected but hangs while waking up.


Desktop with MSI nforce based mainboard with Athlon CPU, onboard graphics and 
hdd on HighPoint RR1640 PCI card (USB mouse & keyboard):
  Suspends as expected but hangs while waking up.
  During wakeup I can ping the computer but userspace does not respond (e.g.
  no answer when trying to connect via ssh)
  The display remains off if using vga text console, display comes back with
  garbadge when using nvidiafb (no Xorg running), USB is powered but triggers
  no reactions on keyboard/mouse input


I tried using netconsole on the desktop computer to capture eventual printks 
during resume but I got not a line during wakup. (only suspend progress 
messages before actual suspend)

What can I do to get more information out of those two last machines and find 
out why they don't wake-up properly?


I can provide more details on each of those machines if it can help (lspci, 
kernel config, peripherials, acpidump)

Regards,
Bruno
