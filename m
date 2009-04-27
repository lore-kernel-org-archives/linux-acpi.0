From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: acpi 'video' driver, and issues with 'brightness_switch_enabled=0'
Date: Mon, 27 Apr 2009 20:57:32 +0300
Message-ID: <1240855052.11237.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758647AbZD0R5u@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

I have a notebook which handles brightness keys in hardware, but tells
loudly when it does so.

Currently, acpi 'video' also sets the brightness, which result in double
setting, and on top of that it emits a key that makes gpm set brightness
again.

And (yes...) on top of that keyboard emits a brightness up/down even,
which (you guessed...) sets brightness again.

I found out that it is possible to tell gnome-power-manager not to set
brightness, but yet in kernel driver still sets it.

I found out even earlier that I can use brightness_switch_enabled=0,
which supposed to make inkernel driver not touch the brightness.
But I found out that this driver won't update the brightness, in /sys
interface when I set this param.

So what you can suggest here?

Regards,
	Maxim Levitsky
