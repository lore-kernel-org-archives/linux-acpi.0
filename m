From: nmn@nathanielmnelson.com
Subject: [PATCH] platform-driver-x86: toshiba_hdaps (new) (3.8.10)
Date: Sun, 28 Apr 2013 22:42:16 -0700
Message-ID: <fdc446a704647f251072e94517f5fa2e.squirrel@webmail.nathanielmnelson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello all, I've created a patch that enables support for the TOS620A device,
an accelerometer device on many Toshiba laptops to detect hard drive shock.
Included is a pretty simple ACPI module and will send out notifications via
netlink and procfs when the detected state changes.

This module will send a value of 0x80 when vibration is detected from the
HDAPS device, and 0x81 when the laptop has been stable for about 1-2 seconds.
There are 3 different levels of sensitivity set explicitly in ACPI.  These are
essentially 'low', 'medium', and 'high'. (1, 2, 3 respectively).

For the actual parking of the hard drive heads, I then use two separate ACPI2
event files.  The first is triggered when vibration is detected:

event=HAPS 00000080
action=echo 30000 > /sys/block/sd?/device/unload_heads

and to reset:

event=HAPS 00000081
action=echo 0 > /sys/block/sd?/device/unload_heads

It creates 2 sysfs attributes.  The first is 'status', which just returns 1 if
the device exists and everything is cool.  The second is 'protlevel' which is
RW and allows you to view the current protection level or set a new level.

Since it is a full module patch, I've included a link to download.  Please let
me know what you think.  Thanks!

Signed off by: Nate Nelson <nmn@nathanielmnelson.com>
---
http://www.nathanielmnelson.com/sites/default/files/toshiba_hdaps-3.8.10.patch
