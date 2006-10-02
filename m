From: Alessandro Guido <alessandro.guido@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi
 driver
Date: Mon, 2 Oct 2006 13:25:49 +0200
Message-ID: <20061002132549.9d164061.alessandro.guido@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
	<20061001171912.b7aac1d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:36872 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750922AbWJBLX1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Oct 2006 07:23:27 -0400
Received: by py-out-1112.google.com with SMTP id n25so2464864pyg
        for <linux-acpi@vger.kernel.org>; Mon, 02 Oct 2006 04:23:26 -0700 (PDT)
In-Reply-To: <20061001171912.b7aac1d8.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

On Sun, 1 Oct 2006 17:19:12 -0700
Andrew Morton <akpm@osdl.org> wrote:
> 
> umm, OK, but now how do I adjust my screen brightness? ;)
> 
> I assume that cute userspace applications for controlling backlight
> brightness via the generic backlight driver either exist or are in
> progress?  What is the status of that?
> 

I use this tool: http://www.xs4all.nl/~bsamwel/laptop_mode/tools/
that automagically fires up whenever needed

$ cat /etc/laptop-mode/batt-start/brightness 
#!/bin/sh
echo -n CHOOSE_A_LOW_VALUE > /sys/class/backlight/sony/brightness

and

$ cat /etc/laptop-mode/batt-stop/brightness 
#!/bin/sh
let val="`</proc/acpi/sony/brightness_default` - 1"
echo -n "$val" > /sys/class/backlight/sony/brightness

But I seldom use my laptop in battery mode.

> I assume that cute userspace applications for controlling backlight
> brightness via the generic backlight driver either exist or are in
> progress?  What is the status of that?
> 

I think the new gnome-power-manager does it, but I'm not sure since I use Xfce.

> Thanks.

Thank you.
