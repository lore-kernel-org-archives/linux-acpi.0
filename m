From: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Subject: Re: samsung x360, acpi support
Date: Sat, 6 Dec 2008 19:47:17 +0100
Message-ID: <200812061947.17897.mheinz@cs.uni-frankfurt.de>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de> <200812061828.29429.mheinz@cs.uni-frankfurt.de> <20081206173234.GA8400@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.rbi.informatik.uni-frankfurt.de ([141.2.1.1]:37385 "EHLO
	hera.rbi.informatik.uni-frankfurt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751042AbYLFSr1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Dec 2008 13:47:27 -0500
In-Reply-To: <20081206173234.GA8400@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Am Samstag, 6. Dezember 2008 schrieb Matthew Garrett:
> Oh, fail. Ok. Does writing a value into the /sys/class/backlight
> interface result in an interrupt in the i915_gem_interrupts file?

Before:
# cat /proc/dri/0/i915_gem_interrupt
Interrupt enable:    00000053
Interrupt identity:  00000000
Interrupt mask:      fffedfae
Pipe A stat:         00040000
Pipe B stat:         00400206
Interrupts received: 336
Current sequence:    13742
Waiter sequence:     0
IRQ sequence:        260

after
# echo 5 >  /sys/class/backlight/acpi_video0/brightness
# cat /proc/dri/0/i915_gem_interrupt
Interrupt enable:    00000053
Interrupt identity:  00000000
Interrupt mask:      fffedfae
Pipe A stat:         00040000
Pipe B stat:         00400206
Interrupts received: 336
Current sequence:    13836
Waiter sequence:     0
IRQ sequence:        260


If you mean it this way...
