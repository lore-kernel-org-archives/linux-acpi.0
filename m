From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Removing of useless printk in drivers/acpi/video.c
Date: Tue, 18 Sep 2007 13:43:16 -0400
Message-ID: <200709181343.16182.lenb@kernel.org>
References: <20070914201234.GT6339@bart.intergenia.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56362 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760439AbXIRRnd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 13:43:33 -0400
In-Reply-To: <20070914201234.GT6339@bart.intergenia.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maik Broemme <mbroemme@plusserver.de>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com

hmmm, thought we had deleted this already.
anyway, its applied.

thanks,
-Len

On Friday 14 September 2007 16:12, Maik Broemme wrote:
> Hi,
> 
> i am actually heavily using the ACPI video extension for my Thinkpad X61
> Tablet. I have bound the input events triggered by the brightness
> up/down keys to a simple
> 
> echo <value> > /sys/class/backlight/acpi_video1/brightness
> 
> but everytime the event is triggered and acpi_video_device_lcd_set_level()
> is called i got a notificication in my kernel log like:
> 
> set_level status: 0
> set_level status: 0
> set_level status: 0
> set_level status: 0
> ...
> 
> I have attached a patch to remove this one printk() i really don't know
> why it is needed. :)
> 
> --Maik
> 
