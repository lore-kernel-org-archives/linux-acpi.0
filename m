From: Yu Luming <luming.yu@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Tue, 17 Oct 2006 01:45:03 +0800
Message-ID: <200610170145.03779.luming.yu@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061010161012.GA18847@lists.us.dell.com> <200610120028.29617.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:6632 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1161035AbWJPRr0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Oct 2006 13:47:26 -0400
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id k9GHl57G012133
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2006 17:47:18 GMT
Received: by py-out-1112.google.com with SMTP id n25so2455653pyg
        for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2006 10:45:32 -0700 (PDT)
In-Reply-To: <200610120028.29617.luming.yu@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>, len.brown@intel.com
Cc: Richard Hughes <hughsient@gmail.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

> > a generic ACPI driver that exports the _BCL and _BCM method
> > implementations via that same interface, so that systems providing
> > that will "just work".  drivers/acpi/video.c currently exports this
> > via /proc/acpi/video/$DEVICE/brightness, which isn't the same as
> > /sys/class/backlight. :-(
>
> Yes, I'm working on acpi video driver transition , and have posted a patch
> to user backlight for acpi video driver.
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115574087203605&w=2

Just updated the backlight and output sysfs support for ACPI Video driver on
bugzilla. If you are interested this, please take a look at
http://bugzilla.kernel.org/show_bug.cgi?id=5749#c18

signed-off-by 	Luming.yu@gmail.com

[patch 1/3] vidoe sysfs support: Add dev argument for baclight sys dev
[patch 2/3] Add display output class support
[patch 3/3] backlight and output sysfs support for acpi video driver

Thanks,
Luming
