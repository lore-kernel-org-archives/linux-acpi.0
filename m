From: James Simmons <jsimmons@infradead.org>
Subject: Re: [patch 1/5] video sysfs support - take 2: Add dev argument for
 backlight_device_register.
Date: Tue, 9 Jan 2007 17:05:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0701091705030.17932@pentafluge.infradead.org>
References: <200611080033.56035.luming.yu@gmail.com>
 <1167492935.5626.12.camel@localhost.localdomain>
 <3877989d0701090709n32f57048o495274849cbbf127@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:46052 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222AbXAIRHJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jan 2007 12:07:09 -0500
In-Reply-To: <3877989d0701090709n32f57048o495274849cbbf127@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>


> > To top it off, someone noticed some of the failures and fixed them but
> > nobody thought to fix the drivers in drivers/video/backlight itself and
> > a mac reference seems to have escaped too.
> 
> If my memory serves me well,  there is a patch for mac in mm.
> Not sure other drivers in video/backlight. But I should have sent it
> to some place.
> Need to check.

I sent a patch some time ago to Andrew Morton for the fbdev drivers in 
the video directory. I belive that patch is main stream now.

