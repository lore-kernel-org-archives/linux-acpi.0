From: Hans de Goede <hdegoede@redhat.com>
Subject: Backlight control broken on Lenovo Ideapad Z570
Date: Wed, 18 Mar 2015 14:12:06 +0100
Message-ID: <550979A6.20306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35438 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962AbbCRNMJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2015 09:12:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stepan Bujnak <stepanbujnak@fastmail.fm>
Cc: be.0@gmx.com, linux-acpi <linux-acpi@vger.kernel.org>

Hi Stepan,

I'm mailing you because you are the author of:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a11d342f

I've been debugging the same problem together with a Fedora user:
https://bugzilla.redhat.com/show_bug.cgi?id=1187004

And for him your fix does not work, before your fix landed we already
came to the conclusion that to fix this we need to disable both the
acpi_video backlight interface as well as the ideapad-laptop interface.

Your patch only disables the acpi_video backlight interface (and as
a side effect actually enables the ideapad-laptop interface).

I assume that you've a working backlight setup on your Lenovo Ideapad Z570,
can you please do:

ls /sys/class/backlight

And let us know which interfaces show up there. Either you do have a working
ideapad_laptop interface, or you only get intel_backlight and for some reason
ideapad_laptop is not loading on your system (not enabled in your kernel config,
or blacklisted?).

If you only have intel_backlight then that explains why things are not working
for Be (the author of the Fedora bugreport), if you do have an ideapad_laptop
interface and that does work for you, then it seems that not all
Lenovo Ideapad Z570-s are created equal. In that case can you please blacklist
the ideapad-laptop module, reboot and see if things still work for you when
using intel_backlight to control the backlight? Once we've a confirmation
that either you are already using intel_backlight, or that intel_backlight also
works on your Ideapad, then I'll write a patch to replace yours which leaves
only intel_backlight even if the ideapad-laptop driver gets loaded.

Thanks & Regards,

Hans
