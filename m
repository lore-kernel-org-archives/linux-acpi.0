From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the
	sony_acpi driver
Date: Tue, 10 Oct 2006 15:47:26 +0100
Message-ID: <1160491646.6174.36.camel@hughsie-laptop>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
	 <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com>
	 <200610102232.46627.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:54462 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750811AbWJJOzX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 10:55:23 -0400
Received: by ug-out-1314.google.com with SMTP id o38so760003ugd
        for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2006 07:55:21 -0700 (PDT)
In-Reply-To: <200610102232.46627.luming.yu@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@gmail.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

On Tue, 2006-10-10 at 22:32 +0800, Yu Luming wrote:
> >From my understanding, a cute userspace App shouldn't have this kind
> of logic:
>         if (is  DELL )
>                 invoke libsmbios
>         if (is  foo)
>                 invoke libfoo,
>         if (is bar)
>                 invoke libbar,
>         ....
>         else
>                 operate on /sys/class/backlight/ ,.,..

This is what HAL has at the moment[1]. And it's hell to maintain, but
works for a lot of users.

> It should be:
>         just write/read  file in  /sys/class/backlight ,....

That would make things much easier IMO.

Richard.

[1]
http://gitweb.freedesktop.org/?p=hal.git;a=blob;h=3ff9284be440a7197b0de9b5f0234761c3397cb1;hb=dbffafacbf7b9143d82547b9eabe61d1a5b8fffc;f=tools/linux/hal-system-lcd-get-brightness-linux

