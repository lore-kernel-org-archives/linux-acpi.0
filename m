From: "Khashayar Naderehvandi" <khashayar.lists@gmail.com>
Subject: Re: [Bugme-new] [Bug 12235] New: /sys/devices/virtual/backlight/acpi_video0/brightness has it backwards
Date: Wed, 17 Dec 2008 10:44:40 +0100
Message-ID: <fca60f3a0812170144w5f77c4d2p868109def1ff8f6a@mail.gmail.com>
References: <bug-12235-10286@http.bugzilla.kernel.org/>
	 <20081216100023.2e437c8c.akpm@linux-foundation.org>
	 <20081216205532.GB14332@srcf.ucam.org>
	 <1229475456.562.5.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:32880 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbYLQJom (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Dec 2008 04:44:42 -0500
Received: by bwz14 with SMTP id 14so5215926bwz.13
        for <linux-acpi@vger.kernel.org>; Wed, 17 Dec 2008 01:44:40 -0800 (PST)
In-Reply-To: <1229475456.562.5.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bugme-daemon@bugzilla.kernel.org" <bugme-daemon@bugzilla.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, Dec 17, 2008 at 1:57 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Wed, 2008-12-17 at 04:55 +0800, Matthew Garrett wrote:
>> On Tue, Dec 16, 2008 at 10:00:23AM -0800, Andrew Morton wrote:
>>
>> > OK, that's weird.  I have a suspicion that we're about to find out that
>> > this is intentional, but I don't know what the fix is..
>>
>> My recollection is that some BIOSes provide the list of brightness
>> values in reverse order - someone posted a patch to sort them in-kernel,
>> but I can't remember what happened to it. xbacklight will work because
>> it triggers a direct write to the hardware if the acpi driver isn't
>> loaded.
>>
> right, this seems to be a duplicate of
> http://bugzilla.kernel.org/show_bug.cgi?id=12037
>
> khashayar,
> please attach the result of "grep . /proc/acpi/video/*/*/*".
> please try the patch in
> http://bugzilla.kernel.org/show_bug.cgi?id=12037#c5
> and see if it helps.
>
Here's the output of "grep . /proc/acpi/video/*/*/*". The video module
wasn't loaded at boot time, but just before greping. I don't know if
that has any relevance. Also, there's an external display attached at
this point.

/proc/acpi/video/VGA/CRTD/brightness:<not supported>
/proc/acpi/video/VGA/CRTD/EDID:<not supported>
/proc/acpi/video/VGA/CRTD/info:device_id:    0x0100
/proc/acpi/video/VGA/CRTD/info:type:         CRT
/proc/acpi/video/VGA/CRTD/info:known by bios: yes
/proc/acpi/video/VGA/CRTD/state:state:     0x1d
/proc/acpi/video/VGA/CRTD/state:query:     0x00
/proc/acpi/video/VGA/DVID/brightness:<not supported>
/proc/acpi/video/VGA/DVID/EDID:<not supported>
/proc/acpi/video/VGA/DVID/info:device_id:    0x0321
/proc/acpi/video/VGA/DVID/info:type:         DVI
/proc/acpi/video/VGA/DVID/info:known by bios: yes
/proc/acpi/video/VGA/DVID/state:state:     0x1d
/proc/acpi/video/VGA/DVID/state:query:     0x00
/proc/acpi/video/VGA/HDMI/brightness:<not supported>
/proc/acpi/video/VGA/HDMI/EDID:<not supported>
/proc/acpi/video/VGA/HDMI/info:device_id:    0x7320
/proc/acpi/video/VGA/HDMI/info:type:         DVI
/proc/acpi/video/VGA/HDMI/info:known by bios: yes
/proc/acpi/video/VGA/HDMI/state:state:     0x1d
/proc/acpi/video/VGA/HDMI/state:query:     0x00
/proc/acpi/video/VGA/LCDD/brightness:levels:  100 91 86 81 76 70 65 60
55 50 45 40 35 30 25 20
/proc/acpi/video/VGA/LCDD/brightness:current: 86
/proc/acpi/video/VGA/LCDD/EDID:<not supported>
/proc/acpi/video/VGA/LCDD/info:device_id:    0x0410
/proc/acpi/video/VGA/LCDD/info:type:         LCD
/proc/acpi/video/VGA/LCDD/info:known by bios: yes
/proc/acpi/video/VGA/LCDD/state:state:     0x1d
/proc/acpi/video/VGA/LCDD/state:query:     0x00


I will try the patch as soon as I can, and get back to you.

> thanks,
> rui
>
Thank you,
Khash.
