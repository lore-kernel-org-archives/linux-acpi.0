From: Yu Luming <luming.yu@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Tue, 10 Oct 2006 23:17:23 +0800
Message-ID: <200610102317.24310.luming.yu@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org> <20061002132549.9d164061.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:26191 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750851AbWJJPR3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 11:17:29 -0400
Received: by py-out-1112.google.com with SMTP id n25so2858073pyg
        for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2006 08:17:29 -0700 (PDT)
In-Reply-To: <20061002132549.9d164061.alessandro.guido@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

> I use this tool: http://www.xs4all.nl/~bsamwel/laptop_mode/tools/
> that automagically fires up whenever needed
>
> $ cat /etc/laptop-mode/batt-start/brightness
> #!/bin/sh
> echo -n CHOOSE_A_LOW_VALUE > /sys/class/backlight/sony/brightness

Also, we need to make hot-key events  have similar handling code .
For example, Fn+F5 and Fn+F6 are brightness down and up key on my sony laptop.  
There is a driver called sonypi.c can map Fn+F5/F6 to KEY_FN_F5/F6. But I 
think It should be mapped to KEY_BRIGHTNESSDOWN/UP (linux/input.h)
Although, sonypi.c is NOT so clean, but , if it can report right event to 
input layer for all sony laptop(it works for me), and all related functions 
can be controlled through generic sysfs interface, then I would say sony has 
the best hot-key solution I have even seen so far for linux.

Thanks,
Luming.



